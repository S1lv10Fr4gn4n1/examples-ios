//
//  SGGViewController.m
//  SimpleGLKitGame
//
//  Created by Ray Wenderlich on 1/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SGGViewController.h"
#import "SGGSprite.h"

@interface SGGViewController ()
@property (strong, nonatomic) EAGLContext *context;
@property (strong) GLKBaseEffect * effect;
@property (strong) SGGSprite * player;
@property (strong) NSMutableArray * children;
@property (assign) float timeSinceLastSpawn;
@end

@implementation SGGViewController
@synthesize effect = _effect;
@synthesize context = _context;
@synthesize player = _player;
@synthesize children = _children;
@synthesize timeSinceLastSpawn = _timeSinceLastSpawn;

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    [EAGLContext setCurrentContext:self.context];
    
    self.effect = [[GLKBaseEffect alloc] init];
    
    GLKMatrix4 projectionMatrix = GLKMatrix4MakeOrtho(0, 480, 0, 320, -1024, 1024);
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    self.player = [[SGGSprite alloc] initWithFile:@"Player.png" effect:self.effect];    
    self.player.position = GLKVector2Make(self.player.contentSize.width/2, 160);
    
    self.children = [NSMutableArray array];
    [self.children addObject:self.player];    

}

- (void)addTarget {
    SGGSprite * target = [[SGGSprite alloc] initWithFile:@"Target.png" effect:self.effect];
    [self.children addObject:target];
       
    int minY = target.contentSize.height/2;
    int maxY = 320 - target.contentSize.height/2;
    int rangeY = maxY - minY;
    int actualY = (arc4random() % rangeY) + minY;
    
    target.position = GLKVector2Make(480 + (target.contentSize.width/2), actualY);    

    int minVelocity = 480.0/4.0;
    int maxVelocity = 480.0/2.0;
    int rangeVelocity = maxVelocity - minVelocity;
    int actualVelocity = (arc4random() % rangeVelocity) + minVelocity;
    
    target.moveVelocity = GLKVector2Make(-actualVelocity, 0);
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

#pragma mark - GLKViewDelegate

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {    
    glClearColor(1, 1, 1, 1);
    glClear(GL_COLOR_BUFFER_BIT);    
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    glEnable(GL_BLEND);
    
    for (SGGSprite * sprite in self.children) {
        [sprite render];
    }
}

- (void)update {    
    
    self.timeSinceLastSpawn += self.timeSinceLastUpdate;
    if (self.timeSinceLastSpawn > 1.0) {
        self.timeSinceLastSpawn = 0;
        [self addTarget];
    }
    
    for (SGGSprite * sprite in self.children) {
        [sprite update:self.timeSinceLastUpdate];
    }
}
 
@end
