//
//  STBCoreDataCoordinator.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBCoreDataCoordinator.h"

@implementation STBCoreDataCoordinator

- (void)saveContextWithError:(NSError *__autoreleasing *)error;
{
  if (self.managedObjectContext.hasChanges) {
    [self.managedObjectContext save:error];
  }
}

- (NSManagedObjectContext *)managedObjectContext;
{
  if (_managedObjectContext) {
    return _managedObjectContext;
  }
  
  if (self.persistentStoreCoordinator) {
    _managedObjectContext = NSManagedObjectContext.new;
    _managedObjectContext.persistentStoreCoordinator = self.persistentStoreCoordinator;
  }
  
  return _managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel;
{
  if (_managedObjectModel) {
    return _managedObjectModel;
  }
  
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
  
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  
  return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;
{
  if (_persistentStoreCoordinator) {
    return _persistentStoreCoordinator;
  }
  
  NSURL *documentsDirectory = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                      inDomains:NSUserDomainMask] lastObject];
  
  NSURL *storeURL = [documentsDirectory URLByAppendingPathComponent:@"Stobart.sqlite"];
  
  NSError *createPersistentStoreError;
  
  NSPersistentStoreCoordinator *tempPersistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:self.managedObjectModel];
  
  if (![tempPersistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                    configuration:nil
                                                              URL:storeURL
                                                          options:nil
                                                            error:&createPersistentStoreError]) {
    NSLog(@"Error creating persistent store: %@", createPersistentStoreError.userInfo);
    return nil;
  }
  
  _persistentStoreCoordinator = tempPersistentStoreCoordinator;
  
  return _persistentStoreCoordinator;
}

@end
