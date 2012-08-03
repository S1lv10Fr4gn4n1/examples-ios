//
//  ViewController.h
//  iBrowserSQLite
//
//  Created by Silvio Fragnani da Silva on 20/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagerSQLiteSingleton.h"

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet UITextView *textSQL;
@property (strong, nonatomic) IBOutlet UITextView *commandText;
@property (strong, nonatomic) IBOutlet UITextView *resultText;
- (IBAction)actionExecute:(id)sender;
- (IBAction)actionClean:(id)sender;

@end
