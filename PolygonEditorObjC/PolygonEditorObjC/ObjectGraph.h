//
//  ObjectGraph.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import "BBox.h"
#import "Pointer.h"
#import "Color.h"
#import "Transform.h"
#import "TypeTransform.h"
#import <GLUT/GLUT.h>

@interface ObjectGraph : NSObject {
@private
    Color * color;
	Transform * transform;
	BOOL modeEdition;
	BOOL showBbox;
@protected
	BBox * bbox;
	NSMutableArray * points;
	NSUInteger indexHighlights;	
}

@property (assign) NSMutableArray * points;
@property (assign) Transform * transform;
@property (assign) Color * color;
@property (assign) BBox * bbox;
@property (assign) BOOL modeEdition;
@property (assign) BOOL showBbox;
@property (assign) NSUInteger indexHighlights;

- (void) drawColor;
- (void) start;
- (void) draw;
- (void) addPoint: (Pointer *) value;
- (void) initBBox: (Transform *) value;
- (void) nextPointHighlights;
- (void) setPointHighlights: (Pointer *) value;
- (Pointer *) getPointHighlights;
//- (void) savePointHighlights;
- (void) deleteActualPoint;
- (void) showBBox;


@end