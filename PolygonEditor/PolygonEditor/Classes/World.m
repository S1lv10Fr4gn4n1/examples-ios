//
//  World.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "World.h"


@implementation World

@synthesize  objsGraph;
@synthesize  width;
@synthesize  height;
@synthesize  left;
@synthesize  right;
@synthesize  top;
@synthesize  bottom;
//@synthesize  incLeft;
//@synthesize  incRight;
//@synthesize  incTop;
//@synthesize  incBottom;


- (id)init
{
    self = [super init];
    if (self) {
		objsGraph = [[NSMutableArray alloc] initWithCapacity: 10];
		incLeft   = 5;
		incRight  = 5;
		incTop    = 5;
		incBottom = 5;
		
		self.width = 2; 
        self.height =  2;
		self.left  = self.bottom = -1;
		self.top   = self.right  =  1;
    }
    
    return self;
}

- (void)dealloc
{
	[objsGraph removeAllObjects];
	[objsGraph release];
    [super dealloc];
}

- (void) addObjsGraph: (ObjectGraph *) obj
{
	[objsGraph addObject: obj];
}

- (void) northPAN
{
	top    -= 5;
	bottom -= 5;
}

- (void) westPAN
{
	left  += 5;
	right += 5;
}

- (void) southPAN
{
	top    += 5;
	bottom += 5;
}

- (void) eastPAN
{
	left  -= 5;
	right -= 5;
}

- (void) zoomIn
{
	left   += incLeft;
	right  -= incRight;
	top    -= incTop;
	bottom += incBottom;
}

- (void) zoomOut
{
	left   -= incLeft;
	right  += incRight;
	top    += incTop;
	bottom -= incBottom;
}

- (void) deleteAllObjects
{
	[objsGraph removeAllObjects];
}

- (void) deleteObject: (ObjectGraph *) obj
{
	
	for (NSObject * o in [self objsGraph]) {
		if (o == obj) {
			[objsGraph removeObject: o];
			[o release];
		}
	}
}

- (void) recalculateWorldDimension: (int) _width: (int) _heigth
{
	// calculando a proporcao de x e y
	double x = _width /  (double) width;
	double y = _heigth / (double) height;
	
	// ajustando os atributos de dimencao da tela do objeto World
	// conforme as proporcoes x e y calculas
	left   = left   * x;
	right  = right  * x;
	bottom = bottom * y;
	top    = top    * y;
	
	// ajustando os atributos de incremento do objeto World
	incLeft = incLeft * x;
	incRight = incRight * x;
	incBottom = incBottom * y;
	incTop = incTop * y;
	
	// atualiza os valores de largura e altura da tela
	width  = _width;
	height = _heigth;	
}


@end
