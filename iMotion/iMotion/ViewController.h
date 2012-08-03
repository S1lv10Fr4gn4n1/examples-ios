//
//  ViewController.h
//  iMotion
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *accelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *gyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *magnetometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceMotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataAccelerometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataMagnetometerLabel;
@property (weak, nonatomic) IBOutlet UILabel *dataDeviceMotionLabel;

@end
