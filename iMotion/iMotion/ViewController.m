//
//  ViewController.m
//  iMotion
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

#define MUL 20
#define TIME 10.0

@interface ViewController ()
{
    CMMotionManager *cmManager;
}
@end

@implementation ViewController

@synthesize accelerometerLabel;
@synthesize gyroLabel;
@synthesize magnetometerLabel;
@synthesize deviceMotionLabel;
@synthesize dataAccelerometerLabel;
@synthesize dataGyroLabel;
@synthesize dataMagnetometerLabel;
@synthesize dataDeviceMotionLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    cmManager = [[CMMotionManager alloc]init];
    if ([cmManager isAccelerometerAvailable]) {
        cmManager.accelerometerUpdateInterval = 1.0/TIME;
        [cmManager startAccelerometerUpdates];
        accelerometerLabel.text = @"Accelerometer Available!";
    }
    
    if ([cmManager isGyroAvailable]) {
        cmManager.gyroUpdateInterval = 1.0/TIME;
        [cmManager startGyroUpdates];
        gyroLabel.text = @"Gyro Available!";
    }
    
    if ([cmManager isMagnetometerAvailable]) {
        cmManager.magnetometerUpdateInterval = 1.0/TIME;
        [cmManager startMagnetometerUpdates];
        NSLog(@"%@", @"Magnetometer Available!");
        magnetometerLabel.text = @"Magnetometer Available!";
    }
    
    if ([cmManager isDeviceMotionAvailable]) {
        cmManager.deviceMotionUpdateInterval = 1.0/TIME;
        [cmManager startDeviceMotionUpdates];
        deviceMotionLabel.text = @"Device Motion Available!";
    }
    
    
    [NSTimer scheduledTimerWithTimeInterval:1.0/TIME 
                                     target:self 
                                   selector:@selector(cmTime:) 
                                   userInfo:nil 
                                    repeats:YES];

}

- (void)viewDidUnload
{
    [cmManager stopGyroUpdates];
    [cmManager stopDeviceMotionUpdates];
    [cmManager stopAccelerometerUpdates];
    [cmManager stopMagnetometerUpdates];
    
    [self setAccelerometerLabel:nil];
    [self setGyroLabel:nil];
    [self setMagnetometerLabel:nil];
    [self setDeviceMotionLabel:nil];
    [self setDataAccelerometerLabel:nil];
    [self setDataGyroLabel:nil];
    [self setDataMagnetometerLabel:nil];
    [self setDataDeviceMotionLabel:nil];
    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

- (void)cmTime:(NSTimer *) theTime
{
    // informacoes do acelerometro
    CMAccelerometerData *accelerometer = [cmManager accelerometerData];
    dataAccelerometerLabel.text = [[NSString alloc]initWithFormat:@"x: %3.3f, y: %3.3f, z: %3.3f", 
                                   accelerometer.acceleration.x*MUL, 
                                   accelerometer.acceleration.y*MUL, 
                                   accelerometer.acceleration.z*MUL];
    
    CMGyroData *gyro = [cmManager gyroData];
    dataGyroLabel.text = [[NSString alloc]initWithFormat:@"x: %3.3f, y: %3.3f, z: %3.3f", 
                          gyro.rotationRate.x*MUL, 
                          gyro.rotationRate.y*MUL, 
                          gyro.rotationRate.z*MUL];
    
    CMMagnetometerData *magnetometer = [cmManager magnetometerData];
    dataMagnetometerLabel.text = [[NSString alloc]initWithFormat:@"x: %3.3f, y: %3.3f, z: %3.3f", 
                                  magnetometer.magneticField.x*MUL,
                                  magnetometer.magneticField.y*MUL,
                                  magnetometer.magneticField.z*MUL];
    
}

@end
