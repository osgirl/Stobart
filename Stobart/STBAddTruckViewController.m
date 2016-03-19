//
//  STBAddTruckViewController.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBAddTruckViewController.h"

// Application
#import "AppDelegate.h"

// Categories
#import "UIColor+STBColors.h"

// Core Data
#import "STBCoreDataCoordinator.h"

// Entities
#import "Journey.h"
#import "Truck.h"
#import "TruckLocation.h"
#import "TruckSighting.h"

@interface STBAddTruckViewController () <UITextFieldDelegate, CLLocationManagerDelegate>

@property (nonatomic, assign) BOOL hasLocation;

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation STBAddTruckViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  self.nameTextField.returnKeyType = UIReturnKeyDone;
  self.nameTextField.delegate = self;
  
  self.addTruckButton.backgroundColor = [UIColor stb_greenColor];
  
  [self beginLocationTracking];
}

- (void)beginLocationTracking;
{
  self.locationManager = CLLocationManager.new; {
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    self.locationManager.delegate = self;
  }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
  [self.nameTextField resignFirstResponder];
  
  return YES;
}

- (IBAction)addTruck:(id)sender;
{
  if (!self.hasLocation) {
    [[UIAlertView.alloc initWithTitle:@"No location"
                              message:@"We have not yet tracked your location"
                             delegate:self
                    cancelButtonTitle:@"Ok"
                    otherButtonTitles:nil] show];
    return;
  }
  
  [self.nameTextField resignFirstResponder];
  
  STBCoreDataCoordinator *coreDataCoordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataCoordinator];
  
  Truck *newTruck = [NSEntityDescription insertNewObjectForEntityForName:@"Truck"
                                                            inManagedObjectContext:coreDataCoordinator.managedObjectContext];
  
  newTruck.name = self.nameTextField.text;
  
  TruckLocation *truckLocation = [self truckLocationWithLatitude:self.locationManager.location.coordinate.latitude
                                                       longitude:self.locationManager.location.coordinate.longitude
                                                         context:coreDataCoordinator.managedObjectContext];
  
  TruckSighting *sighting = [self truckSightingWithLocation:truckLocation context:coreDataCoordinator.managedObjectContext];
  
  [newTruck addSightingObject:sighting];
  
  [coreDataCoordinator.currentJourney addTrucksObject:newTruck];
  
  NSError *saveError;
  [coreDataCoordinator saveContextWithError:&saveError];
  
  if (saveError) {
    NSLog(@"Error creating truck with name '%@': %@", newTruck.name, saveError.userInfo);
  }
  
  [self performSegueWithIdentifier:@"UnwindToHomeSegueIdentifier" sender:self];
}

- (TruckLocation *)truckLocationWithLatitude:(double)latitude longitude:(double)longitude context:(NSManagedObjectContext *)context;
{
  TruckLocation *location = [NSEntityDescription insertNewObjectForEntityForName:@"TruckLocation"
                                                          inManagedObjectContext:context]; {
    location.latitude  = @(latitude);
    location.longitude = @(longitude);
  }
  return location;
}

- (TruckSighting *)truckSightingWithLocation:(TruckLocation *)location context:(NSManagedObjectContext *)context;
{
  TruckSighting *sighting = [NSEntityDescription insertNewObjectForEntityForName:@"TruckSighting"
                                                          inManagedObjectContext:context]; {
    sighting.date     = NSDate.new;
    sighting.location = location;
  }
  return sighting;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
{
  self.hasLocation = locations.count > 0;
}

@end
