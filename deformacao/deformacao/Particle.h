//
//  Particle.h
//  deformacao
//
//  Created by Felipe Imianowsky on 17/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Vector2.h"
#import "LatticePoint.h"
#import "ManagedList.h"

@class Body;
@class Matrix2x2;

@interface Particle : NSObject
{
    Body * _body;
    LatticePoint * _latticePoint;
    BOOL _locked;
    Particle * _xPos;
    Particle * _yPos;
    Particle * _xNeg;
    Particle * _yNeg;
    NSMutableArray * _parentRegions;
    
    double _mass;
    // posicao
    Vector2 * _x;
    // velocity
    Vector2 * _v;
    // posicao do material
    Vector2 * _x0;
    // forca externa
    Vector2 * _fExt;
    Vector2 * _goal;
    // media de todas as regioes, usa em fratura
    Matrix2x2 * _r;
    // damping
    Vector2 * _dv;
}

@property(retain) Body * body;
@property(retain) LatticePoint * latticePoint;
@property BOOL locked;
@property(retain) Particle * xPos;
@property(retain) Particle * yPos;
@property(retain) Particle * xNeg;
@property(retain) Particle * yNeg;
@property(retain) NSMutableArray * parentRegions;
@property double mass;
@property(retain) Vector2 * x;
@property(retain) Vector2 * v;
@property(retain) Vector2 * x0;
@property(retain) Vector2 * fExt;
@property(retain) Vector2 * goal;
@property(retain) Matrix2x2 * r;
@property(retain) Vector2 * dv;

-(id)init;
-(double)perRegionMass;

@end
