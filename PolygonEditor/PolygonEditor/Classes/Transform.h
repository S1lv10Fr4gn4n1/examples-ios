//
//  Transform.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 16/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TypeProgram.h"
#import "Pointer.h"

@interface Transform : NSObject {
@private
	float matrix[16];
	TypeTransform typeTransform;    
}

- (Pointer *)transformPoint:(Pointer *)point;
- (void)setTypeTransform:(TypeTransform)type;

@end