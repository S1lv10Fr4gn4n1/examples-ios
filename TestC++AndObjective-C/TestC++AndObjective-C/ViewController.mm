//
//  ViewController.m
//  TestC++AndObjective-C
//
//  Created by Silvio Fragnani da Silva on 11/06/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    Test *test;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    test = new Test();
    
//    float * matrix = new float[16];
    int * days = new int() = {31,28,31,30,31,30,31,31,30,31,30,31};
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

- (IBAction)actionBtn:(id)sender 
{
    NSLog(@"valor program: %i", test->getProgram());
}
@end
