//
//  STBJourneyViewController.m
//  Stobart
//
//  Created by Matthew Hallatt on 12/07/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBJourneyViewController.h"

// Application
#import "AppDelegate.h"

// Core Data
#import "STBCoreDataCoordinator.h"

// Entities
#import "Journey.h"

@interface STBJourneyViewController ()

@property (nonatomic, strong) STBCoreDataCoordinator *coreDataCoordinator;

@property (nonatomic, weak) IBOutlet UILabel *trucksCountLabel;

@property (nonatomic, weak) IBOutlet UIButton *endJourneyButton;

@end

@implementation STBJourneyViewController

#pragma mark - View Controller Lifecycle Methods

- (void)viewWillAppear:(BOOL)animated;
{
  [super viewWillAppear:animated];
  
  self.title = self.journey.name;
  
  self.trucksCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.journey.trucks.count];
  
  if (self.coreDataCoordinator.currentJourney != self.journey) {
    self.endJourneyButton.alpha = 0.f;
  }
}

#pragma mark - Button Action Methods

- (IBAction)endJourney:(id)sender;
{
  self.journey.endDate = NSDate.new;
  
  NSError *saveError;
  [self.coreDataCoordinator saveContextWithError:&saveError];
  
  if (saveError) {
    NSLog(@"Error ending current journey named '%@': %@", self.journey.name, saveError.userInfo);
  }
  
  self.coreDataCoordinator.currentJourney = nil;
  self.endJourneyButton.alpha = 0.f;
}

- (STBCoreDataCoordinator *)coreDataCoordinator;
{
  return _coreDataCoordinator ?: ({
    _coreDataCoordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataCoordinator];
  });
}

@end
