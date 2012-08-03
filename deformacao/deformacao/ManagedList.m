//
//  ManagedList.m
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ManagedList.h"

@implementation ManagedList

@synthesize objects = _objects;
@synthesize deadObjects = _deadObjects;
@synthesize recentObjects = _recentObjects;
@synthesize numActiveEnumerators = _numActiveEnumerators;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.objects = [[NSMutableArray alloc] init];
        self.deadObjects = [[NSMutableArray alloc] init];
        self.recentObjects = [[NSMutableArray alloc] init];
        self.numActiveEnumerators = 0;
    }
    
    return self;
}

-(int)count
{
    return [self.objects count] - [self.deadObjects count];
}

-(void)addObject:(id)o;
{
    if (self.numActiveEnumerators == 0) {
        [self.objects addObject:o];
    
    } else {
        [self.recentObjects addObject:o];
    }
}

-(void)removeObject:(id)o;
{
    if (self.numActiveEnumerators == 0) {
        [self.objects removeObject:o];
        
    } else {
        [self.deadObjects addObject:o];
    }
}

-(void)clean
{
    for (id o in self.deadObjects) {
        [self.objects removeObject:o];
    }
    
    for (id o in self.recentObjects) {
        [self.objects addObject:o];
    }
    
    [self.deadObjects removeAllObjects];
    [self.recentObjects removeAllObjects];
}

-(BOOL)containsObject:(id)o;
{
    return (([self.objects containsObject:o] || [self.recentObjects containsObject:o]) && ![self.deadObjects containsObject:o]);
}

-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)buffer count:(NSUInteger)len {
    return 0;
}


@end
