//
//  Journey.h
//  Stobart
//
//  Created by Matthew Hallatt on 04/10/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Truck;

@interface Journey : NSManagedObject

@property (nonatomic, retain) NSDate * endDate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startDate;
@property (nonatomic, retain) NSSet *trucks;
@end

@interface Journey (CoreDataGeneratedAccessors)

- (void)addTrucksObject:(Truck *)value;
- (void)removeTrucksObject:(Truck *)value;
- (void)addTrucks:(NSSet *)values;
- (void)removeTrucks:(NSSet *)values;

@end
