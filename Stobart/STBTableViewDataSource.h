//
//  STBTableViewDataSource.h
//  Stobart
//
//  Created by Matthew Hallatt on 12/07/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import Foundation;
@import UIKit;

@protocol STBTableViewDataSource <NSObject>

- (NSString *)segueIdentifier;

- (id)objectAtIndex:(NSIndexPath *)indexPath;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfItemsInSection:(NSInteger)section;
- (UITableViewCell *)tableView:(UITableView *)tableview cellForRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)reloadData;

@end
