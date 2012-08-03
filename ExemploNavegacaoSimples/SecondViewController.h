//
//  SecondViewController.h
//  ExemploNavegacaoSimples
//
//  Created by Silvio Fragnani da Silva on 04/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController
{
    int count;
}

@property (retain, nonatomic) IBOutlet UILabel *label;
@property int count;

@end
