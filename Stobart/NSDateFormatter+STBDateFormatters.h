//
//  NSDateFormatter+STBDateFormatters.h
//  Stobart
//
//  Created by Matthew Hallatt on 28/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

@import Foundation;

@interface NSDateFormatter (STBDateFormatters)

+ (NSString *)stb_lastSpottedStringFromDate:(NSDate *)date;

@end
