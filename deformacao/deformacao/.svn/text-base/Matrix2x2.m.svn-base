//
//  Matrix2x2.m
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Matrix2x2.h"

@implementation Matrix2x2

@synthesize matrix = _matrix;

+(Matrix2x2 *)zero
{
    return [[Matrix2x2 alloc] initWith:0.0 m01:0.0 m10:0.0 m11:0.0];
}

+(Matrix2x2 *)identity
{
    return [[Matrix2x2 alloc] initWith:1.0 m01:0.0 m10:0.0 m11:1.0];
}

-(id)init
{
    self = [super init];
    
    if (self) {
        self.matrix = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 2; i++) {
            [self.matrix addObject:[[NSMutableArray alloc] init]];
        }
        
        [[self.matrix objectAtIndex:0] addObject:[NSNumber numberWithDouble:0.0]];
        [[self.matrix objectAtIndex:0] addObject:[NSNumber numberWithDouble:0.0]];
        [[self.matrix objectAtIndex:1] addObject:[NSNumber numberWithDouble:0.0]];
        [[self.matrix objectAtIndex:1] addObject:[NSNumber numberWithDouble:0.0]];
    }
    
    return self;
}

-(id)initWith:(double)m00 m01:(double)m01 m10:(double)m10 m11:(double)m11
{
    self = [super init];
    
    if (self) {
        self.matrix = [[NSMutableArray alloc] init];
        
        for (int i = 0; i < 2; i++) {
            [self.matrix addObject:[[NSMutableArray alloc] init]];
        }
        
        [[self.matrix objectAtIndex:0] addObject:[NSNumber numberWithDouble:m00]];
        [[self.matrix objectAtIndex:0] addObject:[NSNumber numberWithDouble:m01]];
        [[self.matrix objectAtIndex:1] addObject:[NSNumber numberWithDouble:m10]];
        [[self.matrix objectAtIndex:1] addObject:[NSNumber numberWithDouble:m11]];
    }
    
    return self;
}

-(double)determinant
{
    double m00 = [[[self.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[self.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[self.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[self.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return m00 * m11 - m01 * m10;
}

+(Matrix2x2 *)negative:(Matrix2x2 *)a
{
    double m00 = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:-m00 m01:-m01 m10:-m10 m11:-m11];
}

+(Matrix2x2 *)subtract:(Matrix2x2 *)a b:(Matrix2x2 *)b
{
    double m00a = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01a = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10a = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11a = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double m00b = [[[b.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01b = [[[b.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10b = [[[b.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11b = [[[b.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:m00a-m00b m01:m01a-m01b m10:m10a-m10b m11:m11a-m11b];
}

+(Matrix2x2 *)sum:(Matrix2x2 *)a b:(Matrix2x2 *)b
{
    double m00a = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01a = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10a = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11a = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double m00b = [[[b.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01b = [[[b.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10b = [[[b.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11b = [[[b.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:m00a+m00b m01:m01a+m01b m10:m10a+m10b m11:m11a+m11b];
}

+(Matrix2x2 *)multiply:(Matrix2x2 *)a withDouble:(double)b
{
    double m00 = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:m00*b m01:m01*b m10:m10*b m11:m11*b];
}

+(Vector2 *)multiply:(Matrix2x2 *)a withVector:(Vector2 *)b
{
    double m00 = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Vector2 alloc] initWith:m00*b.x + m01*b.y y:m10*b.x + m11*b.y];
}

+(Matrix2x2 *)multiply:(Matrix2x2 *)b withMatrix:(Matrix2x2 *)a
{
    double m00a = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01a = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10a = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11a = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double m00b = [[[b.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01b = [[[b.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10b = [[[b.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11b = [[[b.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double m00 = m00a*m00b + m01a*m10b;
    double m01 = m00a*m01b + m01a*m11b;
    double m10 = m10a*m00b + m11a*m10b;
    double m11 = m10a*m01b + m11a*m11b;
    
    return [[Matrix2x2 alloc] initWith:m00 m01:m01 m10:m10 m11:m11];
}

+(Matrix2x2 *)divide:(Matrix2x2 *)a b:(double)b
{
    double m00 = [[[a.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[a.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[a.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[a.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:m00/b m01:m01/b m10:m10/b m11:m11/b];
}

+(BOOL)equals:(Matrix2x2 *)a matrix:(Matrix2x2 *)b
{
    if (a != nil && b != nil) {
        
        for (int i = 0; i < 2; i++) {    
            for (int j = 0; j < 2; j++) {
                double aValue = [[[a.matrix objectAtIndex:i] objectAtIndex:j] doubleValue];
                double bValue = [[[b.matrix objectAtIndex:i] objectAtIndex:j] doubleValue];
                
                if (aValue != bValue) {
                    return NO;
                }
            }
        }
        
        return YES;
    }
    
    return NO;
}

+(Matrix2x2 *)multiplyWithTranspose:(Vector2 *)p q:(Vector2 *)q
{
    return [[Matrix2x2 alloc] initWith:p.x*q.x m01:p.x*q.y m10:p.y*q.x m11:p.y*q.y];
}

+(void)jacobiRotate:(Matrix2x2 **)a b:(Matrix2x2 **)b
{
    // rotaciona A até phi em 01-plano para o conjunto A(0,1) = 0
    // rotacao guardada em B cujas colunas sao eigenvectors de A
    
    double m00a = [[[[*a matrix] objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01a = [[[[*a matrix] objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m11a = [[[[*a matrix] objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double d = (m00a - m11a)/(2.0f*m01a);
    double t = 1.0f / (fabs(d) + sqrt(d*d + 1.0f));
    
    if (d < 0.0f) {
        t = -t;
    }
    
    double c = 1.0f/sqrt(t*t + 1);
    double s = t*c;
    
    NSNumber * a00 = [NSNumber numberWithDouble:m00a+(t*m01a)];
    NSNumber * a11 = [NSNumber numberWithDouble:m11a-(t*m01a)];
    
    [[[*a matrix] objectAtIndex:0] replaceObjectAtIndex:0 withObject:a00];
    [[[*a matrix] objectAtIndex:1] replaceObjectAtIndex:1 withObject:a11];
    [[[*a matrix] objectAtIndex:0] replaceObjectAtIndex:1 withObject:[NSNumber numberWithDouble:0.0]];
    [[[*a matrix] objectAtIndex:1] replaceObjectAtIndex:0 withObject:[NSNumber numberWithDouble:0.0]];
    
    // guarda rotacao em B
    for (int k = 0; k < 2; k++) {
        double bk0 = [[[[*b matrix] objectAtIndex:k] objectAtIndex:0] doubleValue];
        double bk1 = [[[[*b matrix] objectAtIndex:k] objectAtIndex:1] doubleValue];
        
        NSNumber * bkp = [NSNumber numberWithDouble:c * bk0 + s * bk1];
        NSNumber * bkq = [NSNumber numberWithDouble:-s * bk0 + c * bk1];
        
        [[[*b matrix] objectAtIndex:k] replaceObjectAtIndex:0 withObject:bkp];
        [[[*b matrix] objectAtIndex:k] replaceObjectAtIndex:1 withObject:bkq];
    }
}

+(void)eigenDecomposition:(Matrix2x2 **)a r:(Matrix2x2 **)r
{
    // somente para matrizes simetricas
    // A = R A' R^T, onde A' for diagonal e R orthonormal
    
    *r = [Matrix2x2 identity];
    [Matrix2x2 jacobiRotate:a b:r];
}

-(Matrix2x2 *)extractRotation
{
    // A = RS, onde S for simetrica e R for orthonormal
    // -> S = (A^T A)^(1/2)
    Matrix2x2 * a = self;
    Matrix2x2 * s = [[Matrix2x2 alloc] init];
    
    // resposta padrao
    Matrix2x2 * r = [Matrix2x2 identity];
    
    Matrix2x2 * ata = [Matrix2x2 multiplyTransposedLeft:a right:a];
    
    Matrix2x2 * u = [[Matrix2x2 alloc] init];
    r = [Matrix2x2 identity];
    [Matrix2x2 eigenDecomposition:&ata r:&u];
    
    double l0 = [[[ata.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    
    if (l0 <= 0.0f) {
        l0 = 0.0f;
    } else {
        l0 = 1.0f / sqrt(l0);
    }
    
    double l1 = [[[ata.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    if (l1 <= 0.0f) {
        l1 = 0.0f;
    } else {
        l1 = 1.0f / sqrt(l1);
    }
    
    Matrix2x2 * s1 = [[Matrix2x2 alloc] init];
    
    double u00 = [[[u.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double u01 = [[[u.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double u10 = [[[u.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double u11 = [[[u.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    NSNumber * s100 = [NSNumber numberWithDouble:l0*u00*u00 + l1*u01*u01];
    NSNumber * s101 = [NSNumber numberWithDouble:l0*u00*u10 + l1*u01*u11];
    NSNumber * s111 = [NSNumber numberWithDouble:l0*u10*u10 + l1*u11*u11];
    
    [[s1.matrix objectAtIndex:0] replaceObjectAtIndex:0 withObject:s100];
    [[s1.matrix objectAtIndex:0] replaceObjectAtIndex:1 withObject:s101];
    [[s1.matrix objectAtIndex:1] replaceObjectAtIndex:0 withObject:s101];
    [[s1.matrix objectAtIndex:1] replaceObjectAtIndex:1 withObject:s111];
    
    r = [Matrix2x2 multiply:a withMatrix:s1];
    s = [Matrix2x2 multiplyTransposedLeft:r right:a];
    
    return r;
}

+(Matrix2x2 *)multiplyTransposedLeft:(Matrix2x2 *)left right:(Matrix2x2 *)right
{
    double m00l = [[[left.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01l = [[[left.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10l = [[[left.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11l = [[[left.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    double m00r = [[[right.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01r = [[[right.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10r = [[[right.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11r = [[[right.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    Matrix2x2 * res = [[Matrix2x2 alloc] init];
    
    NSNumber * r00 = [NSNumber numberWithDouble:m00l*m00r + m10l*m10r];
    NSNumber * r01 = [NSNumber numberWithDouble:m00l*m01r + m10l*m11r];
    NSNumber * r10 = [NSNumber numberWithDouble:m01l*m00r + m11l*m10r];
    NSNumber * r11 = [NSNumber numberWithDouble:m01l*m01r + m11l*m11r];
    
    [[res.matrix objectAtIndex:0] replaceObjectAtIndex:0 withObject:r00];
    [[res.matrix objectAtIndex:0] replaceObjectAtIndex:1 withObject:r01];
    [[res.matrix objectAtIndex:1] replaceObjectAtIndex:0 withObject:r10];
    [[res.matrix objectAtIndex:1] replaceObjectAtIndex:1 withObject:r11];
    
    return res;
}

-(Matrix2x2 *)transpose
{
    double m00 = [[[self.matrix objectAtIndex:0] objectAtIndex:0] doubleValue];
    double m01 = [[[self.matrix objectAtIndex:0] objectAtIndex:1] doubleValue];
    double m10 = [[[self.matrix objectAtIndex:1] objectAtIndex:0] doubleValue];
    double m11 = [[[self.matrix objectAtIndex:1] objectAtIndex:1] doubleValue];
    
    return [[Matrix2x2 alloc] initWith:m00 m01:m10 m10:m01 m11:m11];
}

@end
