//
//  NSDateFormatter+STBDateFormatters.m
//  Stobart
//
//  Created by Matthew Hallatt on 28/06/2015.
//  Copyright (c) 2015 Matthew Hallatt. All rights reserved.
//

#import "NSDateFormatter+STBDateFormatters.h"

@implementation NSDateFormatter (STBDateFormatters)

+ (NSString *)stb_lastSpottedStringFromDate:(NSDate *)date;
{
  if (!date) {
    return @"Doesn't look like you've spotted this truck!";
  }
  
  NSDateFormatter *dateFormatter = NSDateFormatter.new;
  dateFormatter.dateFormat = @"dd MMMM YYYY";
  
  NSDateFormatter *timeFormatter = NSDateFormatter.new;
  timeFormatter.dateFormat = @"hh:mm";
  
  NSString *dateString = [dateFormatter stringFromDate:date];
  NSString *timeString = [timeFormatter stringFromDate:date];
  
  return [NSString stringWithFormat:@"Last spotted on %@ at %@", dateString, timeString];
}

@end
