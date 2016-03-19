//
//  STBTruckCell.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBTruckCell.h"

// Categories
#import "UIColor+STBColors.h"
#import "UIFont+STBFonts.h"

// Entities
#import "Truck.h"

static const struct STBTruckCellConstants {
  CGFloat fontSize;
} STBTruckCellConstants = {
  .fontSize = 18.f,
};

@interface STBTruckCell ()

@property (nonatomic, strong) Truck *truck;

@property (nonatomic, strong) UIPanGestureRecognizer *panRecogniser;

@property (nonatomic, strong) UIView *addView;
@property (nonatomic, strong) UIView *removeView;

@end

@implementation STBTruckCell

+ (NSString *)reuseIdentifier;
{
  return @"STBTruckCellReuseIdentifier";
}

- (void)awakeFromNib;
{
  [super awakeFromNib];
  
  self.textLabel.font = [UIFont stb_italicFontWithSize:STBTruckCellConstants.fontSize];
  self.textLabel.textColor = [UIColor stb_greenColor];
}

- (void)populateWithTruck:(Truck *)truck;
{
  if (!truck) {
    return;
  }
  
  self.truck = truck;
  
  self.textLabel.text = self.truck.name;
}

- (void)prepareForReuse;
{
  [super prepareForReuse];
  self.backgroundColor = UIColor.whiteColor;
}

@end
