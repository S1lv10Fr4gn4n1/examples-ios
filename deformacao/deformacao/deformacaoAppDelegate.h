//
//  deformacaoAppDelegate.h
//  deformacao
//
//  Created by Silvio Fragnani on 09/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class deformacaoViewController;

@interface deformacaoAppDelegate : NSObject <UIApplicationDelegate> 
{
}

@property(nonatomic, retain) IBOutlet UIWindow *window;
@property(nonatomic, retain) IBOutlet deformacaoViewController *viewController;

@end
