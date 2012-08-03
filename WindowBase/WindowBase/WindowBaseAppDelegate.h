//
//  WindowBaseAppDelegate.h
//  WindowBase
//
//  Created by Silvio Fragnani on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

//---add a forward reference to the HelloWorldViewController class---
@class MyViewController;

@interface WindowBaseAppDelegate : NSObject <UIApplicationDelegate> {
	MyViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

//---expose the view controller as a property--- @property (nonatomic, retain) IBOutlet
@property (nonatomic, retain) IBOutlet MyViewController *viewController;

@end
