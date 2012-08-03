//
//  BBox.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Pointer.h"

@interface BBox : NSObject {
	float xMin;
	float xMax;
	
	float yMin;
	float yMax;
	
	float zMin;
	float zMax;    
}

@property (assign) float xMin;
@property (assign) float xMax;
@property (assign) float yMin;
@property (assign) float yMax;
@property (assign) float zMin;
@property (assign) float zMax;

- (void)start;

- (BOOL)inBBox:(float)x:(float)y:(float)z;
- (BOOL)inBBox:(Pointer *)value;

@end