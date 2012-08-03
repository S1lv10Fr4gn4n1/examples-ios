//
//  Color.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Color.h"

@interface Color()
- (void)initRandomColor;
@end

@implementation Color

@synthesize r,g,b;

- (id)init
{
    self = [super init];
    if (self) {
        [self initRandomColor];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

/// metodo responsavel iniciar uma cor aleatoria
- (void)initRandomColor
{
	unsigned char byte;
	
	byte = (rand() % 256);
	self.r = byte;
    
	byte = (rand() % 256);
	self.g = byte;
	
	byte = (rand() % 256);
	self.b = byte;
}

@end