#import "SomeClass.h"

// For name of notification
NSString * const NOTIF_DataComplete = @"DataComplete";

@interface SomeClass(private)
- (void) dataDownloadComplete:(NSNotification *)notif;
@end


@implementation SomeClass

//notifications of data downloads 
- (void)downloadDataComplete:(NSNotification *)notif 
{
    NSLog(@"Received Notification - Data has been downloaded");
}

//initialization
- (id)init
{
    self = [super init];
    
    if (self) {
        // Register observer for when download of data is complete
        [[NSNotificationCenter defaultCenter] addObserver:self 
                                                 selector:@selector(downloadDataComplete:) 
                                                     name:NOTIF_DataComplete 
                                                   object:nil]; 
    }
    return self;
}

//cleanup  
- (void)dealloc 
{
  [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)anyThing
{
    NSLog(@"%@", @"Notificatino Center");
}

@end
