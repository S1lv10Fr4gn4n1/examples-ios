//
//  PolygonClose.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 17/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PolygonClose.h"


@implementation PolygonClose

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        canDraw = false;
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
    canDraw = true;
}

- (Boolean) addPoint:(Pointer *)value
{
    [super addPoint:value];
    return !canDraw;
}

- (void) draw
{
	[super draw];
	
	if (canDraw) {
        int index = 0;
        GLfloat vertices[[points count] * 2];
        for (int i = 0; i < ([points count] * 2); i = i + 2){
            Pointer * point = [points objectAtIndex: index];
            vertices[i] = [point x];
            vertices[i + 1] = [point y];
            index++;
            if (index == [points count]) {
                break;
            }
        }
        glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertices);
        glEnableVertexAttribArray(ATTRIB_VERTEX);
        glDrawArrays(GL_LINE_LOOP, 0, [points count]);
    }
	/* //sfs
	glBegin(GL_POLYGON);
	
	for (int i = 0; i < [points count]; i++) {
		Pointer * point = [points objectAtIndex: i];
		glVertex2f([point x], [point y]);
	}
	glEnd();	
    */
}

@end
