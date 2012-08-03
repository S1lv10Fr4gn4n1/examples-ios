//
//  Controller.h
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 18/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "World.h"
#import "ObjectGraph.h"

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

- (void) displayMenu;
- (Color *) getRandomColor;
- (void) finalizeConstructionObject;
- (void) finalizeEditionObject;
- (void) newGraphObject: (Class) _class: (int) _maxPoints;

- (Pointer *) ndc: (float) _x: (float) _y;
- (void) selectObject: (Pointer *) _point;
- (BOOL) inBBox: (ObjectGraph *) _object: (Pointer *) _point;
- (BOOL) inObject: (ObjectGraph *) _object: (Pointer *) _point;
- (void) deleteObjetct;
- (void) deletePoint;
- (void) cleanAllObjects;
- (void) nextPointInObject;
- (void) setMovingPoint: (int) _x: (int) _y;
- (void) showBBox;

- (void) drawAllObj;

- (void) reshape: (int) _width: (int) _heigth;
- (void) keyboard: (unsigned char) _key: (int) _x: (int) _y;
- (void) special: (int) _key: (int) _x: (int) _y;
- (void) motion: (int) _x: (int) _y;
- (void) mouse: (int) _button: (int) _state: (int) _x: (int) _y;
- (void) passive: (int) _x: (int) _y;

- (double) getOrtho2DLeft;
- (double) getOrtho2DRight;
- (double) getOrtho2DBottom;
- (double) getOrtho2DTop;

@end
