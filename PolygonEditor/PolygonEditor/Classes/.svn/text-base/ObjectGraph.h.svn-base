//
//  ObjectGraph.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "BBox.h"
#import "Pointer.h"
#import "Color.h"
#import "Transform.h"
#import "TypeProgram.h"

@interface ObjectGraph : NSObject {
@private
	Transform * transform;
	BOOL modeEdition;
	BOOL showBbox;
@protected
    Color * color;
	BBox * bbox;
	NSMutableArray * points;
	unsigned int indexHighlights;	
}

@property (assign) NSMutableArray * points;
@property (assign) Transform * transform;
@property (assign) BBox * bbox;
@property (assign) BOOL modeEdition;

- (void)drawColor;
- (void)start;
- (void)draw;
- (Boolean)addPoint:(Pointer *)value;
- (void)initBBox:(Transform *)value;
- (void)nextPointHighlights;
//- (void)setPointHighlights:(Pointer *)value;
- (Pointer *)getPointHighlights;
- (void)deleteActualPoint;
- (void)showBBox;


@end