//
//  World.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ObjectGraph.h"

@interface World : NSObject {
@private
	NSMutableArray * objsGraph;
	
	int width;
	int height;
	
	double left;
	double right;
	double top;
	double bottom;
	
	// utilizados para o PAN e zoom, fator de incremento
	float incLeft;
	float incRight;
	float incTop;
	float incBottom;
   
}

@property (assign) NSMutableArray * objsGraph;
@property (assign) int width;
@property (assign) int height;
@property (assign) double left;
@property (assign) double right;
@property (assign) double top;
@property (assign) double bottom;
@property (assign) float incLeft;
@property (assign) float incRight;
@property (assign) float incTop;
@property (assign) float incBottom;

- (void) addObjsGraph: (ObjectGraph *) obj;
- (void) northPAN;
- (void) westPAN;
- (void) southPAN;
- (void) eastPAN;
- (void) zoomIn;
- (void) zoomOut;
- (void) deleteAllObjects;
- (void) deleteObject: (ObjectGraph *) obj;
- (void) recalculateWorldDimension: (int) _width: (int) _heigth;

@end
