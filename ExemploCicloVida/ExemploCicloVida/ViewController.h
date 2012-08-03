//
//  ViewController.h
//  ExemploCicloVida
//
//  Created by Silvio Fragnani da Silva on 04/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    @private
    NSString * userName;
}

@property (weak, nonatomic) IBOutlet UILabel *labelText;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *buttonHello;

- (IBAction)buttonHello:(id)sender;

@end
