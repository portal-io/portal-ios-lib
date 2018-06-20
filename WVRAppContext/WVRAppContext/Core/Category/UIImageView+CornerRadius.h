//
//  UIImageView+CornerRadius.h
//  VRManager
//
//  Created by Snailvr on 16/6/22.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 暂时没有引用，可以放到Widget或者UIFrame模块中

#import <UIKit/UIKit.h>

@interface UIImageView (CornerRadius)

- (instancetype)initWithCornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (void)wvr_cornerRadiusAdvance:(CGFloat)cornerRadius rectCornerType:(UIRectCorner)rectCornerType;

- (instancetype)initWithRoundingRectImageView;

- (void)wvr_cornerRadiusRoundingRect;

- (void)wvr_attachBorderWidth:(CGFloat)width color:(UIColor *)color;

@end
