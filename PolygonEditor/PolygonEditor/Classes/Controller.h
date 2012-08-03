//
//  Controller.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <OpenGLES/ES1/gl.h>
//#import <OpenGLES/ES1/glext.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>

#import "World.h"
#import "ObjectGraph.h"
#import "Line.h"
#import "NDC.h"

@interface Controller : NSObject {
@private
	World * world;
	ObjectGraph * currentObjectGraph;
	int maxPoints;
	int totalPoints;	
	BOOL modeEdition;
}

@property (assign) World * world;
@property (assign) ObjectGraph * currentObjectGraph;
@property (assign) int maxPoints;
@property (assign) int totalPoints;
@property (assign) BOOL modeEdition;

- (void)finalizeConstructionObject;
- (void)finalizeEditionObject;
- (void)newGraphObject:(Class)clazz:(int)maxPoints;

- (void) drawAllObj:(GLuint)program;

- (void)changeTypeObject:(int)indexObject;
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event point: (CGPoint)point;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event point: (CGPoint)point;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event point: (CGPoint)point;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event point: (CGPoint)point;

//- (void) reshape: (int) _width: (int) _heigth;
//- (void) keyboard: (unsigned char) _key: (int) _x: (int) _y;
//- (void) special: (int) _key: (int) _x: (int) _y;
//- (void) motion: (int) _x: (int) _y;
//- (void) mouse: (int) _button: (int) _state: (int) _x: (int) _y;
//- (void) passive: (int) _x: (int) _y;

//- (double) getOrtho2DLeft;
//- (double) getOrtho2DRight;
//- (double) getOrtho2DBottom;
//- (double) getOrtho2DTop;

@end
