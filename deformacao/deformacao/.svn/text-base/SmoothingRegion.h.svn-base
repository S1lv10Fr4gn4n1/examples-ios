//
//  SmoothingRegion.h
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Body.h"
#import "LatticePoint.h"
#import "Vector2.h"
#import "Matrix2x2.h"
#import "ManagedList.h"
#import "ParticleAndDepth.h"
#import "NSMutableArray+QueueAdditions.h"

@interface SmoothingRegion : NSObject
{
    Body * _body;
    LatticePoint * _latticePoint;
    // regiao metade do comprimento
    int _w;
    NSMutableArray * _particles;
    // soma total de todas as particulas da regia
    double _m;
    // media ponderada de todas as posicoes de material das particulas
    Vector2 * _c0;
    // parte de Tr - (cr - Rr cr0)), melhor encaixe de translacao
    Vector2 * _o;
    // melhor encaixe de orientacao
    Matrix2x2 * _r;
}

@property(retain) Body * body;
@property(retain) LatticePoint * latticePoint;
@property int w;
@property(retain) NSMutableArray * particles;
@property double m;
@property(retain) Vector2 * c0;
@property(retain) Vector2 * o;
@property(retain) Matrix2x2 * r;

-(id)init;
-(id)initWith:(int)w;
-(void)addParticle:(Particle *)p;
-(void)removeParticle:(Particle *)p;
-(BOOL)containsParticle:(Particle *)p;
-(void)regenerateRegion;
-(void)calculateInvariants;
-(void)shapeMatch;
-(void)calculateDampedVelocities;

@end
