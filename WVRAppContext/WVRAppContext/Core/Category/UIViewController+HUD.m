//
//  UIViewController+HUD.m
//  VRManager
//
//  Created by Snailvr on 16/7/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIViewController+HUD.h"
#import "WVRProgressHUD.h"
#import <objc/runtime.h>
#import "WVRAppDefine.h"
#import <Toast/UIView+Toast.h>

static const void *toastKey = &toastKey;

@interface UIViewController ()

@property (nonatomic) UITapGestureRecognizer* mTap;

@end


@implementation UIViewController (HUD)

- (UITapGestureRecognizer *)mTap {
    
    return objc_getAssociatedObject(self, toastKey);
}

- (void)setMTap:(UITapGestureRecognizer *)mTap {
    
    objc_setAssociatedObject(self, toastKey, mTap, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

// 在当前页面显示HUD
- (void)showProgress {
    
    [WVRProgressHUD showHUDAddedTo:self.view animated:YES];
}

// 隐藏HUD
- (void)hideProgress {
    
    [WVRProgressHUD hideHUDForView:self.view animated:NO];
}

- (void)hideToastFromWindow {
    
    [self hideProgress];
    
    UIView *window = [[UIApplication sharedApplication].windows firstObject];
    UIView *view = [window viewWithTag:tag_TOAST_IN_WINDOWS];
    
    [view removeFromSuperview];
}

#pragma mark 显示一些信息

- (void)showMessage:(NSString *)message toView:(UIView *)view {
    
    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
    
    [view makeToast:message];
}

- (void)showMessageToWindow:(NSString *)message {
    
    [self showMessage:message toView:nil];
}

- (void)showMessage:(NSString *)message {
    
    [self showMessage:message toView:self.view];
}

// 隐藏HUD
//- (void)hideHUDForView:(UIView *)view {
//    
//    if (view == nil) view = [[UIApplication sharedApplication].windows firstObject];
//    [MBProgressHUD hideHUDForView:view animated:YES];
//}
//
//- (void)hideHUDForWindow {
//    
//    [self hideHUDForView:nil];
//}
//
//- (void)hideHUD {
//    
//    [self hideHUDForView:self.view];
//}


@end


@implementation UIViewController (Extend)

// 判断当前 UIViewController 是否正在显示
- (BOOL)isCurrentViewControllerVisible {
    
    return (self.isViewLoaded && self.view.window);
}

// 获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC {
    
    UIViewController *rootViewController = [[[UIApplication sharedApplication] windows] firstObject].rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

// 获取当前最顶层的控制器
+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    
    UIViewController *currentVC;
    
    while ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}

// 获取当前最顶层的控制器的主控制器
+ (UIViewController *)getCurrentVC_RootVC {
    
    UIViewController *curVC = [self getCurrentVC];
    
    if (curVC.tabBarController) {
        
        return curVC.tabBarController;
    } else if (curVC.navigationController) {
        
        return curVC.navigationController;
    }
    
    return curVC;
}

/// 当前window、tab、vc之上是否没有分享、付费的弹框
- (BOOL)isClearInWindow {
    
    Class shareCls = NSClassFromString(@"WVRUMShareView");
    Class sheetCls = NSClassFromString(@"WVROrderActionSheet");
    
    // KeyWindow
    UIWindow *keywindow = [[[UIApplication sharedApplication] windows] firstObject];
    for (UIView *view in keywindow.subviews) {
        
        if ([view isKindOfClass:shareCls] || [view isKindOfClass:sheetCls]) {
            return NO;
        }
    }
    
    // Tab
    UIView *tab = keywindow.rootViewController.view;
    for (UIView *view in tab.subviews) {
        
        if ([view isKindOfClass:shareCls] || [view isKindOfClass:sheetCls]) {
            return NO;
        }
    }
    
    // self
    for (UIView *view in self.view.subviews) {
        
        if ([view isKindOfClass:shareCls] || [view isKindOfClass:sheetCls]) {
            return NO;
        }
    }
    
    return YES;
}

@end
