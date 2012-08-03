//
//  MySecondViewController.m
//  WindowBase
//
//  Created by Silvio Fragnani on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MySecondViewController.h"

@implementation MySecondViewController

@synthesize label, button;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{	
	[super viewDidLoad];
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
	//---create a CGRect for the positioning--- 
	CGRect frame = CGRectMake(230, 10, 300, 50);
	//---create a Label view--- 
	label = [[UILabel alloc] initWithFrame:frame]; 
	label.textAlignment = UITextAlignmentCenter;
	
	
	label.font = [UIFont fontWithName:@"Verdana" size:20]; 
	label.text = @"This is a label";
	
	//---create a Button view--- 
	frame = CGRectMake(230, 100, 300, 50); 
	button = [UIButton buttonWithType:UIButtonTypeRoundedRect]; 
	button.frame = frame; [button setTitle:@"OK" forState:UIControlStateNormal]; 
	button.backgroundColor = [UIColor clearColor];
	
	
	//---add the action handler and set current class as target--- 
	SEL clickEvent = @selector(buttonClicked:);
	[button addTarget: self
			   action: clickEvent 
	 forControlEvents: UIControlEventTouchUpInside];
	
	/* Event possiveis
	UIControlEventTouchDown 
	UIControlEventTouchDownRepeat 
	UIControlEventTouchDragInside 
	UIControlEventTouchDragOutside 
	UIControlEventTouchDragEnter 
	UIControlEventTouchDragExit 
	UIControlEventTouchUpInside 
	UIControlEventTouchUpOutside 
	UIControlEventTouchCancel 
	UIControlEventValueChanged 
	UIControlEventEditingDidBegin 
	UIControlEventEditingChanged 
	UIControlEventEditingDidEnd 
	UIControlEventEditingDidEndOnExit 
	UIControlEventAllTouchEvents 
	UIControlEventAllEditingEvents 
	UIControlEventApplicationReserved 
	UIControlEventSystemReserved 
	UIControlEventAllEvents
	*/
	
	//---add the views to the View window--- 
	[self.view addSubview:label]; 
	[self.view addSubview:button];
    
	[super viewDidLoad];
}


- (void)viewDidUnload
{
	[label release];
	[button release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

-(IBAction) buttonClicked: (id) sender {
	
	/*
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Action invoked" 
													message: @"Button clicked" 
												   delegate: self 
										  cancelButtonTitle: @"OK" 
										  otherButtonTitles: nil];
	[alert show];
	[alert release];
	 */

}

@end
