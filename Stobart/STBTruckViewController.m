//
//  STBTruckViewController.m
//  Stobart
//
//  Created by Matthew Hallatt on 28/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBTruckViewController.h"

// Application
#import "AppDelegate.h"

// Categories
#import "NSDateFormatter+STBDateFormatters.h"
#import "UIColor+STBColors.h"

// CoreData
#import "STBCoreDataCoordinator.h"

// Entities
#import "Truck.h"
#import "TruckLocation.h"

@implementation STBTruckViewController

- (void)viewWillAppear:(BOOL)animated;
{
  [super viewWillAppear:animated];
  
  if (self.truck) {
    [self reloadData];
  }
}

- (void)reloadData;
{
  self.title = self.truck.name;
  
  self.lastSpottedLabel.text            = [NSDateFormatter stb_lastSpottedStringFromDate:self.truck.date];
  self.numberOfSightingsLabel.text      = [NSString stringWithFormat:@"%@", self.truck.numberOfSightings];
  self.sightingsDescriptionLabel.text   = [self sightingsStringForCount:[self.truck.numberOfSightings integerValue]];
  self.numberOfSightingsLabel.textColor = [UIColor stb_greenColor];
  
  [self.truck.location enumerateObjectsUsingBlock:^(TruckLocation *truckCoordinate, BOOL *stop) {
    CLLocationCoordinate2D truckLocation = CLLocationCoordinate2DMake(truckCoordinate.latitude.doubleValue,
                                                                      truckCoordinate.longitude.doubleValue);
    MKPlacemark *placemark = [MKPlacemark.alloc initWithCoordinate:truckLocation addressDictionary:nil];
    [self.mapView addAnnotation:placemark];
  }];
  
  [self.mapView showAnnotations:self.mapView.annotations animated:NO];
}

- (IBAction)addSighting:(id)sender;
{
  NSInteger currentSightingsCount = [self.truck.numberOfSightings integerValue];
  self.truck.numberOfSightings = @(currentSightingsCount + 1);
  self.truck.date = NSDate.new;
  
  STBCoreDataCoordinator *coreDataCoordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataCoordinator];
  
  NSError *saveUpdateSightingsError;
  [coreDataCoordinator saveContextWithError:&saveUpdateSightingsError];
  
  if (saveUpdateSightingsError) {
    NSLog(@"Error updating sightings for truck %@: %@", self.truck.name, saveUpdateSightingsError.userInfo);
  }
  
  [self reloadData];
}

- (NSString *)sightingsStringForCount:(NSInteger)sightings;
{
  NSString *sightingString = @"Sighting";
  
  if (sightings > 1) {
    sightingString = @"Sightings";
  }
  
  return [NSString stringWithFormat:@"%@ of this truck", sightingString];
}

@end
