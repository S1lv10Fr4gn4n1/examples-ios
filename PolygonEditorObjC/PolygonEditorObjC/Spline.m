//
//  Spline.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 17/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Spline.h"


@implementation Spline

@synthesize initialized;
@synthesize pointsReference;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		self.pointsReference = [[NSMutableArray alloc] init];
		self.initialized = 0;
    }
    
    return self;
}

- (void)dealloc
{
	[self.pointsReference release];
    [super dealloc];
}

- (void) start
{
	if ([pointsReference count] == 0) {
		for (int i = 0; i < 4; ++i) {
			[pointsReference addObject: [points objectAtIndex: i]];
		}
	}
	
	// guarda os pontos de referencia
	for (int i = 0; i < [pointsReference count]; ++i) {
		[pointsReference removeObjectAtIndex: i];
		[pointsReference insertObject: [points objectAtIndex: i] atIndex: i];
	}
	
	[points removeAllObjects];
	
	[points addObject: [pointsReference objectAtIndex: 0]];
	[points addObject: [pointsReference objectAtIndex: 1]];
	[points addObject: [pointsReference objectAtIndex: 2]];
	[points addObject: [pointsReference objectAtIndex: 3]];
	
	
	// monta os pontos da spline
	float x, y, t;
	float a, b, c, d;
	
	for (int i = 0; i <= 30; i++) {
		t =  (float) (i) / 30;
		a = pow((1 - t), 3);
		b = 3 * t * pow((1 - t), 2);
		c = 3 * pow(t, 2) * (1 - t);
		d = pow(t, 3);
		
		x = (a * [[points objectAtIndex: 0] x]) + 
			(b * [[points objectAtIndex: 1] x]) + 
			(c * [[points objectAtIndex: 2] x]) + 
			(d * [[points objectAtIndex: 3] x]);
		y = (a * [[points objectAtIndex: 0] y]) + 
			(b * [[points objectAtIndex: 1] y]) + 
			(c * [[points objectAtIndex: 2] y]) + 
			(d * [[points objectAtIndex: 3] y]);
		
		
		Pointer * p = [[Pointer alloc] init:x :y :0.0f :1.0f];
		[p autorelease];
		[points addObject: p];
	}
	
	[super start];
	
	self.initialized = 1;
}

- (void) draw
{
	if (!self.initialized) {
		[self paintReferences];
		return;
	}
	
	[super draw];
	
	glBegin(GL_LINE_STRIP);
	// comeca do 4, pois os 4 primeiros pontos sao os pontos
	// que dao origem a spline
	for (int i = 4; i < [points count]; i++) {
		Pointer * point = [points objectAtIndex: i];
		glVertex2f([point x], [point y]);
	}
	glEnd();
	
}

// metodo sobrescrito para poder disponibilizar somente os pontos
// corretos para edicao
- (void) nextPointHighlights
{
//	indexHighlights = (indexHighlights + 1) % pointsReference.size();
}

// metodo responsavel por desenhar as linhas guias do spline
- (void) paintReferences
{
	glLineWidth(2.0f);
	glColor3b(1.0f, 1.0f, 1.0f);
	glBegin(GL_LINE_STRIP);

	for (int i = 0; i < [points count]; i++) {
		Pointer * point = [points objectAtIndex: i];
		glVertex2f([point x], [point y]);
	}
	glEnd();
	glLineWidth(1.0f);

}


@end
