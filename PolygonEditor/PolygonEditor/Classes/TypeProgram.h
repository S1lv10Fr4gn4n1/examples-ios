//
//  TypeProgram.h
//  PolygonEditor
//
//  Created by Silvio Fragnani on 06/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
typedef enum {
    NONE,
    TRANSLATE,
} TypeTransform;


typedef enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
} TypeAttributeGLSL;

typedef enum {
    LINE,
    CIRCLE,
    POLYGON_OPEN,
    POLYGON_CLOSE,
    SPLINE,
    CONFIRM,
} TypeObjectGraph;
