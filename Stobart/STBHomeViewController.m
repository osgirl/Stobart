//
//  STBHomeViewController.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBHomeViewController.h"

// Data
#import "STBJourneysDataSource.h"
#import "STBTableViewDataSource.h"
#import "STBTrucksDataSource.h"

// Views
#import "STBTruckCell.h"

// View Controlers
#import "STBJourneyViewController.h"
#import "STBTruckViewController.h"

@interface STBHomeViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedControl;

@property (nonatomic, weak) IBOutlet STBTrucksDataSource *trucksDataSource;
@property (nonatomic, weak) IBOutlet STBJourneysDataSource *journeysDataSource;

@property (nonatomic, strong) id<STBTableViewDataSource> currentDataSource;

@end

@implementation STBHomeViewController

- (void)awakeFromNib;
{
  [super awakeFromNib];
  
  [self.tableView registerClass:[STBTruckCell class]
         forCellReuseIdentifier:[STBTruckCell reuseIdentifier]];
  
  self.tableView.sectionHeaderHeight = 0.f;
  self.tableView.tableFooterView     = UIView.new;
  
  self.currentDataSource = self.trucksDataSource;
}

- (void)viewWillAppear:(BOOL)animated;
{
  [super viewWillAppear:animated];
  
  [self reloadData];
}

- (IBAction)segmentedControlUpdated:(UISegmentedControl *)segmentedControl;
{
  NSInteger selectedIndex = segmentedControl.selectedSegmentIndex;
  
  switch (selectedIndex) {
    case 0:
      self.currentDataSource = self.trucksDataSource;
      break;
      
    case 1:
      self.currentDataSource = self.journeysDataSource;
      break;
      
    default:
      break;
  }
  
  [self reloadData];
}

- (void)reloadData;
{
  [self.currentDataSource reloadData];
  [self.tableView reloadData];
}

- (IBAction)unwindToHome:(UIStoryboardSegue *)sender;
{
  [UIView animateWithDuration:0.3f animations:^{
    self.navigationController.view.transform = CGAffineTransformIdentity;
  }];
  
  [self reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
{
  if ([@"STBAddTruckSegueIdentifier" isEqualToString:segue.identifier] ||
      [@"STBStartJourneySegueIdentifier" isEqualToString:segue.identifier]) {
    [UIView animateWithDuration:0.3f animations:^{
      self.navigationController.view.transform = CGAffineTransformMakeScale(0.9f, 0.9f);
    }];
  }
  
  if ([@"STBShowTruckSegueIdentifier" isEqualToString:segue.identifier]) {
    
    STBTruckViewController *truckVC = segue.destinationViewController;
    
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    truckVC.truck = [self.currentDataSource objectAtIndex:selectedIndexPath];
    
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
  }
  
  if ([@"STBShowJourneySegueIdentifier" isEqualToString:segue.identifier]) {
    STBJourneyViewController *journeyVC = segue.destinationViewController;
    
    NSIndexPath *selectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    journeyVC.journey = [self.currentDataSource objectAtIndex:selectedIndexPath];
    
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
  return self.currentDataSource.numberOfSections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
  return [self.currentDataSource numberOfItemsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
  return [self.currentDataSource tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
  [self performSegueWithIdentifier:self.currentDataSource.segueIdentifier sender:self];
}

@end
