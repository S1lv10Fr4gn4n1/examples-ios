//
//  Color.m
//  PolygonEditorObjC
//
//  Created by Silvio Fragnani on 11/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Color.h"


@implementation Color

@synthesize r,g,b;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

@end