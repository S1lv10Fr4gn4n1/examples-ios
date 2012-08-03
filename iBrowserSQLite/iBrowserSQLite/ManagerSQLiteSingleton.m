//
//  ManagerSQLLiteSingleton.m
//  iExampleCoreData
//
//  Created by Silvio Fragnani da Silva on 19/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ManagerSQLiteSingleton.h"


@interface ManagerSQLiteSingleton()
{
    NSString *databasePath;
}

- (void)initializeDB;
- (NSString*)prepareSQL:(NSString*)querySql paramns:(NSArray*)paramns;

@end

@implementation ManagerSQLiteSingleton

- (id)init
{
    self = [super init];
    
    if (self) {
        [self initializeDB];
    }
    
    return self;
}

+ (ManagerSQLiteSingleton*)instance
{
    static ManagerSQLiteSingleton *manager = NULL;
    
    if (!manager) {
        manager = [[ManagerSQLiteSingleton alloc]init];
    }
    
    return manager;
}

- (NSArray*)executeQuery:(NSString*)sql paramns:(NSArray*)paramns error:(const char**) error
{
    NSString *querySql = [self prepareSQL: sql paramns: paramns];
    
    sqlite3 *sqlite;
    sqlite3_stmt *statement;
    NSMutableArray *result = NULL;
    NSMutableDictionary *itemResult = NULL;
    
    if (sqlite3_open([databasePath UTF8String], &sqlite) == SQLITE_OK) {
        if (sqlite3_prepare_v2(sqlite, [querySql UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            result = [[NSMutableArray alloc]init];
            int countColumn = sqlite3_column_count(statement);
            int typeColumn = -1;
            NSString *nameColumn = NULL;
            
            while (sqlite3_step(statement) != SQLITE_DONE) {
                itemResult = [[NSMutableDictionary alloc]init];
                
                for (int i=0; i<countColumn; i++) {
                    typeColumn = sqlite3_column_type(statement, i);
                    nameColumn = [[NSString alloc] initWithUTF8String:sqlite3_column_name(statement, i)];
                    
                    switch (typeColumn) {
                        case SQLITE_INTEGER:
                            [itemResult setObject:[[NSNumber alloc]initWithInt:sqlite3_column_int64(statement, i)] forKey:nameColumn];
                            break;
                        case SQLITE_FLOAT:
                            [itemResult setObject:[[NSNumber alloc]initWithFloat:sqlite3_column_double(statement, i)] forKey:nameColumn];
                            break;
                        case SQLITE_BLOB:
                        {
                            int blobLength = sqlite3_column_bytes(statement, i);
                            NSData *data = [NSData dataWithBytes:sqlite3_column_blob(statement, i) length:blobLength];
                            [itemResult setObject:data forKey:nameColumn];
                            break;
                        }
                        case SQLITE_NULL:
                            [itemResult setObject:[NSNull null] forKey:nameColumn];
                            break;
                        case SQLITE_TEXT:
                        {
                            NSString * data = [[NSString alloc]initWithUTF8String:(const char *)sqlite3_column_text(statement, i)];
                            [itemResult setObject:data forKey:nameColumn];
                            break;
                        }
                    }
                }
                
                [result addObject:itemResult];
            }
            
            sqlite3_finalize(statement);
        }

        *error = sqlite3_errmsg(sqlite);
        
        sqlite3_close(sqlite);
    }
    
    return result;    
}

- (NSString*)prepareSQL:(NSString*)querySql paramns:(NSArray*)paramns
{
    return querySql;
}

- (void)initializeDB
{
    NSString *docsDir = NULL;
    NSArray *dirPaths = NULL;
    sqlite3  *sqlite;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsDir = [dirPaths objectAtIndex:0];
    
    // Build the path to the database file
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"iBrowserSQLite.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
//    if ([filemgr removeItemAtPath: databasePath error: NULL]  == YES)
//        NSLog (@"Remove successful");
//    else
//        NSLog (@"Remove failed");
    
    if ([filemgr fileExistsAtPath: databasePath ] == NO) {
        const char *dbpath = [databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &sqlite) == SQLITE_OK) {
            char *errMsg;
            
            // lendo script de criacao de base
            NSString *filePathScript = [[NSBundle mainBundle] pathForResource:@"scriptDB" ofType:@"sql"];
            NSData *dataScriptDB = [NSData dataWithContentsOfFile:filePathScript];
            NSString *scriptString = NULL;
            
            if (dataScriptDB) {
                scriptString = [[NSString alloc] initWithData:dataScriptDB encoding:NSASCIIStringEncoding];
                
            }
            const char *sql_stmt = [scriptString UTF8String];
            
            if (sqlite3_exec(sqlite, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK) {
                NSLog(@"%@: %s", @"Failed to create table", errMsg);
            }
            
            sqlite3_close(sqlite);                
        } else {
            NSLog(@"%@", @"Failed to open/create database");
        }
    }
}

@end
