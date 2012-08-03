//
//  ManagedList.h
//  deformacao
//
//  Created by Felipe Imianowsky on 19/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManagedList : NSObject <NSFastEnumeration>
{
    NSMutableArray * _objects;
    NSMutableArray * _deadObjects;
    NSMutableArray * _recentObjects;
    int _numActiveEnumerators;
}

@property(retain) NSMutableArray * objects;
@property(retain) NSMutableArray * deadObjects;
@property(retain) NSMutableArray * recentObjects;
@property int numActiveEnumerators;

-(int)count;
-(void)addObject:(id)o;
-(void)removeObject:(id)o;
-(void)clean;
-(BOOL)containsObject:(id)o;
-(NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id *)buffer count:(NSUInteger)len;

@end
