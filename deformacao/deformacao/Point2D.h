//
//  Point2D.h
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Point2D : NSObject
{
    double _x;
    double _y;
}

@property double x;
@property double y;

-(id)init;
-(id)initWith:(double)x y:(double)y;

@end
