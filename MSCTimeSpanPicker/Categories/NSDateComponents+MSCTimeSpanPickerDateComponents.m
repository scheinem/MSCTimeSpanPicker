//
//  NSDateComponents+MSCTimeSpanPickerDateComponents.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "NSDateComponents+MSCTimeSpanPickerDateComponents.h"

@implementation NSDateComponents (MSCTimeSpanPickerDateComponents)

- (NSDate *)gregorianDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [calendar dateFromComponents:self];
}

@end
