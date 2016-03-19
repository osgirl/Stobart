//
//  STBCoreDataCoordinator.h
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import Foundation;
@import CoreData;

@class Journey;

@interface STBCoreDataCoordinator : NSObject

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContextWithError:(NSError **)error;

@property (nonatomic, strong) Journey *currentJourney;

@end
