//
//  AppDelegate.m
//  ExemploCicloVida
//
//  Created by Silvio Fragnani da Silva on 04/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (void)logStatus:(UIApplication *)application method:(NSString *) method
{
    int statusCode = application.applicationState;
    NSString *currentState = [NSString stringWithFormat:@"\nMetodo %@\nEstado Atual: %@", 
                              method,
                              statusCode == UIApplicationStateActive? @"Ativa":
                              statusCode == UIApplicationStateBackground ? @"Background": @"Inativa"];
    NSLog(@"%@", currentState);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self logStatus:application method:@"didFinishLaunchingWithOptions"];
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */

    [self logStatus:application method:@"applicationWillResignActive"];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
    [self logStatus:application method:@"applicationDidEnterBackground"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
    [self logStatus:application method:@"applicationWillEnterForeground"];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    [self logStatus:application method:@"applicationDidBecomeActive"];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
    [self logStatus:application method:@"applicationWillTerminate"];
}

@end
