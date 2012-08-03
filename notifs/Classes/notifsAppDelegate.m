#import "notifsAppDelegate.h"
#import "SomeClass.h"

@implementation notifsAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application 
{
    [window makeKeyAndVisible];
  
    SomeClass *someclass = [[SomeClass alloc] init];
    
    //...At some point, post a notification that the data has been downloaded  
    [[NSNotificationCenter defaultCenter] postNotificationName:NOTIF_DataComplete object:nil];
    
    [someclass anyThing];
}

@end
