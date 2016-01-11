//
//  MSCTimeSpanPicker.h
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

@import UIKit;

@class MSCTimeSpanPicker;

@protocol MSCTimeSpanPickerDelegate <NSObject>
@optional
- (void)timeSpanPicker:(MSCTimeSpanPicker *)timeSpanPicker selectedFrom:(NSDate *)from andTo:(NSDate *)to;

@end

@interface MSCTimeSpanPicker : UIView

@property (nonatomic, strong) NSDate *from;
@property (nonatomic, strong) NSDate *to;

@property (nonatomic, strong) id<MSCTimeSpanPickerDelegate> delegate;

/** 
 * The "to"-Date gets automatically set to "from"-Date + defaultTimeSpan (in minutes)
 * when the "from"-Date was changed using the picker.
 * 
 * For disabling this function set defaultTimeSpan to NSUIntegerMax.
 *
 * Default: 30
 */
@property (nonatomic, assign) NSUInteger defaultTimeSpan;

/**
 * Animates when "to"-Date gets automatically set because the "from"-Date was changed 
 * using the picker.
 *
 * Default: NO
 */
@property (nonatomic, assign) BOOL animateDefaultTimeSpanSetting;

/**
 * Returns a MSCTimeSpanPicker instance.
 */
- (instancetype)init;

@end
