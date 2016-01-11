//
//  MSCTimeSpanPickerView.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "MSCTimeSpanPickerView.h"

@interface MSCTimeSpanPickerView ()

@property (nonatomic, assign) BOOL removedThirdWheel;

@end

@implementation MSCTimeSpanPickerView

////////////////////////////////////////////////////////////////////////
#pragma mark - Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)init {
    self = [super init];
    if (self) {
        _removedThirdWheel = NO;
        
        self.dataSource = self;
        self.showsSelectionIndicator = YES;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    for (UIView *view in self.subviews) {
        if (view.frame.size.height == self.frame.size.height && view.subviews.count == 5) {
            [(UIView *)[view.subviews objectAtIndex:2] removeFromSuperview];
        }
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIPickerViewDataSource
////////////////////////////////////////////////////////////////////////

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0 || component == 3) {
        return 24;
    }
    else if (component == 1 || component == 4) {
        return 60;
    }
    return 1;
}

@end
