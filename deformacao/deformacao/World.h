//
//  World.h
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EnvironmentForce.h"
#import "Body.h"
#import "GravityForce.h"
#import "LockForce.h"
#import "RectangleBlueprint.h"

@interface World : NSObject
{
    NSMutableArray * _enviromentForces;
    NSMutableArray * _bodies;
    GravityForce * _gravityForce;
}

@property(retain) NSMutableArray * enviromentForces;
@property(retain) NSMutableArray * bodies;
@property(retain) GravityForce * gravityForce;

-(id)init;
+(World *)sharedInstance;
-(void)update;
-(void)configure;

@end
