//
//  LocationViewController.h
//  iLocation
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocationManagerDelegate.h>

@interface LocationViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *labelAltitude;
@property (weak, nonatomic) IBOutlet UILabel *labelCoordenadas;
@property (weak, nonatomic) IBOutlet UILabel *labelCurso;
@property (weak, nonatomic) IBOutlet UILabel *labelHorizontalAccuracy;
@property (weak, nonatomic) IBOutlet UILabel *labelSpeed;
- (IBAction)actionUpdate:(id)sender;
@end
