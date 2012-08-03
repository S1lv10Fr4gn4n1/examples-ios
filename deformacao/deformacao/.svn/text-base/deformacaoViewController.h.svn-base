//
//  deformacaoViewController.h
//  deformacao
//
//  Created by Silvio Fragnani on 09/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "World.h"
#import "GravityForce.h"
#import "LockForce.h"
#import "RectangleBlueprint.h"
#import "NDC.h"

@interface deformacaoViewController : UIViewController
{
@private
    EAGLContext *context;
    GLuint program;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
}

@property(readonly, nonatomic, getter=isAnimating) BOOL animating;
@property(nonatomic) NSInteger animationFrameInterval;
@property(nonatomic, retain) EAGLContext *context;
@property(nonatomic, retain) CADisplayLink *displayLink;

-(void)initGL;
-(void)startAnimation;
-(void)stopAnimation;

@end
