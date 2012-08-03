//
//  ObjectGraph.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectGraph.h"


@implementation ObjectGraph

@synthesize points;
@synthesize transform;
@synthesize color;
@synthesize bbox;
@synthesize modeEdition;
@synthesize showBbox;
@synthesize indexHighlights;

- (id)init
{
    self = [super init];
    if (self) {
		// inicializacao dos objetos que o objeto grafico ira necessitar
		self.transform = [[Transform alloc] init];
		self.points = [[NSMutableArray alloc] init];
		self.bbox = [[BBox alloc] init];
		self.color = [[Color alloc] init];
		self.showBbox = NO;
		self.modeEdition = NO;
		self.indexHighlights = 0;
    }
    
    return self;
}

- (void)dealloc
{
	[transform release];
	[bbox release];
	[color release];
	[points removeAllObjects];
	[points release];
    [super dealloc];
}

/// metodo responsavel por setar a cor no objeto grafico
- (void) drawColor 
{
//	glColor3b([self.color r], [self.color g], [self.color b]);
	glColor3b(1, 1, 1);
}


/// metodo responsavel por fazer inicializacoes necessarias antes de desenhar o objeto,
/// exemplo o calculo para gerar a circunferencia. 
- (void) start 
{
	// inicializa os valores da bbox
	[self initBBox: transform];
}

/// metodo responsavel por desenhar o objeto em si
/// nessa classe mais abstrata, tem o desenho da bbox para todos
/// os objetos que herdarem dela.
- (void) draw 
{
	if (modeEdition) {
		glColor3b(1.0f, 1.0f, 1.0f);
		
		// pintando os pontos
		glPointSize(5.0f);
		glBegin(GL_POINTS);
		for(Pointer *p in points) {
			glVertex2f([p x], [p y]);
		}
		glEnd();
		
		// pinta o ponto atual em destaque 
		Pointer * actualPoint = [self getPointHighlights];
		
		if (actualPoint != 0) {
			glPointSize(13.0f);
			glColor3b(0.0f, 1.0f, 0.0f);
			glBegin(GL_POINTS);
			glVertex2f([actualPoint x], [actualPoint y]);
			glEnd();
		}
		
		if (showBbox) {
			// pintando a bbox
			glColor3b(1.0f, 1.0f, 1.0f);
			glBegin(GL_LINE_LOOP);
			glVertex2f([bbox xMax], [bbox yMax]);
			glVertex2f([bbox xMax], [bbox yMin]);
			glVertex2f([bbox xMin], [bbox yMin]);
			glVertex2f([bbox xMin], [bbox yMax]);
			glEnd();
		}
	}
	
	[self drawColor];

}

/// metodo responsavel por adicionar point no vector de point do objeto grafico
- (void) addPoint: (Pointer *) value 
{
	[points addObject: value];
	
}

/// metodo responsavel por inicializar os valores da bbox, determinado pelos
/// pontos pertencente ao objeto grafico
- (void) initBBox: (Transform *) value 
{
	
	[self.bbox start];
	
	for(int i=0; i < [self.points count]; i++) {
		
		Pointer * point = [points objectAtIndex: i];
		
		point = [value transformPoint: point];
		
//		#if DEBUG
//			NSLog(@"bbox:point: x: %f, y: %f", [point x], [point y]);
//		#endif
		
		//definindo o maior X
		if ([point x] > [bbox xMax]) {
			[bbox setXMax: [point x]];
		}
		
		//definindo o menor X
		if ([point x] < [bbox xMin]) {
			[bbox setXMin: [point x]];
		}
		
		//definindo o maior Y
		if ([point y] > [bbox yMax]) {
			[bbox setYMax: [point y]];
		}
		
		//definindo o menor Y
		if ([point y] < [bbox yMin]) {
			[bbox setYMin: [point y]];
		}
	}

}

- (void) nextPointHighlights
{
	indexHighlights = (indexHighlights + 1) % [points count];
}

// sobrescreve o ponto em destaque
- (void) setPointHighlights: (Pointer *) value
{
	[points removeObject: [points objectAtIndex: indexHighlights]];
	[points insertObject: value atIndex: indexHighlights];
}

- (Pointer *) getPointHighlights
{
	return [points objectAtIndex: indexHighlights];
}

- (void) deleteActualPoint
{
	for (int i = 0; i < [points count]; ++i) {
		if ([points objectAtIndex: i] == [points objectAtIndex: indexHighlights]) {
			[points removeObject: [points objectAtIndex: i]];
			return;
		}
	}

}

- (void) showBBox
{
	showBbox = !showBbox;	
}

@end