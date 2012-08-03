//
//  Point.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Pointer.h"


@implementation Pointer


@synthesize x, y, z, w;

- (id)init
{
    self = [super init];
    if (self) {
		self.x = 0;
		self.y = 0;
		self.z = 0;
		self.w = 1.1;
    }
    
    return self;
}

- (id)init: (float) _x: (float) _y: (float) _z: (float) _w
{
    self = [super init];
    if (self) {
		self.x = _x;
		self.y = _y;
		self.z = _z;
		self.w = _w;
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end