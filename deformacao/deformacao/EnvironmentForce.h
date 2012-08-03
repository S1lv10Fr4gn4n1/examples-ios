//
//  EnvironmentForce.h
//  deformacao
//
//  Created by Felipe Imianowsky on 18/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnvironmentForce : NSObject
{
}

-(void)applyForce:(NSMutableArray *)particles;
-(void)update;

@end
