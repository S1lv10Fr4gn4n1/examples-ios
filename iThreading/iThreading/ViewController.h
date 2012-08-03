//
//  ViewController.h
//  iThreading
//
//  Created by Silvio Fragnani da Silva on 26/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *labelCount;

- (IBAction)actionTest01:(id)sender;
- (IBAction)actionTest02:(id)sender;
- (IBAction)actionStopNotification:(id)sender;

@end
