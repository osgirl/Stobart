//
//  AppDelegate.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "AppDelegate.h"

// Model
#import "STBCoreDataCoordinator.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  
  return YES;
}

- (STBCoreDataCoordinator *)coreDataCoordinator;
{
  return _coreDataCoordinator ?: ({
    _coreDataCoordinator = STBCoreDataCoordinator.new;
  });
}

@end
