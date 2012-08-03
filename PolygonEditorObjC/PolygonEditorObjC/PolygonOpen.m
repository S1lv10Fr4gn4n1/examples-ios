//
//  PolygonOpen.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 17/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PolygonOpen.h"


@implementation PolygonOpen

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void) start
{
	[super start];
}

- (void) draw
{
	[super draw];
	
	glBegin(GL_LINE_STRIP);

	for (int i = 0; i < [points count]; i++) {
		Pointer * point = [points objectAtIndex: i];
		glVertex2f([point x], [point y]);
	}
	glEnd();

}


@end
