//
//  MSCTimeSpanPicker.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "MSCTimeSpanPicker.h"
#import "MSCTimeSpanPickerView.h"

@interface MSCTimeSpanPicker () <UIPickerViewDelegate>

@property (nonatomic, strong) MSCTimeSpanPickerView *timeSpanPickerView;

@property (nonatomic, strong) NSDateComponents *fromDateComponents;
@property (nonatomic, strong) NSDateComponents *toDateComponents;

@end

@implementation MSCTimeSpanPicker

////////////////////////////////////////////////////////////////////////
#pragma mark - Life Cycle
////////////////////////////////////////////////////////////////////////

- (instancetype)init {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _timeSpanPickerView = [[MSCTimeSpanPickerView alloc] init];
        _timeSpanPickerView.delegate = self;
        [self addSubview:_timeSpanPickerView];
        
        _defaultTimeSpan = 30;
        _animateDefaultTimeSpanSetting = YES;
        
        self.from = [NSDate date];
        self.to = _from;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIView
////////////////////////////////////////////////////////////////////////

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.timeSpanPickerView.frame = self.bounds;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - MSCTimeSpanPicker
////////////////////////////////////////////////////////////////////////

- (void)setFrom:(NSDate *)from {
    _from = from;
    
    self.fromDateComponents = [self dateComponentsInCurrentCalendarForDate:from];
}

- (void)setFromDateComponents:(NSDateComponents *)fromDateComponents {
    [self setFromDateComponents:fromDateComponents animated:NO];
}

- (void)setTo:(NSDate *)to {
    _to = to;
    
    self.toDateComponents = [self dateComponentsInCurrentCalendarForDate:to];
}

- (void)setToDateComponents:(NSDateComponents *)toDateComponents {
    [self setToDateComponents:toDateComponents animated:NO];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDelegate
////////////////////////////////////////////////////////////////////////

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%02li", (long)row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 2) {
        return 55.f;
    }
    return 42.f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    BOOL propertyChanged = NO;
    
    switch (component) {
        case 0: {
            [self.fromDateComponents setHour:row];
            self.from = [self dateInCurrentCalendarForDateComponents:self.fromDateComponents];
            
            [self refreshToDateDependingOnFromDate];
            
            propertyChanged = YES;
            
            break;
        }
            
        case 1: {
            [self.fromDateComponents setMinute:row];
            self.from = [self dateInCurrentCalendarForDateComponents:self.fromDateComponents];
            
            [self refreshToDateDependingOnFromDate];
            
            propertyChanged = YES;
            
            break;
        }
            
        case 3: {
            if (row < self.fromDateComponents.hour ||
                (row == self.fromDateComponents.hour && self.toDateComponents.minute <= self.fromDateComponents.minute )) {
                [self.timeSpanPickerView selectRow:self.toDateComponents.hour inComponent:3 animated:YES];
                
            } else {
                [self.toDateComponents setHour:row];
                self.to = [self dateInCurrentCalendarForDateComponents:self.toDateComponents];
                
                propertyChanged = YES;
            }
            
            break;
        }
            
        case 4: {
            if (self.fromDateComponents.hour == self.toDateComponents.hour &&
                row <= self.fromDateComponents.minute) {
                [self.timeSpanPickerView selectRow:self.toDateComponents.minute inComponent:4 animated:YES];
                
            } else {
                [self.toDateComponents setMinute:row];
                self.to = [self dateInCurrentCalendarForDateComponents:self.toDateComponents];
                
                propertyChanged = YES;
            }
        }
            
        default: {
            break;
        }
    }
    
    if (propertyChanged && [self.delegate respondsToSelector:@selector(timeSpanPicker:selectedFrom:andTo:)]) {
        [self.delegate timeSpanPicker:self selectedFrom:self.from andTo:self.to];
    }
    
}

////////////////////////////////////////////////////////////////////////
#pragma mark - private
////////////////////////////////////////////////////////////////////////

- (void)refreshToDateDependingOnFromDate {
    _to = [self.from dateByAddingTimeInterval:self.defaultTimeSpan * 60];
    
    [self setToDateComponents:[self dateComponentsInCurrentCalendarForDate:_to]
                     animated:self.animateDefaultTimeSpanSetting];
}

- (NSDateComponents *)dateComponentsInCurrentCalendarForDate:(NSDate *)date {
    if (date == nil) {
        return nil;
    }
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    return [currentCalendar components:(NSCalendarUnitYear |
                                        NSCalendarUnitMonth |
                                        NSCalendarUnitDay |
                                        NSCalendarUnitHour |
                                        NSCalendarUnitMinute |
                                        NSCalendarUnitSecond |
                                        NSCalendarUnitNanosecond |
                                        NSCalendarUnitTimeZone) fromDate:date];
}

- (NSDate *)dateInCurrentCalendarForDateComponents:(NSDateComponents *)dateComponents {
    if (dateComponents == nil) {
        return nil;
    }
    
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    return [currentCalendar dateFromComponents:dateComponents];
}

- (void)setFromDateComponents:(NSDateComponents *)fromDateComponents animated:(BOOL)animated {
    _fromDateComponents = fromDateComponents;
    
    [self scrollToFromDateCompononents:_fromDateComponents animated:animated];
}

- (void)setToDateComponents:(NSDateComponents *)toDateComponents animated:(BOOL)animated {
    _toDateComponents = toDateComponents;
    
    [self scrollToToDateCompononents:toDateComponents animated:animated];
}

- (void)scrollToFromDateCompononents:(NSDateComponents *)fromDateComponents animated:(BOOL)animated {
    [self.timeSpanPickerView selectRow:fromDateComponents.hour inComponent:0 animated:animated];
    [self.timeSpanPickerView selectRow:fromDateComponents.minute inComponent:1 animated:animated];
}

- (void)scrollToToDateCompononents:(NSDateComponents *)toDateComponents animated:(BOOL)animated {
    [self.timeSpanPickerView selectRow:toDateComponents.hour inComponent:3 animated:animated];
    [self.timeSpanPickerView selectRow:toDateComponents.minute inComponent:4 animated:animated];
}

@end
