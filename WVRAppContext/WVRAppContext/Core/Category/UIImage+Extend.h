//
//  UIImage+Extend.h
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extend)

- (UIImage *)clips:(float)cornerRadius;

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor *)color frame:(CGRect)frame;

+ (UIImage *)roundImageWithColor:(UIColor *)color frame:(CGRect)frame cornerRadius:(float)corner;

- (UIImage *)roundImageWithFrame:(CGRect)frame cornerRadius:(float)corner;

+ (UIImage *)imageCompressWithSimple:(UIImage *)image scaledToSize:(CGSize)size;
+ (UIImage *)imageCompressWithSimple:(UIImage *)image scale:(float)scale;

/// 按照空间尺寸缩放图片
- (UIImage *)compresstoSize:(CGSize)size;

@end
