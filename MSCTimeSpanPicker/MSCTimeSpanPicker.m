//
//  MSCTimeSpanPicker.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "MSCTimeSpanPicker.h"
#import "MSCTimeSpanPickerView.h"
#import "NSDate+MSCTimeSpanPickerDate.h"
#import "NSDateComponents+MSCTimeSpanPickerDateComponents.h"

@interface MSCTimeSpanPicker ()

@property (nonatomic, strong) MSCTimeSpanPickerView *timeSpanPickerView;

@end

@implementation MSCTimeSpanPicker

- (instancetype)init {
    self = [self initInStandaloneMode:YES];
    if (self) {
    }
    return self;
}

- (instancetype)initInStandaloneMode:(BOOL)standaloneMode {
    self = [super init];
    if (self) {
        _timeSpanPickerView = [[MSCTimeSpanPickerView alloc] init];
        _timeSpanPickerView.delegate = self;
        [self addSubview:_timeSpanPickerView];
        
        if (standaloneMode) {
            UIToolbar *timeSpanPickerToolbar = [[UIToolbar alloc] init];
            timeSpanPickerToolbar.frame = CGRectMake(0.f, 0.f, _timeSpanPickerView.frame.size.width, 40.f);
            UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:MSCTimeSpanPickerLocalizedString(@"Cancel") style:UIBarButtonItemStyleBordered target:self action:@selector(changeTimeSpanPickerCancelled:)];
            UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:MSCTimeSpanPickerLocalizedString(@"Save") style:UIBarButtonItemStyleBordered target:self action:@selector(changeTimeSpanPickerSaved:)];
            timeSpanPickerToolbar.items = @[cancelButton, flexibleSpace, saveButton];
            
            CGRect ownFrame = self.frame;
            ownFrame.size = _timeSpanPickerView.frame.size;
            ownFrame.size.height += timeSpanPickerToolbar.frame.size.height;
            self.frame = ownFrame;
            
            CGRect timeSpanPickerViewFrame = _timeSpanPickerView.frame;
            timeSpanPickerViewFrame.origin.y = timeSpanPickerToolbar.frame.size.height;
            _timeSpanPickerView.frame = timeSpanPickerViewFrame;
            
            [self addSubview:timeSpanPickerToolbar];
        }
        else {
            self.frame = _timeSpanPickerView.frame;
        }
        
        _defaultTimeSpan = 30;
        _animateDefaultTimeSpanSetting = YES;
        
        self.from = [NSDate date];
        self.to = _from;
    }
    return self;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - MSCTimeSpanPicker
////////////////////////////////////////////////////////////////////////

- (void)setFrom:(NSDate *)from {
    _from = from;
    [self.timeSpanPickerView selectRow:[self.from gregorianDateComponents].hour inComponent:0 animated:NO];
    [self.timeSpanPickerView selectRow:[self.from gregorianDateComponents].minute inComponent:1 animated:NO];
}

- (void)setTo:(NSDate *)to {
    _to = to;
    [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].hour inComponent:3 animated:NO];
    [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].minute inComponent:4 animated:NO];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDelegate
////////////////////////////////////////////////////////////////////////

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%02i", row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if (component == 2) {
        return 55.f;
    }
    return 42.f;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    NSDateComponents *components = nil;
    BOOL propertyChanged = NO;
    
    switch (component) {
        case 0: {
            components = [self.from gregorianDateComponents];
            [components setHour:row];
            self.from = [components gregorianDate];
            
            [self refreshToDateDependingOnFromDate];
            
            propertyChanged = YES;
            
            break;
        }
        case 1: {
            components = [self.from gregorianDateComponents];
            [components setMinute:row];
            self.from = [components gregorianDate];
            
            [self refreshToDateDependingOnFromDate];
            
            propertyChanged = YES;
            
            break;
        }
        case 3: {
            components = [self.to gregorianDateComponents];
            [components setHour:row];
            
            if ([[components gregorianDate] timeIntervalSinceDate:self.from] < 0.f) {
                [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].hour inComponent:3 animated:YES];
            }
            else if ([self.to timeIntervalSinceDate:[components gregorianDate]] != 0.f) {
                self.to = [components gregorianDate];
                propertyChanged = YES;
            }
            break;
        }
        case 4: {
            components = [self.to gregorianDateComponents];
            [components setMinute:row];
            if ([[components gregorianDate] timeIntervalSinceDate:self.from] < 0.f) {
                [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].minute inComponent:4 animated:YES];
            }
            else if ([self.to timeIntervalSinceDate:[components gregorianDate]] != 0.f) {
                self.to = [components gregorianDate];
                propertyChanged = YES;
            }
            break;
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
    // set toDate to fromDate + defaultTimeSpan
    _to = [self.from dateByAddingTimeInterval:self.defaultTimeSpan * 60];
    [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].hour inComponent:3 animated:self.animateDefaultTimeSpanSetting];
    [self.timeSpanPickerView selectRow:[self.to gregorianDateComponents].minute inComponent:4 animated:self.animateDefaultTimeSpanSetting];
}

- (void)changeTimeSpanPickerCancelled:(id)sender {
    if ([self.delegate respondsToSelector:@selector(timeSpanPickerCancelled:)]) {
        [self.delegate timeSpanPickerCancelled:self];
    }
    [self dismiss];
}

- (void)changeTimeSpanPickerSaved:(id)sender {
    if ([self.delegate conformsToProtocol:@protocol(MSCTimeSpanPickerDelegate)]) {
        [self.delegate timeSpanPickerSaved:self];
    }
    [self dismiss];
}

- (void)dismiss {
    [self removeFromSuperview];
}

@end
