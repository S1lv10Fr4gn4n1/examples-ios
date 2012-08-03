//
//  ViewController.h
//  ExemploActionSheet
//
//  Created by Silvio Fragnani da Silva on 20/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIActionSheetDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl *buttonSheet;
@property (weak, nonatomic) IBOutlet UIButton *buttonActionSheet;

- (IBAction)actionButtonSheet:(id)sender;
@end
