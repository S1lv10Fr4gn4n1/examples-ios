//
//  Transform.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Transform.h"

@interface Transform()
- (Transform *) transformMatrix: (Transform *) _t;
- (void) translate: (float) _x: (float) _y: (float) _z;
- (void) scale: (float) _x: (float) _y: (float) _z;
- (void) rotate: (float) _x: (float) _y: (float) _z;
- (void) makeIdentity;
- (void) transformGraphObject: (float) _x: (float) _y: (float) _z;
- (void) printMatrix: (NSString *) _desc;
- (float *) getMatrix;
- (float) getElement: (int) _i;
- (void) setElement: (int) _i: (float) _value;
@end

@implementation Transform

- (id)init
{
    self = [super init];
    if (self) {
        typeTransform = NONE;
		[self makeIdentity];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

// metodo responsavel por multiplicacao de matrizes
- (Transform *) transformMatrix: (Transform *) _t
{
	Transform * result = [[Transform alloc] init];
	
	for (int i = 0; i < 16; i++) {
		[result setElement: i: matrix[i % 4] * [_t getElement: i / 4 * 4] +
							   matrix[(i % 4) +  4] * [_t getElement: i / 4 * 4 + 1] +
							   matrix[(i % 4) +  8] * [_t getElement: i / 4 * 4 + 2] +
							   matrix[(i % 4) + 12] * [_t getElement: i / 4 * 4 + 3]];
	}
	
	return result;
}

// metodo responsavel por ajustar a matrix para a transformacao de translacao
- (void) translate: (float) _x: (float) _y: (float) _z
{
	// translacao (tx, ty, tz)  matrix identidade
	matrix[12] = _x;
	matrix[13] = _y;
	matrix[14] = 0.0f;
	matrix[15] = 1.0f;
}

// metodo responsavel por ajustar a matrix para a transformacao de scalar
- (void) scale: (float) _x: (float) _y: (float) _z
{
	// scale (sx, sy, sz) matrix identidade
	matrix[0] =  (_x / 100);
	matrix[5] =  (_y / 100);
	matrix[10] = 1.0f;
	matrix[15] = 1.0f;
}

// metodo responsavel por ajustar a matrix para a transformacao de rotacao
- (void) rotate: (float) _x: (float) _y: (float) _z
{
	// rotaciona em Z
	float teta = (M_PI * _x * 10) / 180.0; // teta eh a letra grega q referencia o grau e nao os seios de uma mulher :D
	matrix[0] =  cos(teta);
	matrix[1] =  sin(teta);
	matrix[4] = -sin(teta);
	matrix[5] =  cos(teta);
}

/// metodo responsavel por transformar um ponto original
/// para um ponto resultando da transformacao
- (Pointer *) transformPoint: (Pointer *) _point
{
	float x = matrix[0] * [_point x] + matrix[4] * [_point y] + matrix[8]  * [_point z] + matrix[12] * [_point w];
	float y = matrix[1] * [_point x] + matrix[5] * [_point y] + matrix[9]  * [_point z] + matrix[13] * [_point w];
	float z = matrix[2] * [_point x] + matrix[6] * [_point y] + matrix[10] * [_point z] + matrix[14] * [_point w];
	float w = matrix[3] * [_point x] + matrix[7] * [_point y] + matrix[11] * [_point z] + matrix[15] * [_point w];
		
	Pointer * p = [[Pointer alloc] init:x :y :z :w];
	[p autorelease];
	return p;
}

// metodo responsavel por gerar a matrix identidade
- (void) makeIdentity
{
	for (int i = 0; i < 16; i++) {
		matrix[i] = 0.0;
	}
	
	matrix[0] = matrix[5] = matrix[10] = matrix[15] = 1.0;

}

// metodo responsavel por direcionar os ajustes para cada metodo
- (void) transformGraphObject: (float) _x: (float) _y: (float) _z
{
    //sfs
//	switch (typeTransform) {
//		case TRANSLATE:
//			[self translate: _x: _y: _z];
//			break;
//			
//		case SCALE:
//			[self scale: _x: _y: _z];
//			break;
//			
//		case ROTATE:
//			[self rotate: _x: _y: _z];
//			break;
//			
//		case NONE:
//			break;
//	}
}

// printa a matrix atual
- (void) printMatrix: (NSString *) _desc
{
//	cout << "___" << _desc << " ___" << endl;
//	cout << "|" << matrix[0] << " | " << matrix[1] << " | " << matrix[2] << " | " << matrix[3] << endl;
//	cout << "|" << matrix[4] << " | " << matrix[5] << " | " << matrix[6] << " | " << matrix[7] << endl;
//	cout << "|" << matrix[8] << " | " << matrix[9] << " | " << matrix[10] << " | " << matrix[11] << endl;
//	cout << "|" << matrix[12] << " | " << matrix[13] << " | " << matrix[14] << " | " << matrix[15] << endl;
//	cout << "_______________" << endl;
}

- (float *) getMatrix
{
	return matrix;
}

- (float) getElement: (int) _i
{
	return matrix[_i];
}

- (void) setElement: (int) _i: (float) _value
{
	matrix[_i] = _value;	
}

- (void) setTypeTransform: (TypeTransform) _type
{
	typeTransform = _type;	
}

@end