//
//  ViewController.m
//  Acelerometro
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define SIZE_IMAGE 150

@interface ViewController ()
{
    float valueX;
    float valueY;
    float maxValueX;
    float maxValueY;
}
@end

@implementation ViewController

@synthesize button;
@synthesize labelX;
@synthesize labelY;
@synthesize labelZ;

- (id)init
{
    self = [super init];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    maxValueX = self.view.frame.size.width;
    maxValueY = self.view.frame.size.height;

    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:1.0/30.0];
    [[UIAccelerometer sharedAccelerometer] setDelegate:self]; 

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setButton:nil];
    [self setLabelX:nil];
    [self setLabelY:nil];
    [self setLabelZ:nil];
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
 	return interfaceOrientation == UIDeviceOrientationPortrait;
}

- (IBAction)actionButton:(id)sender 
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Accelerometer" 
                                                   message:@"METALLLLL!" 
                                                  delegate:self 
                                         cancelButtonTitle:@"Sorry!" 
                                         otherButtonTitles:nil];
    [alert show];
}

- (void)accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    valueX = acceleration.x*20 + button.frame.origin.x;
    valueY = -acceleration.y*20 + button.frame.origin.y;

    CGRect rect;
    if (valueX > maxValueX-SIZE_IMAGE || valueX < -10 || 
        valueY > maxValueY-SIZE_IMAGE || valueY < -10) {
        rect = CGRectMake(maxValueX/2 - SIZE_IMAGE/2, maxValueY/2 - SIZE_IMAGE/2, button.bounds.size.width, button.bounds.size.height);
    } else {
        rect = CGRectMake(valueX, valueY, button.bounds.size.width, button.bounds.size.height);
    }
    
    button.frame = rect;
}
@end
