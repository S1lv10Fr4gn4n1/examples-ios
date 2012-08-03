//
//  ViewBasicAppDelegate.h
//  ViewBasic
//
//  Created by Silvio Fragnani on 09/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewBasicViewController;

@interface ViewBasicAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet ViewBasicViewController *viewController;

@end
