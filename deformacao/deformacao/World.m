//
//  World.m
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "World.h"

@implementation World

@synthesize enviromentForces = _enviromentForces;
@synthesize bodies = _bodies;
@synthesize gravityForce = _gravityForce;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.enviromentForces = [[NSMutableArray alloc] init];
        self.bodies = [[NSMutableArray alloc] init];
    }
    
    return self;
}

+(World *)sharedInstance
{
    static World * sharedInstance;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[World alloc] init];
        }
        
        return sharedInstance;
    }
}

-(void)update
{
    for (EnvironmentForce * enviromentForce in self.enviromentForces) {
        [enviromentForce update];
    }
    
    for (Body * body in self.bodies) {
        
        for (EnvironmentForce * enviromentForce in self.enviromentForces) {
            [enviromentForce applyForce:body.particles];
        }
        
        [body smooth];
        [body updateParticles];
    }
    
}

-(void)configure
{
    Body * body = [[Body alloc] init];
    [body generateFromBlueprint:[RectangleBlueprint sharedInstance].blueprint];
    
    // particula presa
    Particle * p = [body.particles objectAtIndex:0];
    p.locked =  YES;
    p.mass = 1000;

    [p.body calculateInvariants];
    
    [[World sharedInstance].enviromentForces addObject: [[LockForce alloc] init]];
    
    self.gravityForce = [[GravityForce alloc] initWith:0.5];
    
    [[World sharedInstance].enviromentForces addObject:self.gravityForce];
    [[World sharedInstance].bodies addObject:body];
}

@end
