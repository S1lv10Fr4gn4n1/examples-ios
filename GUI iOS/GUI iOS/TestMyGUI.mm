//
//  TestMyGUI.m
//  GUI iOS
//
//  Created by Silvio Fragnani da Silva on 01/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TestMyGUI.h"
#include "SFSGUI.h"

static const GLubyte squareColors[] = {
    255, 255, 255, 255,
    255, 255, 255, 255,
    255, 255, 255, 255,
    255, 255, 255, 255,
};

GLfloat squareVertex[] = {
    -0.65,  0.65,
    -0.15,  0.65,
    -0.15,  0.15,
    -0.65,  0.15,
    -0.65,  0.65,
};    


@interface TestMyGUI()
{
    SFSWindow * sfsWindow;  
    GLfloat * vertex;
}

@end

@implementation TestMyGUI

- (id)init
{
    self = [super init];
    
    if (self) {
        sfsWindow = new SFSWindow();
        sfsWindow->setX(10);
        sfsWindow->setY(10);
        sfsWindow->setWidth(50);
        sfsWindow->setHeigth(50);
        
        vertex = &squareVertex[0];
    }
    
    return self;
}

- (void)drawAllObjects:(unsigned int)_program
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    glUseProgram(_program);
    
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertex);
    glEnableVertexAttribArray(ATTRIB_VERTEX);

    glVertexAttribPointer(ATTRIB_COLOR, 4, GL_UNSIGNED_BYTE, 1, 0, squareColors);
    glEnableVertexAttribArray(ATTRIB_COLOR);
    
    glDrawArrays(GL_LINE_LOOP, 0, 4);

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
    //TODO
//    printf("touchesBegan-> x: %f y: %f\n", point.x, point.y);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
    //TODO    
//    printf("touchesMoved-> x: %f y: %f\n", point.x, point.y);
    calcNDCCoordinates(&point.x, &point.y);
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{    
//    printf("touchesEnded-> x: %f y: %f\n", point.x, point.y);
    
//    printf("touchesEnded NDC-> x: %f y: %f\n", point.x, point.y);
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event point:(CGPoint)point
{
    //TODO
//    printf("touchesCancelled-> x: %f y: %f\n", point.x, point.y);
}



@end
