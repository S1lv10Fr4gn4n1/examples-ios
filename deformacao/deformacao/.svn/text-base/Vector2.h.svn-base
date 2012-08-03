//
//  Vector2.h
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vector2 : NSObject
{
    double _x;
    double _y;
}

@property double x;
@property double y;

-(id)init;
-(id)initWith:(double)x y:(double)y;
+(Vector2 *)zero;
-(void)normalize;
-(Vector2 *)normalizedCopy;
-(Vector2 *)rotateVector:(Vector2 *)r;
-(double)length;
-(double)lengthSq;
-(double)dot:(Vector2 *)r;
+(double)dot:(Vector2 *)a b:(Vector2 *)b;
+(Vector2 *)negative:(Vector2 *)a;
+(Vector2 *)sum:(Vector2 *)a b:(Vector2 *)b toFloat:(BOOL)withFloat;
+(Vector2 *)subtract:(Vector2 *)a b:(Vector2 *)b;
+(Vector2 *)sum:(Vector2 *)a b:(Vector2 *)b;
+(Vector2 *)multiply:(Vector2 *)a b:(double)b;
+(Vector2 *)divide:(Vector2 *)a b:(double)b;
+(BOOL)equals:(Vector2 *)a b:(Vector2 *)b;
-(double)crossProduct:(Vector2 *)r;

@end
