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

@property (nonatomic, assign) NSMutableArray * objsGraph;
@property (nonatomic, assign) int width;
@property (nonatomic, assign) int height;
@property (nonatomic, assign) double left;
@property (nonatomic, assign) double right;
@property (nonatomic, assign) double top;
@property (nonatomic, assign) double bottom;
//@property (nonatomic, assign) float incLeft;
//@property (nonatomic, assign) float incRight;
//@property (nonatomic, assign) float incTop;
//@property (nonatomic, assign) float incBottom;

- (void) addObjsGraph: (ObjectGraph *) obj;
//- (void) northPAN;
//- (void) westPAN;
//- (void) southPAN;
//- (void) eastPAN;
//- (void) zoomIn;
//- (void) zoomOut;
- (void) deleteAllObjects;
- (void) deleteObject: (ObjectGraph *) obj;
//- (void) recalculateWorldDimension: (int) _width: (int) _heigth;

@end
