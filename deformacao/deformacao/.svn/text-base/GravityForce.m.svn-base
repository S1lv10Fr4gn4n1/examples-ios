//
//  GravityForce.m
//  deformacao
//
//  Created by Felipe Imianowsky on 18/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "GravityForce.h"

@implementation GravityForce

@synthesize gravity = _gravity;

-(id)initWith:(double)g
{
    self = [super init];
    
    if (self) {
        self.gravity = g;
    }
    
    return self;
}

-(void)applyForce:(NSMutableArray *)particles
{
    if (self.gravity != 0.0) {
        Vector2 * gv2 = [[Vector2 alloc] initWith:0 y:-self.gravity];
        
        for (Particle * particle in particles) {
            particle.fExt = [Vector2 sum:particle.fExt b:gv2];
        }
    }
}

@end
