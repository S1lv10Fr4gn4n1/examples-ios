//
//  Vector2.m
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Vector2.h"

@implementation Vector2

@synthesize x = _x;
@synthesize y = _y;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.x = 0.0;
        self.y = 0.0;
    }
    
    return self;
}

-(id)initWith:(double)x y:(double)y
{
    self = [super init];
    
    if (self) {
        self.x = x;
        self.y = y;
    }
    
    return self;
}

+(Vector2 *)zero
{
    return [[Vector2 alloc] initWith:0.0 y:0.0];
}

-(void)normalize
{
    double rlen = 1.0 / [self length];
    self.x *= rlen;
    self.y *= rlen;
}

-(Vector2 *)normalizedCopy
{
    Vector2 * ret = [[Vector2 alloc] initWith:self.x y:self.y];
    [ret normalize];
    return ret;
}

-(Vector2 *)rotateVector:(Vector2 *)r
{
    Vector2 * xVec = self;
    Vector2 * yVec = [[Vector2 alloc] initWith:-self.y y:self.x];
    
    Vector2 * multx = [Vector2 multiply:xVec b:r.x];
    Vector2 * multy = [Vector2 multiply:yVec b:r.y];
    
    return [Vector2 sum:multx b:multy];
}

-(double)length
{
    return sqrt(self.x * self.x + self.y * self.y);
}

-(double)lengthSq
{
    return (self.x * self.x + self.y * self.y);
}

-(double)dot:(Vector2 *)r
{    
    return (self.x * r.x + self.y * r.y);
}

+(double)dot:(Vector2 *)a b:(Vector2 *)b
{
    return [a dot:b];
}

+(Vector2 *)negative:(Vector2 *)a
{
    return [[Vector2 alloc] initWith:-a.x y:-a.y];
}

+(Vector2 *)subtract:(Vector2 *)a b:(Vector2 *)b
{
    return [[Vector2 alloc] initWith:a.x-b.x y:a.y-b.y];
}

+(Vector2 *)sum:(Vector2 *)a b:(Vector2 *)b toFloat:(BOOL)toFloat
{
    if (toFloat) {
        float x = a.x + b.x;
        float y = a.y + b.y;
        
        return [[Vector2 alloc] initWith:x y:y];
    
    } else {
        return [[Vector2 alloc] initWith:a.x+b.x y:a.y+b.y];
    }
}

+(Vector2 *)sum:(Vector2 *)a b:(Vector2 *)b
{
    return [self sum:a b:b toFloat:NO];
}

+(Vector2 *)multiply:(Vector2 *)a b:(double)b
{
    return [[Vector2 alloc] initWith:a.x*b y:a.y*b];
}

+(Vector2 *)divide:(Vector2 *)a b:(double)b
{
    return [[Vector2 alloc] initWith:a.x/b y:a.y/b];
}

+(BOOL)equals:(Vector2 *)a b:(Vector2 *)b
{
    return (a != nil && b != nil && a.x == b.x && a.y == b.y);
}

-(double)crossProduct:(Vector2 *)r
{    
    return self.x * r.y - self.y * r.x;
}

@end
