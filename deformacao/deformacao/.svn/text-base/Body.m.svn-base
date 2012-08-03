//
//  Body.m
//  deformacao
//
//  Created by Felipe Imianowsky on 18/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Body.h"

@implementation Body

@synthesize blueprint = _blueprint;
@synthesize width = _width;
@synthesize height = _height;
@synthesize lattice = _lattice;
@synthesize particles = _particles;
@synthesize smoothingRegions = _smoothingRegions;
@synthesize spacing = _spacing;
@synthesize offset = _offset;
@synthesize w = _w;
@synthesize kRegionDamping = _kRegionDamping;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.particles = [[NSMutableArray alloc] init];
        self.smoothingRegions = [[NSMutableArray alloc] init];
        self.offset = [[Vector2 alloc] initWith:200.0f y:200.0f];
        self.spacing = [[Point2D alloc] initWith:10.0f y:10.0f];
        self.w = 3;
        self.kRegionDamping = 0.5;
    }
    
    return self;
}

-(BOOL)inBounds:(int)x y:(int)y
{
    return (x >= 0 && y >= 0 && x < self.width && y < self.height);
}

-(void)generateFromBlueprint:(NSMutableArray *)bp 
{
    self.blueprint = bp;
    self.width = [bp count];
    self.height = [[bp objectAtIndex:0] count];
    
    self.lattice = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < self.width; i++) {
        [self.lattice addObject:[[NSMutableArray alloc] init]];
        
        for (int j = 0; j < self.height; j++) {
            LatticePoint * lat = [[LatticePoint alloc] init];
            
            lat.index = [[Point2D alloc] init];
            
            if ([[[bp objectAtIndex:i] objectAtIndex:j] boolValue]) {
                // gera particula
                Particle * p = [[Particle alloc] init];
                lat.particle = p;
                p.body = self;
                p.x0 = [[Vector2 alloc] initWith:self.spacing.x * i y:self.spacing.y * j];
                p.x = [Vector2 sum:self.offset b:p.x0];
                p.latticePoint = lat;
                p.goal = p.x;
                [self.particles addObject:p];
            }
            
            [[self.lattice objectAtIndex:i] addObject:lat];
        }
    }
    
    // configura vizinhos
    for (int i = 0; i < self.width; i++) {
        for (int j = 0; j < self.height; j++) {
            LatticePoint * lat = [[self.lattice objectAtIndex:i] objectAtIndex:j];
            
            if ([[[bp objectAtIndex:i] objectAtIndex:j] boolValue]) {
                
                LatticePoint * latx1 = [[self.lattice objectAtIndex:i+1] objectAtIndex:j];
                
                BOOL bpx1 = [[[bp objectAtIndex:i+1] objectAtIndex:j] boolValue];
                
                if ([self inBounds:i+1 y:j] && bpx1) {
                    lat.particle.xPos = latx1.particle;
                    latx1.particle.xNeg = lat.particle;
                }
                
                BOOL bpj1 = [[[bp objectAtIndex:i] objectAtIndex:j+1] boolValue];
                
                if ([self inBounds:i y:j+1] && bpj1) {
                    LatticePoint * laty1 = [[self.lattice objectAtIndex:i] objectAtIndex:j+1];
                    
                    lat.particle.yPos = laty1.particle;
                    laty1.particle.yNeg = lat.particle;
                }
            }
        }
    }
    
   // cria a suavizacao de regioes e faz com que se gerem sozinhas
    for (Particle * p in self.particles) {
        SmoothingRegion * s = [[SmoothingRegion alloc] initWith:self.w];
        s.body = self;
        s.latticePoint = p.latticePoint;
        s.latticePoint.smoothingRegion = s;
        [s regenerateRegion];
        
        [self.smoothingRegions addObject:s];
    }
    
    // configura regioes
    for (SmoothingRegion * s in self.smoothingRegions) {
        [s calculateInvariants];
    }
}

-(void)changeW
{
    for (SmoothingRegion * s in self.smoothingRegions) {
        s.w = self.w;
    }
}

-(void)smooth
{
    // regiao de suavizacao
    for (Particle * p in self.particles) {
        p.goal = [Vector2 zero];
        p.r = [Matrix2x2 zero];
    }
    
    for (SmoothingRegion * s in self.smoothingRegions) {
        [s shapeMatch];
    }
    
    for (Particle * p in self.particles) {
        p.goal = [Vector2 divide:p.goal b:p.mass];
        p.r = [Matrix2x2 divide:p.r b:p.mass];
    }
}

-(void)updateParticles
{
    // calcula velocidade
    for (Particle * p in self.particles) {
        
        Vector2 * divfext = [Vector2 divide:p.fExt b:p.mass];
        
        if ([p.parentRegions count] != 0) {
            Vector2 * subgoalx = [Vector2 subtract:p.goal b:p.x];
            
            Vector2 * sumds = [Vector2 sum:divfext b:subgoalx];
            
            // Eqn. (1), h = 1.0
            p.v = [Vector2 sum:p.v b:sumds];
            
        } else {
            // nao temos regioes pais, entao move como uma particula independente
            p.goal = p.x;
            p.v = [Vector2 sum:p.v b:divfext];
        }
        
        p.fExt = [Vector2 zero];
    }
    
    // velocidade deslize
    [self performRegionDamping];
    
    // aplica velocidade
    for (Particle * p in self.particles) {
        if (!p.locked) {
            p.x = [Vector2 sum:p.x b:p.v toFloat:YES];
        } else {
            p.v = [Vector2 zero];
        }
    }
}

-(void)performRegionDamping
{
    if (self.kRegionDamping != 0.0) {
        // velocidade de deslize por regiao
        for (Particle * particle in self.particles) {
            particle.dv = [Vector2 zero];
        }
        
        for (SmoothingRegion * r in self.smoothingRegions) {
            [r calculateDampedVelocities];
        }
        
        for (Particle * particle in self.particles) {
            particle.dv = [Vector2 divide:particle.dv b:particle.mass];
            
            Vector2 * multdvdamp = [Vector2 multiply:particle.dv b:self.kRegionDamping];
            
            particle.v = [Vector2 sum:particle.v b:multdvdamp];
        }
    }
}

-(void)calculateInvariants
{
    for (SmoothingRegion * s in self.smoothingRegions) {
        [s calculateInvariants];
    }
}

-(void)setW:(int)newW
{
    _w = newW;
    
    for (Body * b in [World sharedInstance].bodies) {
        [b changeW];
    }
}


@end
