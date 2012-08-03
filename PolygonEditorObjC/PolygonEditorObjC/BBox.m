//
//  BBox.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BBox.h"


@implementation BBox

@synthesize xMin;
@synthesize xMax;
@synthesize yMin;
@synthesize yMax;
@synthesize zMin;
@synthesize zMax;    


- (id)init
{
    self = [super init];
    if (self) {
        [self start];
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

/// inicializacoes
- (void) start
{
	self.xMax = self.yMax = self.zMax = -1000000;
	self.xMin = self.yMin = self.zMin =  1000000;	
}

/// metodo responsavel por identificar se o ponto passado, esta
/// entre os valores minimo e maximo do bbox
- (BOOL) inBBox: (float) _x: (float) _y: (float) _z
{
	if ((_x < self.xMax && _x > self.xMin) &&
		(_y < self.yMax && _x > self.yMin)) {
		return YES;
	}
	
	return NO;

}

/// metodo responsavel por identificar se o ponto passado, esta
/// entre os valores minimo e maximo do bbox
- (BOOL) inBBox: (Pointer *) value
{
	if (([value x] < self.xMax && [value x] > self.xMin) &&
		([value y] < self.yMax && [value y] > self.yMin)) {
		return YES;
	}
	
	return NO;
	
}

@end