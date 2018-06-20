//
//  UIView+Extend.h
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat x, y, width, height;
@property (nonatomic, assign) CGFloat left, right, top, bottom;
@property (assign, nonatomic) CGFloat bottomX;
@property (assign, nonatomic) CGFloat bottomY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, readonly) CGPoint boundsCenter;


/// 显示等待蒙层
- (void)showProgress;
/// 隐藏等待蒙层
- (void)hideProgress;

#pragma mark - 获取view所在控制器

/**
 获取当前view所在的控制器
 
 @return 如果不在控制器里，则返回nil
 */
@property (nonatomic, readonly) UIViewController *wvr_viewController;

@end
