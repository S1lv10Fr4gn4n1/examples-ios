//
//  NDC.h
//  PolygonEditor
//
//  Created by Elizandro Schramm on 11/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pointer.h"

@interface NDC : NSObject{
@private
    Pointer * maxWindow;
    Pointer * minWindow;
    Pointer * maxOrtho;
    Pointer * minOrtho;
}

@property (nonatomic, strong) Pointer * maxWindow;
@property (nonatomic, strong) Pointer * minWindow;
@property (nonatomic, strong) Pointer * maxOrtho;
@property (nonatomic, strong) Pointer * minOrtho;

- (double) calcDeltaO: (double) _maxWindow: (double) _minWindow;
- (double) calcDeltaD: (double) _maxOrtho: (double) _minOrtho;

- (void) calcCoordinates: (Pointer *) point;
//- (void) calcNewMaxOrtho: (Pointer *) _maxOrtho: (Pointer *) _minOrtho;

@end
