//
//  UIImage+MSCTimeSpanPickerImage.m
//  MSCTimeSpanPicker
//
//  Created by Manfred Scheiner on 24.07.13.
//  Copyright (c) 2013 Manfred Scheiner (@scheinem). All rights reserved.
//

#import "UIImage+MSCTimeSpanPickerImage.h"

@implementation UIImage (MSCTimeSpanPickerImage)

+ (UIImage *)imageNamed:(NSString *)name fromBundle:(NSBundle *)bundle {
    
    if (bundle == nil) {
        return nil;
    }
    
    NSString *filetype = [name pathExtension];
    if (filetype.length == 0) {
            filetype = @"png";
    }
    
    name = [name stringByDeletingPathExtension];
    
    if ((NSInteger)[UIScreen mainScreen].scale > 1) {
        if ([bundle pathForResource:[NSString stringWithFormat:@"%@@2x",name] ofType:filetype]) {
            name = [name stringByAppendingString:@"@2x"];
        }
    }
    
    NSString *imagePath = [bundle pathForResource:name ofType:filetype];
    if (imagePath) {
        return [UIImage imageWithContentsOfFile:imagePath];
    }
    return nil;
    
}

@end
