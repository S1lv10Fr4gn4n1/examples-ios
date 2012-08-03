//
//  NSMutableArray+QueueAdditions.h
//  deformacao
//
//  Created by Felipe Imianowsky on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions) 

-(id)dequeue;
-(void)enqueue:(id)obj;
-(id)peek:(int)index;
-(id)peekHead;
-(id)peekTail;
-(int)empty;

@end
