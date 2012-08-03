//
//  RectangleBlueprint.m
//  deformacao
//
//  Created by Felipe Imianowsky on 18/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "RectangleBlueprint.h"

@implementation RectangleBlueprint

@synthesize blueprint = _blueprint;

-(id)init
{
    self = [super init];
    
    if (self) {
        self.blueprint = [[NSMutableArray alloc] init];
        [self construct];
    }
    
    return self;
}

+(RectangleBlueprint *)sharedInstance
{
    static RectangleBlueprint * sharedInstance;
    
    @synchronized(self) {
        if (!sharedInstance) {
            sharedInstance = [[RectangleBlueprint alloc] init];
        }
        
        return sharedInstance;
    }
}

-(void)construct
{
    for (int i = 0; i < 50; i++) {
        [self.blueprint addObject:[[NSMutableArray alloc] init]];
    }
    
    for (NSMutableArray * columns in self.blueprint) {
        for (int i = 0; i < 50; i++) {
            [columns addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    int width = 15;
    int height = 4;
    
    for (int i = 0; i < width; i++) {
        NSMutableArray * columns = [self.blueprint objectAtIndex:i];
        
        for (int j = 0; j < height; j++) {
            [columns replaceObjectAtIndex:j withObject:[NSNumber numberWithBool:YES]];
        }
    }
}

@end
