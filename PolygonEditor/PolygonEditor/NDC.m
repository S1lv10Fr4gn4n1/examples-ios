//
//  NDC.m
//  PolygonEditor
//
//  Created by Elizandro Schramm on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NDC.h"

@implementation NDC

@synthesize  maxWindow;
@synthesize minWindow;
@synthesize maxOrtho;
@synthesize minOrtho;


- (double) calcDeltaO: (double) _maxWindow: (double) _minWindow
{
    return _maxWindow - _minWindow;
}

- (double) calcDeltaD: (double) _maxOrtho: (double) _minOrtho
{
    return _maxOrtho - _minOrtho;
}

- (void) calcCoordinates: (Pointer *) point
{
    //Pointer * p = [[Pointer alloc] init:0 :0 :0 :1];
    double deltaO, deltaD;
    deltaO = [self calcDeltaO:[maxWindow x] :[minWindow x]];
    deltaD = [self calcDeltaD:[maxOrtho x] :[minOrtho x]];
    point.x = (point.x * (deltaD / deltaO)) + minOrtho.x;
    deltaO = [self calcDeltaO:maxWindow.y :minWindow.y];
    deltaD = [self calcDeltaD:maxOrtho.y :minOrtho.y];
    point.y = ((maxWindow.y - point.y) * (deltaD /deltaO)) + minOrtho.y;
    //return p;
}

/*- (void) calcNewMaxOrtho: (Pointer *) _maxOrtho: (Pointer *) _minOrtho
{   
    double deltaOx, deltaOy, deltaDx, deltaDy;
    deltaOx = [self calcDeltaO:maxWindow.x :minWindow.x];
    deltaOy = [self calcDeltaO:maxWindow.y :minWindow.y];
    deltaDx = [self calcDeltaD:1 :-1];
    deltaDy = [self calcDeltaD:1 :-1];
    double razaox, razaoy;
    razaox = (deltaDx / deltaOx);
    razaoy = (deltaDy / deltaOy);
    
    _maxOrtho = [[Pointer alloc] init:1 :1 :0 :1];
    _minOrtho = [[Pointer alloc] init:-1 :-1 :0 :1];
    
    double f, d;
    if(razaox > razaoy){
        f = (razaoy * deltaOx) / 2;
        d = f * -1;
        //o.setLeft(d);
        _minOrtho.x = d;
        //o.setRight(f);
        _maxOrtho.x = f;
    } else if(razaox < razaoy){
        f = (razaox * deltaOy) / 2;
        d = f * -1;
        //o.setBottom(d);
        _minOrtho.y = d;
        //o.setTop(f);
        _maxOrtho.y = f;
    } 
    
}*/






























@end
