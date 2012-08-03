//
//  ViewController.h
//  iMap
//
//  Created by Silvio Fragnani da Silva on 13/03/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) IBOutlet MKMapView *maps;
@property (strong, nonatomic) IBOutlet UISegmentedControl *typeMap;

- (IBAction)actionTypeMap:(id)sender;
- (IBAction)actionUserLocation:(id)sender;
- (IBAction)actionLocalHost:(id)sender;

@end
