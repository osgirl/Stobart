//
//  STBActionButton.m
//  Stobart
//
//  Created by Matthew Hallatt on 04/07/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBActionButton.h"

// Categories
#import "UIColor+STBColors.h"
#import "UIFont+STBFonts.h"

@implementation STBActionButton

- (void)awakeFromNib;
{
  [super awakeFromNib];
  
  [self setup];
}

- (void)setup;
{
  self.titleLabel.font     = [UIFont stb_boldFontWithSize:18.f];
  self.backgroundColor     = [UIColor stb_greenColor];
  self.layer.cornerRadius  = 5.f;
  self.layer.shadowOffset  = CGSizeMake(0.f, 2.f);
  self.layer.shadowOpacity = .4f;
  self.layer.shadowRadius  = 3.f;
}

- (void)setHighlighted:(BOOL)highlighted;
{
  self.backgroundColor    = highlighted ? UIColor.stb_darkGreenColor : UIColor.stb_greenColor;
  self.layer.shadowOffset = CGSizeMake(0.f, highlighted ? 1.f : 2.f);
}

- (void)setSelected:(BOOL)selected;
{
  
}

@end
