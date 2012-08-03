//
//  SFSViewController.m
//  iOSTerminal
//
//  Created by Silvio Fragnani da Silva on 24/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SFSViewController.h"


@interface SFSViewController()
{
    NSMutableString * stringCmdText;
    NSString * cursor;
}

- (void)initialize;
- (NSString *)executeCommand: (SFSCommand *) cmd;
- (SFSCommand *)makeCommand:(NSString *) strCmd;
- (NSString *)getStringCommand:(NSString *) string 
                    rangeStart:(NSRange) rangeStart 
                      rangeEnd:(NSRange) rangeEnd;


//- (NSArray *)allFiles:(NSString *)startPath ;

@end

@implementation SFSViewController
@synthesize cmdText;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self initialize];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setCmdText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)initialize
{
    NSString * deviceName = [[UIDevice currentDevice] name];
    NSMutableString * cursorAux = [[NSMutableString alloc]init];
    [cursorAux appendString:@"iOS-"];
    [cursorAux appendString:deviceName];
    [cursorAux appendString:@"$"];
    cursor = cursorAux;
    
    stringCmdText = [[NSMutableString alloc] initWithString:cursor];
    
    [cmdText setText:stringCmdText];
    [cmdText becomeFirstResponder];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(editingText)
                                                 name:UITextViewTextDidChangeNotification
                                               object:cmdText];
}

- (void)editingText
{
    [stringCmdText setString: [cmdText text]];
    
    NSRange rangeStart = [stringCmdText rangeOfString:cursor options:NSBackwardsSearch];
    NSRange rangeEnd = [stringCmdText rangeOfString:@"\n" options:NSBackwardsSearch];
    
    if ((rangeEnd.location != NSNotFound) && ([stringCmdText length] == (rangeEnd.location +1))) {
        NSString * stringAux = [self getStringCommand:stringCmdText 
                                           rangeStart:rangeStart 
                                             rangeEnd: rangeEnd];
        
        SFSCommand * command = [self makeCommand:stringAux];
        NSString * strResult = [self executeCommand:command];
            
        [stringCmdText appendString:strResult];
        [stringCmdText appendString:cursor];
        [cmdText setText:stringCmdText];          
    }
}

- (NSString *)getStringCommand:(NSString *)string 
                    rangeStart:(NSRange)rangeStart 
                      rangeEnd:(NSRange)rangeEnd
{
    NSRange range;
    range.location = rangeStart.location + rangeStart.length;
    range.length = rangeEnd.location - range.location;
    
//    NSMutableString * stringAux = [[NSMutableString alloc]init];
//    [stringAux appendString:[string substringWithRange:range]];
//    stringAux re
    return [string substringWithRange:range];
}

- (SFSCommand *)makeCommand:(NSString *)strCmd
{
    SFSCommand * command = [[SFSCommand alloc]init];
    [command setCommand:@"/Developer/usr/bin/shark"];
    //[command setCommand:@"/usr/sbin/ipconfig"];
    //[command setArguments:[NSArray arrayWithObjects:@"getoption", @"en0", @"router", nil]];
//    [command setCurrentPath:@"/bin/"];

    return command;
}

- (NSString *)executeCommand: (SFSCommand *)cmd
{
    
//    NSArray * array = [self allFiles: @"/"];
//    for (NSString *s in array) {
        NSLog(@"%@", s);
//    }
    
    /*
    NSTask *task = [NSTask new];
    [task setLaunchPath:@"/bin/ls"];
    [task setArguments:[NSArray arrayWithObjects:@"-lart", @"/", nil]];
    
    NSPipe *pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    [task launch];
    
    NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
    
    [task waitUntilExit];
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog (@"got\n%@", string);
      */

    NSTask * task = [[NSTask alloc] init];
//    [task setCurrentDirectoryPath:[cmd currentPath]];
    [task setLaunchPath:[cmd command]];
//    [task setArguments: [cmd arguments]];

    NSPipe * pipe = [NSPipe pipe];
    [task setStandardOutput:pipe];
    
    if (![task isRunning]) {
        [task launch];
    }
    
    
    
    NSData * data = [[pipe fileHandleForReading] readDataToEndOfFile];

    [task waitUntilExit];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
//    NSTask *netstat = [[NSTask alloc] init];
//    NSTask *grep   =  [[NSTask alloc] init];
//    
//    [netstat setLaunchPath:@"/usr/sbin/netstat"];
//    [netstat setArguments:[NSArray arrayWithObject:@"-rn"]];
//    
//    [grep setLaunchPath:@"/usr/bin/grep"];
//    [grep setArguments:[NSArray arrayWithObject:@"default"]];
//    
//    NSPipe *pipe = [[NSPipe alloc] init];
//    
//    [netstat setStandardError:[NSFileHandle fileHandleWithNullDevice]];
//    [grep setStandardError:[NSFileHandle fileHandleWithNullDevice]];
//    
//    [netstat setStandardOutput:pipe];
//    [grep setStandardInput:pipe];
//    
//    pipe = [[NSPipe alloc] init];
//    
//    [grep setStandardOutput:pipe];
//    
//    [netstat launch];
//    [grep launch];
//    
//    NSData *data = [[[grep standardOutput] fileHandleForReading] readDataToEndOfFile];
//    return  [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
//    return @"";
}

/*
- (NSArray *)allFiles:(NSString *)startPath    
{
    NSMutableArray * listing = [NSMutableArray array];
    NSArray * fileNames = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:startPath error:nil];

    if (!fileNames) 
        return listing;

    for (NSString * file in fileNames) {
        NSString * absPath = [startPath stringByAppendingPathComponent:file];
        BOOL isDir = NO;
        if ([[NSFileManager defaultManager] fileExistsAtPath:absPath isDirectory:&isDir]) {
            if (isDir) {
                [listing addObject:absPath];
                [listing addObjectsFromArray:[self allFiles:absPath]];
            } else {
                [listing addObject:absPath];
            }
        }
    }
    return listing;
}*/

@end
