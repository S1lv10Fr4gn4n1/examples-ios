//
//  LocationViewController.m
//  iLocation
//
//  Created by Silvio Fragnani da Silva on 11/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LocationViewController.h"

@interface LocationViewController ()
{
    CLLocationManager *location;
}

- (void)updateData;

@end

@implementation LocationViewController
@synthesize labelAltitude;
@synthesize labelCoordenadas;
@synthesize labelCurso;
@synthesize labelHorizontalAccuracy;
@synthesize labelSpeed;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    location = [[CLLocationManager alloc]init];
    location.desiredAccuracy = kCLLocationAccuracyBest;
    location.distanceFilter = 30;
//    [location startUpdatingHeading];
    [location startUpdatingLocation];
    
    [self updateData];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0/1.0 target:self 
                                                   selector:@selector(cmTime:) 
                                                   userInfo:nil 
                                                    repeats:YES];
}

- (void)viewDidUnload
{
    [location stopUpdatingHeading];
    [location stopUpdatingLocation];
    
    [self setLabelAltitude:nil];
    [self setLabelCoordenadas:nil];
    [self setLabelCurso:nil];
    [self setLabelHorizontalAccuracy:nil];
    [self setLabelSpeed:nil];

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft;
}

- (void)cmTime:(NSTimer*)theTimer
{
    [self updateData];
}

- (void)updateData
{
    labelAltitude.text = [[NSString alloc]initWithFormat:@"Altitude: %f m (acima do mar)", location.location.altitude];
    labelCoordenadas.text = [[NSString alloc]initWithFormat:@"Coordenadas: %f lat %f lon", 
                             location.location.coordinate.latitude,
                             location.location.coordinate.longitude];
    labelCurso.text = [[NSString alloc]initWithFormat:@"Curso: %f graus", location.location.course];
    labelHorizontalAccuracy.text = [[NSString alloc]initWithFormat:@"Horizontal Accuracy: %f (qnt menor melhor)", location.location.horizontalAccuracy];
    labelSpeed.text = [[NSString alloc]initWithFormat:@"Speed: %f m/s", location.location.speed];

}

- (IBAction)actionUpdate:(id)sender 
{
    [self updateData];
}
@end
