//
//  NSDate+MSCTimeSpanPickerDate.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "NSDate+MSCTimeSpanPickerDate.h"

@implementation NSDate (MSCTimeSpanPickerDate)

- (NSDateComponents *)gregorianDateComponents {
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *components = [calendar components:(NSSecondCalendarUnit |
                                                         NSMinuteCalendarUnit |
                                                         NSHourCalendarUnit |
                                                         NSDayCalendarUnit |
                                                         NSWeekdayCalendarUnit |
                                                         NSWeekOfYearCalendarUnit |
                                                         NSMonthCalendarUnit |
                                                         NSQuarterCalendarUnit |
                                                         NSYearCalendarUnit) fromDate:self];
	return components;
}

@end
