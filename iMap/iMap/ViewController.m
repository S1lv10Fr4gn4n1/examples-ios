//
//  ViewController.m
//  iMap
//
//  Created by Silvio Fragnani da Silva on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

//http://www.powersisweb.com.br/?p=946

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize maps;
@synthesize typeMap;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setMaps:nil];

    [self setTypeMap:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

- (IBAction)actionTypeMap:(id)sender 
{
    maps.mapType = typeMap.selectedSegmentIndex;
}

- (IBAction)actionUserLocation:(id)sender 
{
    [maps setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
}

- (IBAction)actionLocalHost:(id)sender 
{
    CLLocationCoordinate2D coord;
    //-26.85596, -49.11446
    coord.latitude = -26.85596;
    coord.longitude = -49.11446;
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 100, 100);
    [maps setRegion:region animated:YES];
    
    //[maps setCenterCoordinate:coord animated:YES];
    MKPointAnnotation *annotationPoint = [[MKPointAnnotation alloc] init];
    annotationPoint.coordinate = coord;
    annotationPoint.title = @"Home";
    annotationPoint.subtitle = @"My house";
    [maps addAnnotation:annotationPoint]; 

}
@end
