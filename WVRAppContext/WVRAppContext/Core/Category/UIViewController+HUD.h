//
//  UIViewController+HUD.h
//  VRManager
//
//  Created by Snailvr on 16/7/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

/// 显示等待蒙层
- (void)showProgress;
/// 隐藏等待蒙层
- (void)hideProgress;


- (void)showMessage:(NSString *)message toView:(UIView *)view;
- (void)showMessageToWindow:(NSString *)message;
/// 显示文字提示 2秒后消失
- (void)showMessage:(NSString *)message;


//- (void)hideHUDForView:(UIView *)view;
//- (void)hideHUDForWindow;
//- (void)hideHUD;

@end



@interface UIViewController (Extend)

/**
 判断当前 UIViewController 是否正在显示

 @return 是否在显示
 */
- (BOOL)isCurrentViewControllerVisible;

/**
 获取当前最顶层的控制器
 
 @return viewController
 */
+ (UIViewController *)getCurrentVC;


/**
 获取当前最顶层的控制器的主控制器

 @return tabController/navController/viewController
 */
+ (UIViewController *)getCurrentVC_RootVC;

/// 当前window、tab、vc之上是否没有分享、付费的弹框
- (BOOL)isClearInWindow;

@end
