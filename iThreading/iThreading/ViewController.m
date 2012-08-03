//
//  ViewController.m
//  iThreading
//
//  Created by Silvio Fragnani da Silva on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (void)doingSomething:(SEL)after;
- (void)test01;
- (void)test02;

- (void)schedulerLocalNotificationWithDate;

@end

@implementation ViewController
@synthesize labelCount;

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self schedulerLocalNotificationWithDate];
    
    [NSTimer scheduledTimerWithTimeInterval:1 
                                     target:self 
                                   selector:@selector(timeCmd:) 
                                   userInfo:NULL 
                                    repeats:YES];
}

- (void)viewDidUnload
{
    [self setLabelCount:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)doingSomething:(SEL)after
{
    for (int i=0; i<=5000; i++) {
        NSLog(@"count: %d", i);
    }
    
    [self performSelector:@selector(after)];
}


- (IBAction)actionTest01:(id)sender {
    [self performSelectorInBackground:@selector(doingSomething:) withObject:nil];
}

- (IBAction)actionTest02:(id)sender {
    [self performSelectorInBackground:@selector(doingSomething:) withObject:nil];
}

- (IBAction)actionStopNotification:(id)sender {
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)timeCmd:(NSTimer*)theTimer
{
    [labelCount setText: [[NSString alloc]initWithFormat:@"%@",[NSDate date]]];
}

- (void)test01
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Title" 
                                                    message:@"Test01" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)test02
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"Title" 
                                                    message:@"Test02" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                          otherButtonTitles:nil];
    [alert show];
}

- (void)schedulerLocalNotificationWithDate
{
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    
    NSDate *mydate = [NSDate date];
    NSTimeInterval seconds = 60;
    mydate = [mydate dateByAddingTimeInterval:seconds];
    
    [notification setFireDate: mydate];
    [notification setAlertBody:@"Foge mano!!!!"];
    [notification setSoundName:@"Air Raid Siren.mp3"];
    [notification setAlertAction:@"Fuga"];
    [notification setApplicationIconBadgeNumber:2];
    [notification setAlertLaunchImage:@"smiley-punk.jpg"];
    
    [[UIApplication sharedApplication]scheduleLocalNotification:notification];
}

@end
