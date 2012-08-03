//
//  AppDelegate.h
//  ExemploNavegacaoSimples
//
//  Created by Silvio Fragnani da Silva on 04/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FirstViewController.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    UINavigationController *navController;
}
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navController;

//@property (strong, nonatomic) ViewController *viewController;

@end
