//
//  deformacaoViewController.m
//  deformacao
//
//  Created by Silvio Fragnani on 09/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "deformacaoViewController.h"
#import "EAGLView.h"

@implementation deformacaoViewController

@synthesize animating, context, displayLink;

-(void)awakeFromNib
{
    NSLog(@"awakeFromNib");
    EAGLContext *aContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
    
    if (!aContext)
        NSLog(@"Failed to create ES context");
    else if (![EAGLContext setCurrentContext:aContext])
        NSLog(@"Failed to set ES context current");
    
	self.context = aContext;
	
    [(EAGLView *)self.view setContext:context];
    [(EAGLView *)self.view setFramebuffer];
    
    animating = FALSE;
    animationFrameInterval = 1;
    self.displayLink = nil;
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewWillAppear");
    [self startAnimation];
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSLog(@"viewWillDisappear");
    [self stopAnimation];
    [super viewWillDisappear:animated];
}

-(void)viewDidLoad
{
    NSLog(@"viewDidLoad");
	[super viewDidLoad];
    
    [[World sharedInstance] configure];
    
}

-(void)viewDidUnload
{
    NSLog(@"viewDidUnload");
	[super viewDidUnload];
    if (program) {
        glDeleteProgram(program);
        program = 0;
    }

    if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	self.context = nil;	
}

-(NSInteger)animationFrameInterval
{
    return animationFrameInterval;
}

-(void)setAnimationFrameInterval:(NSInteger)frameInterval
{
    if (frameInterval >= 1) {
        animationFrameInterval = frameInterval;
        
        if (animating) {
            [self stopAnimation];
            [self startAnimation];
        }
    }
}

-(void)initGL
{
    glClearColor(0.2f, 0.2f, 0.2f, 1.0f);
    glPointSize(1.5);
    glLineWidth(1.0);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_POINT_SMOOTH);
    glEnable(GL_LINE_SMOOTH);
    glHint(GL_LINE_SMOOTH, GL_NICEST);
    glHint(GL_POINT_SMOOTH, GL_NICEST);
    
    glMatrixMode(GL_PROJECTION);
    glLoadIdentity();
}

-(void)startAnimation
{
    NSLog(@"startAnimation");
    if (!animating) {
        CADisplayLink *aDisplayLink = [[UIScreen mainScreen] displayLinkWithTarget:self selector:@selector(drawFrame)];
        [aDisplayLink setFrameInterval:animationFrameInterval];
        [aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
        self.displayLink = aDisplayLink;
        
        animating = TRUE;
    }
}

-(void)stopAnimation
{
    NSLog(@"stopAnimation");
    if (animating) {
        [self.displayLink invalidate];
        self.displayLink = nil;
        animating = FALSE;
    }
}

-(void)drawFrame
{
    [(EAGLView *)self.view setFramebuffer];
    
    glClear(GL_COLOR_BUFFER_BIT);
    
    [[World sharedInstance] update];
    
    GLfloat points[120];        
    
    NSMutableArray * bodies = [World sharedInstance].bodies;    
                
    for (Body * body in bodies) {
        NSMutableArray * particles = body.particles;
        
        for (int i = 0; i < [particles count]; i++) {
            Particle * particle = [particles objectAtIndex:i];
            
            double x = [NDC x:particle.goal.x];
            double y = [NDC y:particle.goal.y];
            
            points[i*2] = x;
            points[i*2+1] = y;
        }
    }
    
    int length = sizeof(points) / sizeof(GLfloat);
    
    glEnableClientState(GL_VERTEX_ARRAY);    
    glVertexPointer(2, GL_FLOAT, 0, points);
    glDrawArrays(GL_POINTS, 0, length/2);
    glDisableClientState(GL_VERTEX_ARRAY);
    
    glFlush();
    
    [(EAGLView *)self.view presentFramebuffer];
}

@end
