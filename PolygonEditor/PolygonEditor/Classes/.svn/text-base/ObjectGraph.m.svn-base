//
//  ObjectGraph.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectGraph.h"

@interface ObjectGraph()
- (void)paintBBox;
@end


@implementation ObjectGraph

@synthesize points;
@synthesize transform;
@synthesize bbox;
@synthesize modeEdition;

- (id)init
{
    self = [super init];
    if (self) {
		// inicializacao dos objetos que o objeto grafico ira necessitar
		transform = [[Transform alloc] init];
		points = [[NSMutableArray alloc] init];
		bbox = [[BBox alloc] init];
		color = [[Color alloc] init];
		showBbox = NO;
		self.modeEdition = NO;
		indexHighlights = 0;
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
    static const GLubyte squareColors[] = {
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
        255, 255, 255, 255,
    };

    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);
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
    //[self paintBBox];
	//[self drawColor];
    
    float vertex[[points count] * 2];
    
	for (int i = 0; i < [points count]; i++) {
		Pointer * p = [points objectAtIndex: i];
        vertex[i*2+0] = [p x];
        vertex[i*2+1] = [p y];
	}
    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertex);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    glDrawArrays(GL_POINTS, 0, [points count]);
    
}

/// metodo responsavel por adicionar point no vector de point do objeto grafico
- (Boolean) addPoint: (Pointer *) value 
{
	[points addObject: value];
	return true; //por padrao sempre aceita mais pontos
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

- (void)paintBBox
{   
    GLfloat vertexPoint[2];
    
    // pintando os pontos
    for(Pointer *p in points) {
        vertexPoint[0] = [p x];
        vertexPoint[1] = [p y];
        
        glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertexPoint);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        glDrawArrays(GL_POINTS, 0, 1);
    }
    
    //sfs
    // pinta o ponto atual em destaque 
//    Pointer * actualPoint = [self getPointHighlights];
    
//    if (actualPoint != 0) {
//        glPointSize(13.0f);
//        glColor3b(0.0f, 1.0f, 0.0f);
//        glBegin(GL_POINTS);
//        glVertex2f([actualPoint x], [actualPoint y]);
//        glEnd();
//    }
        
    if (showBbox) {
        // pintando a bbox
        GLfloat vertexBBox[] = {
            [bbox xMax], [bbox yMax],
            [bbox xMax], [bbox yMin],
            [bbox xMin], [bbox yMin],
            [bbox xMin], [bbox yMax],
        };
        
        glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertexBBox);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        glDrawArrays(GL_LINE_LOOP, 0, 4);
    }
}

@end