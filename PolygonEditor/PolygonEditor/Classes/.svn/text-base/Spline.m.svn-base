//
//  Spline.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 17/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Spline.h"

@interface Spline ()
- (void) paintReferences;
@end

@implementation Spline

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
		pointsReference = [[NSMutableArray alloc] init];
		initialized = 0;
    }
    
    return self;
}

- (void)dealloc
{
	[pointsReference release];
    [super dealloc];
}


- (Boolean) addPoint: (Pointer *) value 
{
    [super addPoint:value];
    
    if ([points count] == 4) {
        
        if ([pointsReference count] == 0) {
            for (int i = 0; i < 4; ++i) {
                [pointsReference addObject: [points objectAtIndex: i]];
            }
        }
        
        // guarda os pontos de referencia
        for (int i = 0; i < [pointsReference count]; ++i) {
            [pointsReference removeObjectAtIndex: i];
            [pointsReference insertObject: [points objectAtIndex: i] atIndex: i];
        }
        
        [points removeAllObjects];
        
        [points addObject: [pointsReference objectAtIndex: 0]];
        [points addObject: [pointsReference objectAtIndex: 1]];
        [points addObject: [pointsReference objectAtIndex: 2]];
        [points addObject: [pointsReference objectAtIndex: 3]];
        
        
        // monta os pontos da spline
        float x, y, t;
        float a, b, c, d;
        
        for (int i = 0; i <= 30; i++) {
            t =  (float) (i) / 30;
            a = pow((1 - t), 3);
            b = 3 * t * pow((1 - t), 2);
            c = 3 * pow(t, 2) * (1 - t);
            d = pow(t, 3);
            
            x = (a * [(Pointer* )[points objectAtIndex:0] x]) + 
            (b * [(Pointer* )[points objectAtIndex:1] x]) + 
            (c * [(Pointer* )[points objectAtIndex:2] x]) + 
            (d * [(Pointer* )[points objectAtIndex:3] x]);
            y = (a * [(Pointer* )[points objectAtIndex:0] y]) + 
            (b * [(Pointer* )[points objectAtIndex:1] y]) + 
            (c * [(Pointer* )[points objectAtIndex:2] y]) + 
            (d * [(Pointer* )[points objectAtIndex:3] y]);
            
            
            Pointer * p = [[Pointer alloc] init:x :y :0.0f :1.0f];
            [p autorelease];
            [points addObject: p];
        }
        
        [super start];
        
        initialized = TRUE;
        return false;
    } else {
        return true;
    }
}

- (void)draw
{
	if (!initialized) {
		[self paintReferences];
		return;
	}
    
    float vertex[([points count] * 2) -4];
    
    int count = 0;
    
	for (int i = 4; i < [points count]; i++) {
		Pointer * p = [points objectAtIndex: i];
        vertex[count*2+0] = [p x];
        vertex[count*2+1] = [p y];
        count++;
	}
    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertex);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    glDrawArrays(GL_LINE_STRIP, 0, [points count] -4);
    
    [super draw];
}

/// metodo sobrescrito para poder disponibilizar somente os pontos
/// corretos para edicao
- (void)nextPointHighlights
{
	indexHighlights = (indexHighlights + 1) % [pointsReference count];
}

// metodo responsavel por desenhar as linhas guias do spline
- (void) paintReferences
{
    float vertex[[points count] * 2];
    
	for (int i = 0; i < [points count]; i++) {
		Pointer * p = [points objectAtIndex: i];
        vertex[i*2+0] = [p x];
        vertex[i*2+1] = [p y];
	}
    
    // Update attribute values.
    glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, 0, 0, vertex);
    glEnableVertexAttribArray(ATTRIB_VERTEX);
    
    glDrawArrays(GL_LINE_STRIP, 0, [points count]);
    
    [super draw];
    
}


@end