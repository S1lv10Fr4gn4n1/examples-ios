//
//  ViewController.m
//  ExemploActionSheet
//
//  Created by Silvio Fragnani da Silva on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize buttonSheet;
@synthesize buttonActionSheet;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setButtonSheet:nil];
    [self setButtonActionSheet:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (IBAction)actionButtonSheet:(id)sender 
{
    UIActionSheet *aSheet = [[UIActionSheet alloc] initWithTitle:@"Deseja processeguir?" 
                                                        delegate:self 
                                               cancelButtonTitle:@"Não" 
                                          destructiveButtonTitle:@"Sim" 
                                               otherButtonTitles:@"De repente", nil];
    [aSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSString * msg = NULL;
    switch (buttonIndex) {
        case 0:
            msg = @"Sim - 0";
            break;
            
        case 1:
            msg = @"Talvez - 1";
            break;
            
        case 2:
            msg = @"De repente - 2";
            break;
        
        case 3:
            msg = @"Não - 3";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Você apertou o botão:" 
                                                    message:msg 
                                                   delegate:self 
                                          cancelButtonTitle:@"Valeu" 
                                          otherButtonTitles:@"Ok", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
//    switch (buttonIndex) {
//        case 0:
//            
//            break;
//            
//        default:
//            break;
//    }
}
@end
