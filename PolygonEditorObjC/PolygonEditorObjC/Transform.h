//
//  Transform.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeTransform.h"
#import "Pointer.h"

@interface Transform : NSObject {
@private
	float matrix[16];
	enum TypeTransform typeTransform;    
}

- (Transform *) transformMatrix: (Transform *) _t;
- (void) translate: (float) _x: (float) _y: (float) _z;
- (void) scale: (float) _x: (float) _y: (float) _z;
- (void) rotate: (float) _x: (float) _y: (float) _z;
- (Pointer *) transformPoint: (Pointer *) _point;
- (void) makeIdentity;
- (void) transformGraphObject: (float) _x: (float) _y: (float) _z;
- (void) printMatrix: (NSString *) _desc;
- (float *) getMatrix;
- (float) getElement: (int) _i;
- (void) setElement: (int) _i: (float) _value;
- (void) setTypeTransform: (enum TypeTransform) _type;

@end