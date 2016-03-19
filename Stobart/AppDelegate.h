//
//  AppDelegate.h
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import UIKit;

@class STBCoreDataCoordinator;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) STBCoreDataCoordinator *coreDataCoordinator;

@end

