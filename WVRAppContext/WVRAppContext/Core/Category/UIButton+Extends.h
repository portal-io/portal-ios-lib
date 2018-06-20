//
//  UIButton+Extends.h
//  VRManager
//
//  Created by Snailvr on 16/7/11.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(UIButtonExt)

- (void)centerImageAndTitle:(float)space;
- (void)centerImageAndTitle;
- (void)rightImageLeftTitle:(float)spacing;

/**
 为button设置一个纯色的image

 @param backgroundColor UIColor对象
 @param state 默认状态
 */
- (void)setBackgroundImageWithColor:(UIColor *)backgroundColor forState:(UIControlState)state;

@end
