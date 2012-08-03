//
//  Body.h
//  deformacao
//
//  Created by Felipe Imianowsky on 18/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Particle.h"
#import "Point2D.h"
#import "Vector2.h"
#import "SmoothingRegion.h"
#import "World.h"

@interface Body : NSObject
{
    NSMutableArray * _blueprint;
    int _width;
    int _height;
    NSMutableArray *_lattice;
    NSMutableArray * _particles;
    NSMutableArray * _smoothingRegions;
    Point2D *_spacing;
    Vector2 *_offset;
    int _w;
    double _kRegionDamping;
}

@property(retain) NSMutableArray * blueprint;
@property int width;
@property int height;
@property(retain) NSMutableArray * lattice;
@property(retain) NSMutableArray * particles;
@property(retain) NSMutableArray * smoothingRegions;
@property(retain) Point2D * spacing;
@property(retain) Vector2 * offset;
@property(nonatomic) int w;
@property double kRegionDamping;

-(id)init;
-(BOOL)inBounds:(int)x y:(int)y;
-(void)generateFromBlueprint:(NSMutableArray *)blueprint;
-(void)changeW;
-(void)smooth;
-(void)updateParticles;
-(void)performRegionDamping;
-(void)calculateInvariants;
-(void)setW:(int)newW;

@end
