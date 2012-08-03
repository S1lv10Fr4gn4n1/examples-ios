//
//  HelloNEONViewController.m
//  HelloNEON
//
//  Created by Silvio Fragnani da Silva on 01/05/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HelloNEONViewController.h"

@interface HelloNEONViewController ()
{
    NEONCommand *neon;
}
@end

@implementation HelloNEONViewController


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
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    neon = new NEONCommand();
    neon->executeNEON();
    delete neon;
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


@end
