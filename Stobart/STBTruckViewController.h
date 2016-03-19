//
//  STBTruckViewController.h
//  Stobart
//
//  Created by Matthew Hallatt on 28/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import UIKit;
@import MapKit;

@class Truck;

@interface STBTruckViewController : UIViewController

@property (nonatomic, strong) Truck *truck;

@property (nonatomic, weak) IBOutlet UILabel   *lastSpottedLabel;
@property (nonatomic, weak) IBOutlet UILabel   *numberOfSightingsLabel;
@property (nonatomic, weak) IBOutlet UILabel   *sightingsDescriptionLabel;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, weak) IBOutlet UIButton  *addSightingButton;

@end
