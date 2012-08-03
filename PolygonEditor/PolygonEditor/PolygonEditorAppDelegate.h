//
//  PolygonEditorAppDelegate.h
//  PolygonEditor
//
//  Created by Silvio Fragnani on 06/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PolygonEditorViewController;

@interface PolygonEditorAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet PolygonEditorViewController *viewController;

@end
