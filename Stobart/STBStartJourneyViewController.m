//
//  STBStartJourneyViewController.m
//  Stobart
//
//  Created by Matthew Hallatt on 12/07/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBStartJourneyViewController.h"

// Application
#import "AppDelegate.h"

// Categories
#import "UIColor+STBColors.h"

// Core Data
#import "STBCoreDataCoordinator.h"

// Entities
#import "Journey.h"

@interface STBStartJourneyViewController () <UITextFieldDelegate>

@end

@implementation STBStartJourneyViewController

- (void)viewDidLoad;
{
  [super viewDidLoad];
  
  self.nameTextField.returnKeyType = UIReturnKeyDone;
  self.nameTextField.delegate = self;
  
  self.startJourneyButton.backgroundColor = [UIColor stb_greenColor];
}

- (IBAction)startJourney:(id)sender;
{
  [self.nameTextField resignFirstResponder];
  
  STBCoreDataCoordinator *coreDataCoordinator = [(AppDelegate *)[[UIApplication sharedApplication] delegate] coreDataCoordinator];
  
  Journey *newJourney = [NSEntityDescription insertNewObjectForEntityForName:@"Journey"
                                                      inManagedObjectContext:coreDataCoordinator.managedObjectContext];
  
  newJourney.name      = self.nameTextField.text;
  newJourney.startDate = NSDate.new;
  
  NSError *saveError;
  [coreDataCoordinator saveContextWithError:&saveError];
  
  if (saveError) {
    NSLog(@"Error creating journey with name '%@': %@", newJourney.name, saveError.userInfo);
  }
  
  coreDataCoordinator.currentJourney = newJourney;
  
  [self performSegueWithIdentifier:@"UnwindToHomeSegueIdentifier" sender:self];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
  [self.nameTextField resignFirstResponder];
  
  return YES;
}

@end
