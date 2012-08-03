//
//  MySecondViewController.h
//  WindowBase
//
//  Created by Silvio Fragnani on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MySecondViewController : UIViewController {
 //---create two outlets - label and button--- 
	UILabel *label; 
	UIButton *button;   
}

//---expose the outlets as properties--- 
@property (nonatomic, retain) UILabel *label; 
@property (nonatomic, retain) UIButton *button;

-(IBAction) buttonClicked: (id) sender; 

@end
