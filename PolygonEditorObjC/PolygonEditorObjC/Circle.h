//
//  Circle.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectGraph.h"

@interface Circle : ObjectGraph {
@private
 	float radius;
	Pointer * pointInit;
}

@property (assign) float radius;
@property (assign) Pointer * pointInit;

- (void) start;
- (void) draw;
- (void) nextPointHighlights;

@end
