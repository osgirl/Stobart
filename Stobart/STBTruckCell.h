//
//  STBTruckCell.h
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import UIKit;

@class Truck;

@interface STBTruckCell : UITableViewCell

+ (NSString *)reuseIdentifier;

- (void)populateWithTruck:(Truck *)truck;

@end
