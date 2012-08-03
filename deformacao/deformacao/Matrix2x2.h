//
//  Matrix2x2.h
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"

@interface Matrix2x2 : NSObject
{
    NSMutableArray * _matrix;
}

@property(retain) NSMutableArray * matrix;

+(Matrix2x2 *)zero;
+(Matrix2x2 *)identity;
-(id)init;
-(id)initWith:(double)m00 m01:(double)m01 m10:(double)m10 m11:(double)m11;
-(double)determinant;
+(Matrix2x2 *)negative:(Matrix2x2 *)a;
+(Matrix2x2 *)subtract:(Matrix2x2 *)a b:(Matrix2x2 *)b;
+(Matrix2x2 *)sum:(Matrix2x2 *)a b:(Matrix2x2 *)b;
+(Matrix2x2 *)multiply:(Matrix2x2 *)a withDouble:(double)b;
+(Vector2 *)multiply:(Matrix2x2 *)a withVector:(Vector2 *)b;
+(Matrix2x2 *)multiply:(Matrix2x2 *)b withMatrix:(Matrix2x2 *)a;
+(Matrix2x2 *)divide:(Matrix2x2 *)a b:(double)b;
+(BOOL)equals:(Matrix2x2 *)a matrix:(Matrix2x2 *)b;
+(Matrix2x2 *)multiplyWithTranspose:(Vector2 *)p q:(Vector2 *)q;
+(void)jacobiRotate:(Matrix2x2 **)a b:(Matrix2x2 **)b;
+(void)eigenDecomposition:(Matrix2x2 **)a r:(Matrix2x2 **)r
;
-(Matrix2x2 *)extractRotation;
+(Matrix2x2 *)multiplyTransposedLeft:(Matrix2x2 *)left right:(Matrix2x2 *)right;
-(Matrix2x2 *)transpose;

@end
