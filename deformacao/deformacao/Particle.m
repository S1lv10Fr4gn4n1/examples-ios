//
//  Particle.m
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Particle.h"

@implementation Particle

@synthesize body = _body;
@synthesize latticePoint = _latticePoint;
@synthesize locked = _locked;
@synthesize xPos = _xPos;
@synthesize yPos = _yPos;
@synthesize xNeg = _xNeg;
@synthesize yNeg = _yNeg;
@synthesize parentRegions = _parentRegions;
@synthesize mass = _mass;
@synthesize x = _x;
@synthesize v = _v;
@synthesize x0 = _x0;
@synthesize fExt = _fExt;
@synthesize goal = _goal;
@synthesize r = _r;
@synthesize dv = _dv;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.locked = NO;
        self.parentRegions = [[NSMutableArray alloc] init];
        self.mass = 1.0;
        self.x = [[Vector2 alloc] init];
        self.v = [[Vector2 alloc] init];
        self.x0 = [[Vector2 alloc] init];
        self.fExt = [[Vector2 alloc] init];
        self.goal = [[Vector2 alloc] init];
        self.dv = [[Vector2 alloc] init];
    }
    
    return self;
}

-(double)perRegionMass
{
    return self.mass / [self.parentRegions count];
}

@end
