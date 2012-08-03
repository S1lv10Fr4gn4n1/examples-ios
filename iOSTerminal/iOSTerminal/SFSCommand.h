//
//  SFSCommand.h
//  iOSTerminal
//
//  Created by Silvio Fragnani da Silva on 25/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SFSCommand : NSObject

@property (weak, nonatomic) NSString * currentPath;
@property (weak, nonatomic) NSString * command;
@property (weak, nonatomic) NSArray * arguments;

@end
