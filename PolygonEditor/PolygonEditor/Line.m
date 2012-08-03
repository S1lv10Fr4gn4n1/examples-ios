//
//  Line.m
//  PolygonEditor
//
//  Created by Silvio Fragnani on 07/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Line.h"


@implementation Line

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

- (void)start
{
	[super start];
}

- (void)draw
{
    float vertex[[points count] * 2];
    
	for (int i = 0; i < [points count]; i++) {
		Pointer * p = [points objectAtIndex: i];
        vertex[i*2+0] = [p x];
        vertex[i*2+1] = [p y];
	}
    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertex);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    glDrawArrays(GL_LINES, 0, [points count]);
    
    [super draw];
}

@end
