//
//  ViewController.h
//  Acelerometro
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIAccelerometerDelegate>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *labelX;
@property (weak, nonatomic) IBOutlet UILabel *labelY;
@property (weak, nonatomic) IBOutlet UILabel *labelZ;

- (IBAction)actionButton:(id)sender;

@end
