//
//  STBNavigationController.m
//  Stobart
//
//  Created by Matthew Hallatt on 27/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "STBNavigationController.h"

// Categories
#import "UIColor+STBColors.h"
#import "UIFont+STBFonts.h"

@implementation STBNavigationController

- (void)awakeFromNib;
{
  [super awakeFromNib];
  
  NSDictionary *titleTextAttributes = @{
                                        NSForegroundColorAttributeName : [UIColor stb_greenColor],
                                        NSFontAttributeName : [UIFont stb_boldFontWithSize:16.f],
                                        };
  
  [[UINavigationBar appearance] setTitleTextAttributes:titleTextAttributes];
  [[UINavigationBar appearance] setTintColor:[UIColor stb_greenColor]];
}

@end
