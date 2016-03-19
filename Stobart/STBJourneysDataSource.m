//
//  STBJourneysDataSource.m
//  Stobart
//
//  Created by Matthew Hallatt on 12/07/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBJourneysDataSource.h"

// Application
#import "AppDelegate.h"

// Cells
#import "STBTruckCell.h"

// Core Data
#import "STBCoreDataCoordinator.h"

// Models
#import "Journey.h"

@interface STBJourneysDataSource ()

@property (nonatomic, strong) STBCoreDataCoordinator *coreDataCoordinator;

@property (nonatomic, strong) NSArray *journeys;

@end

@implementation STBJourneysDataSource

- (instancetype)init
{
  self = [super init];
  
  if (self) {
    [self setup];
  }
  
  return self;
}

- (void)setup;
{
  [self fetchJourneys];
}

- (void)fetchJourneys;
{
  NSEntityDescription *truckDescription = [NSEntityDescription entityForName:@"Journey"
                                                      inManagedObjectContext:self.coreDataCoordinator.managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  
  [fetchRequest setEntity:truckDescription];
  
  NSError *fetchJourneysError;
  
  self.journeys = [self.coreDataCoordinator.managedObjectContext executeFetchRequest:fetchRequest
                                                                               error:&fetchJourneysError];
  
  if (fetchJourneysError) {
    NSLog(@"Error fetching journeys: %@", fetchJourneysError.userInfo);
  }
}

- (void)reloadData;
{
  [self fetchJourneys];
}

- (id)objectAtIndex:(NSIndexPath *)indexPath;
{
  if (self.numberOfSections > 1 && indexPath.section == 0) {
    return self.coreDataCoordinator.currentJourney;
  }
  
  return self.journeys[indexPath.row];
}

- (NSInteger)numberOfSections;
{
  return self.coreDataCoordinator.currentJourney ? 2 : 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
{
  if (self.numberOfSections > 1 && section == 0) {
    return 1;
  }
  return self.journeys.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.numberOfSections > 1 && indexPath.section == 0) {
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:STBTruckCell.reuseIdentifier];
    cell.backgroundColor = UIColor.yellowColor;
    cell.textLabel.text = self.coreDataCoordinator.currentJourney.name;
    return cell;
  }
  
  STBTruckCell *cell = [tableview dequeueReusableCellWithIdentifier:STBTruckCell.reuseIdentifier];
  
  [cell populateWithTruck:[self objectAtIndex:indexPath]];
  
  return cell;
}

- (STBCoreDataCoordinator *)coreDataCoordinator;
{
  return _coreDataCoordinator ?: ({
    _coreDataCoordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataCoordinator];
  });
}

- (NSString *)segueIdentifier;
{
  return @"STBShowJourneySegueIdentifier";
}

@end
