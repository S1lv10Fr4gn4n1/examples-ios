//
//  main.m
//  TesteNSTask
//
//  Created by Silvio Fragnani da Silva on 22/12/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

int main (int argc, const char * argv[])
{

    @autoreleasepool {
        system("ls -la /bin");
//        NSTask *netstat = [[NSTask alloc] init];
//        NSTask *grep   =  [[NSTask alloc] init];
//        
//        [netstat setLaunchPath:@"/usr/sbin/netstat"];
//        [netstat setArguments:[NSArray arrayWithObject:@"-rn"]];
//        
//        [grep setLaunchPath:@"/usr/bin/grep"];
//        [grep setArguments:[NSArray arrayWithObject:@"default"]];
//        
//        NSPipe *pipe = [[NSPipe alloc] init];
//        
//        [netstat setStandardError:[NSFileHandle fileHandleWithNullDevice]];
//        [grep setStandardError:[NSFileHandle fileHandleWithNullDevice]];
//        
//        [netstat setStandardOutput:pipe];
//        [grep setStandardInput:pipe];
//        
//        pipe = [[NSPipe alloc] init];
//        
//        [grep setStandardOutput:pipe];
//        
//        [netstat launch];
//        [grep launch];
//        
//        NSData *data = [[[grep standardOutput] fileHandleForReading] readDataToEndOfFile];
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        
//        NSTask *task = [[NSTask alloc] init];
////        [task setCurrentDirectoryPath:@"/home"];
////        [task setLaunchPath:@"/bin/ls"];
////        [task setArguments:[NSArray arrayWithObjects: @"-la",nil]];
//        
//        [task setLaunchPath:@"/bin/bash"];
//        [task setArguments:[NSArray arrayWithObjects: @"-c", @"/usr/sbin/netstat -rn | /usr/bin/grep default", nil]];
//        
//        NSPipe *pipe = [NSPipe pipe];
//        [task setStandardOutput:pipe];
//        [task setStandardError: pipe];
//        
//        [task launch];
//        
//        NSData *data = [[pipe fileHandleForReading] readDataToEndOfFile];
//        
//        [task waitUntilExit];
//        
//        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog (@"got\n%@", string);
        
    }
    return 0;
}
