//
//  ManagerSQLLiteSingleton.h
//  iExampleCoreData
//
//  Created by Silvio Fragnani da Silva on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface ManagerSQLiteSingleton : NSObject

+ (ManagerSQLiteSingleton*)instance;
- (NSArray*)executeQuery:(NSString*)sql paramns:(NSArray*)paramns error:(const char**) error;

@end
