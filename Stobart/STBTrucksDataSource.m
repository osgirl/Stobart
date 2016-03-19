//
//  STBTrucksDataSource.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBTrucksDataSource.h"

// Application
#import "AppDelegate.h"

// Cells
#import "STBTruckCell.h"

// Core Data
#import "STBCoreDataCoordinator.h"

@interface STBTrucksDataSource ()

@property (nonatomic, strong) STBCoreDataCoordinator *coreDataCoordinator;

@property (nonatomic, strong) NSArray *trucks;

@end

@implementation STBTrucksDataSource

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
  [self setupCoreDataCoordinator];
  
  [self fetchTrucks];
}

- (void)setupCoreDataCoordinator;
{
  AppDelegate *appDelegate = (id)[[UIApplication sharedApplication] delegate];
  
  self.coreDataCoordinator = appDelegate.coreDataCoordinator;
}

- (void)fetchTrucks;
{
  NSEntityDescription *truckDescription = [NSEntityDescription entityForName:@"Truck"
                                                      inManagedObjectContext:self.coreDataCoordinator.managedObjectContext];
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
  
  [fetchRequest setEntity:truckDescription];
  
  NSError *fetchTrucksError;
  
  self.trucks = [self.coreDataCoordinator.managedObjectContext executeFetchRequest:fetchRequest
                                                                             error:&fetchTrucksError];
  
  if (fetchTrucksError) {
    NSLog(@"Error fetching trucks: %@", fetchTrucksError.userInfo);
  }
}

- (void)reloadData;
{
  [self fetchTrucks];
}

- (id)objectAtIndex:(NSIndexPath *)indexPath;
{
  return self.trucks[indexPath.row];
}

- (NSInteger)numberOfSections;
{
  return 1;
}

- (NSInteger)numberOfItemsInSection:(NSInteger)section;
{
  return self.trucks.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  STBTruckCell *cell = [tableview dequeueReusableCellWithIdentifier:[STBTruckCell reuseIdentifier]];
  
  [cell populateWithTruck:[self objectAtIndex:indexPath]];
  
  return cell;
}

- (NSString *)segueIdentifier;
{
  return @"STBShowTruckSegueIdentifier";
}

@end
