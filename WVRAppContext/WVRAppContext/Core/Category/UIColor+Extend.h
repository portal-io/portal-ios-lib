//
//  UIColor+Extend.h
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extend)

// 16进制颜色
+ (UIColor *)colorWithHex:(NSUInteger)hexColor;

+ (UIColor *)colorWithHex:(NSUInteger)hexColor alpha:(CGFloat)alpha;

/// 获取UIImage对象的主色调
+ (UIColor *)mostColorInImage:(UIImage*)image;

/// 获取UIImage 上半部分的主色调
+ (UIColor *)mostColorInImageTop:(UIImage *)image;

@end
