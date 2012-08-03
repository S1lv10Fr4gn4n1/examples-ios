//
//  PolygonEditorViewController.h
//  PolygonEditor
//
//  Created by Silvio Fragnani on 06/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "Controller.h"


@interface PolygonEditorViewController : UIViewController {
@private
    EAGLContext *context;
    GLuint program;
    
    Controller *controller;
    
    CADisplayLink *displayLink;
    
    UISegmentedControl *segmentedControl;
    UISegmentedControl *openTools;
}

- (void)start;

@end
