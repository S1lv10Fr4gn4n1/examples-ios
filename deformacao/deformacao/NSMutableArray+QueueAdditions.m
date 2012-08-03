//
//  NSMutableArray+QueueAdditions.m
//  deformacao
//
//  Created by Felipe Imianowsky on 20/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

@implementation NSMutableArray (QueueAdditions) 

-(void) enqueue:(id)anObject
{
    [self addObject:anObject];
}

-(id)dequeue
{
    if ([self count] == 0) {
        return nil;
    }
    id queueObject = [self objectAtIndex:0];
    [self removeObjectAtIndex:0];
    return queueObject;
}

-(id)peek:(int)index
{
	if ([self count] == 0 || index < 0) {
        return nil;
    }
	return [self objectAtIndex:index];
}

-(id)peekHead
{
	return [self peek:0];
}

-(id)peekTail
{
	return [self peek:([self count]-1)];
}

-(int)empty
{
	if ([self count] == 0) {
        return true;
    } else {
		return false;
	}
}

@end
