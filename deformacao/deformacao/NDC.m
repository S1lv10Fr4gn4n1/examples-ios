//
//  NDC.m
//  deformacao
//
//  Created by Felipe Imianowsky on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "NDC.h"

@implementation NDC

+(double)x:(double)originalX
{
    // x * ((right - left) / width) + left;
    return originalX * ((1.0 - -1.0) / 320.0) + -1.0;
}

+(double)y:(double)originalY
{
    // y * ((bottom - top) / height) + top;
    return originalY * ((-1.0 - +1.0) / 480.0) + 1.0;
}

@end
