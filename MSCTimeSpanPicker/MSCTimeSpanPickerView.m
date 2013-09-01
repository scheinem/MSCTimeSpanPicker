//
//  MSCTimeSpanPickerView.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "MSCTimeSpanPickerView.h"
#import "UIImage+MSCTimeSpanPickerImage.h"

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
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.f) {
        UIImage *backgroundImage = [UIImage imageNamed:@"PickerViewBackground.png" fromBundle:MSCTimeSpanPickerResourcesBundle];
        [(UIView *)[self.subviews objectAtIndex:0] setBackgroundColor:[UIColor colorWithPatternImage:backgroundImage]];
    }
    
    if (!self.removedThirdWheel) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.f) {
            [self addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"PickerViewBackground.png" fromBundle:MSCTimeSpanPickerResourcesBundle]]];
            NSInteger indexOfComponentToRemove = 2;
            NSInteger currentPickerComponent = -1;
            for (UIView *view in self.subviews) {
                if ([view class] == NSClassFromString(@"_UIPickerWheelView")) {
                    currentPickerComponent++;
                }
                if (currentPickerComponent == indexOfComponentToRemove &&
                    view.autoresizingMask != UIViewAutoresizingFlexibleTopMargin) {
                    [view removeFromSuperview];
                }
            }
        }
        else {
            for (UIView *view in self.subviews) {
                if (view.frame.size.height == self.frame.size.height) {
                    [(UIView *)[view.subviews objectAtIndex:2] removeFromSuperview];
                }
            }
        }
        self.removedThirdWheel = YES;
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
