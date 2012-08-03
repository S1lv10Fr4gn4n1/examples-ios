//
//  Spline.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 17/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectGraph.h"

@interface Spline : ObjectGraph {
@private
	int initialized;
	NSMutableArray * pointsReference;
}

@property (assign) int initialized;
@property (assign) NSMutableArray * pointsReference;

- (void) start;
- (void) draw;
- (void) nextPointHighlights;
- (void) paintReferences;

@end
