//
//  MSCTimeSpanPicker.h
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner (@scheinem) on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "MSCTimeSpanPickerDelegate.h"

@interface MSCTimeSpanPicker : UIView <UIPickerViewDelegate>

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
 * Returns a MSCTimeSpanPicker instance in standalone mode, which means the time span picker
 * with a UIToolbar (including the options 'Hide' and 'Save') above.
 *
 * Technically just calls [self initInStandaloneMode:YES]
 */
- (instancetype)init;

/**
 * Returns a MSCTimeSpanPicker instance without toolbar, only the pure time span picker.
 * Can be used for UITableView inline presentation like in iOS 7's Calendar.app
 */
- (instancetype)initInStandaloneMode:(BOOL)standaloneMode;

@end
