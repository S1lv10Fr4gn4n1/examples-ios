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

- (NSArray*)executeQuery:(NSString*)sql paramns:(NSArray*)paramns
{
    NSString *querySql = [self prepareSQL: sql paramns: paramns];
    
    sqlite3  *sqlite;
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
        //NSLog(@"%s", sqlite3_errmsg(sqlite));
        
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
    databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"myApp.db"]];
    
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
            NSString *filePathScript = [[NSBundle mainBundle] pathForResource:@"script" ofType:@"sql"];
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

/*
- (void) saveData
{
    sqlite3_stmt    *statement;
    
    const char *dbpath = [databasePath UTF8String];
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *insertSQL = [NSString stringWithFormat: @"INSERT INTO CONTACTS (name, address, phone) VALUES (\"%@\", \"%@\", \"%@\")", name.text, address.text, phone.text];
        
        const char *insert_stmt = [insertSQL UTF8String];
        
        sqlite3_prepare_v2(contactDB, insert_stmt, -1, &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            status.text = @"Contact added";
            name.text = @"";
            address.text = @"";
            phone.text = @"";
        } else {
            status.text = @"Failed to add contact";
        }
        sqlite3_finalize(statement);
        sqlite3_close(contactDB);
    }
}

- (void) findContact
{
    const char *dbpath = [databasePath UTF8String];
    sqlite3_stmt    *statement;
    
    if (sqlite3_open(dbpath, &contactDB) == SQLITE_OK)
    {
        NSString *querySQL = [NSString stringWithFormat: @"SELECT address, phone FROM contacts WHERE name=\"%@\"", name.text];
        
        const char *query_stmt = [querySQL UTF8String];
        
        if (sqlite3_prepare_v2(contactDB, query_stmt, -1, &statement, NULL) == SQLITE_OK)
        {
            if (sqlite3_step(statement) == SQLITE_ROW)
            {
                NSString *addressField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 0)];
                address.text = addressField;
                
                NSString *phoneField = [[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statement, 1)];
                phone.text = phoneField;
                
                status.text = @"Match found";
                
                [addressField release];
                [phoneField release];
            } else {
                status.text = @"Match not found";
                address.text = @"";
                phone.text = @"";
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(contactDB);
    }
}

*/


//http://www.sqlite.org/c3ref/funclist.html
//sqlite3_open() - Opens specified database file. If the database file does not already exist, it is created.
//sqlite3_close() - Closes a previously opened database file.
//sqlite3_prepare_v2() - Prepares a SQL statement ready for execution.
//sqlite3_step() - Executes a SQL statement previously prepared by the sqlite3_prepare_v2() function.
//sqlite3_column_<type>() - Returns a data field from the results of a SQL retrieval operation where <type> is replaced by the data type of the data to be extracted (text, blob, bytes, int, int16 etc).
//sqlite3_finalize() - Deletes a previously prepared SQL statement from memory.
//sqlite3_exec() - Combines the functionality of sqlite3_prepare_v2(), sqlite3_step() and sqlite3_finalize() into a single function call.



//
//CREATE TABLE parent(a PRIMARY KEY, b UNIQUE, c, d, e, f);
//CREATE UNIQUE INDEX i1 ON parent(c, d);
//CREATE INDEX i2 ON parent(e);
//CREATE UNIQUE INDEX i3 ON parent(f COLLATE nocase);

//
//CREATE TABLE child1(f, g REFERENCES parent(a));                        -- Ok
//CREATE TABLE child2(h, i REFERENCES parent(b));                        -- Ok
//CREATE TABLE child3(j, k, FOREIGN KEY(j, k) REFERENCES parent(c, d));  -- Ok

//NULL. The value is a NULL value.
//
//INTEGER. The value is a signed integer, stored in 1, 2, 3, 4, 6, or 8 bytes depending on the magnitude of the value.
//
//REAL. The value is a floating point value, stored as an 8-byte IEEE floating point number.
//
//TEXT. The value is a text string, stored using the database encoding (UTF-8, UTF-16BE or UTF-16LE).
//
//BLOB. The value is a blob of data, stored exactly as it was input.

/*
 
 
 */


@end
