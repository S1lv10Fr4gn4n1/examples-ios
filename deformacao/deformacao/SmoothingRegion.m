//
//  SmoothingRegion.m
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SmoothingRegion.h"

@implementation SmoothingRegion

@synthesize body = _body;
@synthesize latticePoint = _latticePoint;
@synthesize w = _w;
@synthesize m = _m;
@synthesize particles = _particles;
@synthesize c0 = _c0;
@synthesize o = _o;
@synthesize r = _r;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.o = [[Vector2 alloc] init];
        self.r = [[Matrix2x2 alloc] init];
        self.particles = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(id)initWith:(int)w
{
    self = [super init];
    
    if (self) {
        self.o = [[Vector2 alloc] init];
        self.r = [[Matrix2x2 alloc] init];
        self.particles = [[NSMutableArray alloc] init];
        self.w = w;
    }
    
    return self;
}

-(void)addParticle:(Particle *)p
{
    [self.particles addObject:p];
    [p.parentRegions addObject:self];
}

-(void)removeParticle:(Particle *)p
{
    [p.parentRegions removeObject:self];
    [self.particles removeObject:p];
}

-(BOOL)containsParticle:(Particle *)p
{
    return [self.particles containsObject:p];
}

-(void)regenerateRegion
{
    for (Particle * p in self.particles) {
        [self removeParticle:p];
    }
    
    Particle * center = self.latticePoint.particle;
    
    NSMutableArray * toAdd = [[NSMutableArray alloc] init];
    
    [toAdd enqueue:[[ParticleAndDepth alloc] initWith:center depth:0]];
    
    while ([toAdd count] > 0) {
        ParticleAndDepth * t = [toAdd dequeue];
        
        if (t.particle != nil && ![self containsParticle:t.particle] && t.depth <= self.w) {
            
            [self addParticle:t.particle];
            
            [toAdd enqueue:[[ParticleAndDepth alloc] initWith:t.particle.xPos depth:t.depth + 1]];
            [toAdd enqueue:[[ParticleAndDepth alloc] initWith:t.particle.xNeg depth:t.depth + 1]];
            [toAdd enqueue:[[ParticleAndDepth alloc] initWith:t.particle.yPos depth:t.depth + 1]];
            [toAdd enqueue:[[ParticleAndDepth alloc] initWith:t.particle.yNeg depth:t.depth + 1]];
        }
    }
    
    // nao pode calcular invariantes ainda poruqe nao sabemos as massas por regiao das particulas
}

-(void)calculateInvariants
{
    self.m = 0;
    self.c0 = [[Vector2 alloc] init];
    
    for (Particle * p in self.particles) {
        self.m += [p perRegionMass];
        
        Vector2 * mult = [Vector2 multiply:p.x0 b:[p perRegionMass]];
        
        self.c0 = [Vector2 sum:self.c0 b:mult];
    }
    
    self.c0 = [Vector2 divide:self.c0 b:self.m];
}

-(void)shapeMatch
{
    if (self.m == 0)
        return;
    
    // calcula centro da massa
    Vector2 * c = [[Vector2 alloc] init];
    
    for (Particle * p in self.particles) {
        Vector2 * mult = [Vector2 multiply:p.x b:[p perRegionMass]];
        
        c = [Vector2 sum:c b:mult];
    }
    
    c = [Vector2 divide:c b:self.m];
    
    // calcula A = Sum(m~ ( xi - cr)(xi0 - cr0)^T ) - Eqn. 10
    Matrix2x2 * a = [Matrix2x2 zero];
    
    for (Particle * p in self.particles) {
        Vector2 * subx = [Vector2 subtract:p.x b:c];
        Vector2 * subx0 = [Vector2 subtract:p.x0 b:self.c0];
        
        Matrix2x2 * mwt = [Matrix2x2 multiplyWithTranspose:subx q:subx0];
        
        Matrix2x2 * mult = [Matrix2x2 multiply:mwt withDouble:[p perRegionMass]];
        
        a = [Matrix2x2 sum:a b:mult];
    }
    
    // decomposicao polar
    self.r = [a extractRotation];
    
    if (isnan([[[self.r.matrix objectAtIndex:0] objectAtIndex:0] doubleValue])) {
        self.r = [Matrix2x2 identity];
    }
    
    // verifica por um formato invertido
    if ([self.r determinant] < 0) {
        self.r = [Matrix2x2 multiply:self.r withDouble:-1.0];
    }
    
    // calcula o, parte restante de Tr
    Vector2 * c0neg = [Vector2 negative:self.c0];
    Vector2 * multrc0neg = [Matrix2x2 multiply:self.r withVector:c0neg];
    self.o = [Vector2 sum:c b:multrc0neg];
    
    // adiciona nossa influencia as posicoes das particulas objetivo
    Vector2 * sumAppliedForces = [Vector2 zero];
    
    for (Particle * p in self.particles) {
        // descobre a posicao objetivo de acordo com a regiao, Tr * p.x0
        Vector2 * multrx0 = [Matrix2x2 multiply:self.r withVector:p.x0];
        Vector2 * particleGoalPosition = [Vector2 sum:self.o b:multrx0];
        
        Vector2 * multpgm = [Vector2 multiply:particleGoalPosition b:[p perRegionMass]];
        
        p.goal = [Vector2 sum:p.goal b:multpgm];
        
        Matrix2x2 * multrm = [Matrix2x2 multiply:self.r withDouble:[p perRegionMass]];
        p.r = [Matrix2x2 sum:p.r b:multrm];
        
        // apenas para verificar
        Vector2 * sumgoalx = [Vector2 subtract:particleGoalPosition b:p.x];
        
        Vector2 * multgoalx = [Vector2 multiply:sumgoalx b:[p perRegionMass]];
        
        sumAppliedForces = [Vector2 sum:sumAppliedForces b:multgoalx];
    }
    
    // verificacao de erro
    if ([sumAppliedForces length] > 0.001) {
        NSLog(@"Forma de combinacao das regioes nao somou ate zero");
    }
}

-(void)calculateDampedVelocities
{
    // de Mueller et al., posicoes baseadas dinamicas
    if ([self.particles count] > 1) {
        double l = 0;
        double i = 0;
        
        Vector2 * v = [Vector2 zero];
        Vector2 * c = [Vector2 zero];
        
        for (Particle * p in self.particles) {
            Vector2 * multpx = [Vector2 multiply:p.x b:[p perRegionMass]];
            
            Vector2 * multpv = [Vector2 multiply:p.v b:[p perRegionMass]];
            
            c = [Vector2 sum:c b:multpx];
            v = [Vector2 sum:v b:multpv];
        }
        
        c = [Vector2 divide:c b:self.m];
        v = [Vector2 divide:v b:self.m];
        
        for (Particle * p in self.particles) {
            Vector2 * ri = [Vector2 subtract:p.x b:c];
            Vector2 * multpv = [Vector2 multiply:p.v b:[p perRegionMass]];
            
            l += [ri crossProduct:multpv];
            i += [p perRegionMass] * [ri lengthSq];
        }
        
        double w = l / i;
        
        for (Particle * p in self.particles) {
            Vector2 * ri = [Vector2 subtract:p.x b:c];
            Vector2 * vw = [[Vector2 alloc] initWith:-w * ri.y y:w * ri.x]; 
            
            Vector2 * sumvw = [Vector2 sum:v b:vw];
            Vector2 * dv = [Vector2 subtract:sumvw b:p.v];
            
            Vector2 * multdv = [Vector2 multiply:dv b:[p perRegionMass]];
            
            p.dv = [Vector2 sum:p.dv b:multdv];
        }
    }
}

@end
