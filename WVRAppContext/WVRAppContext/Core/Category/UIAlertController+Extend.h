//
//  UIAlertController+Extend.h
//  VRManager
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (Extend)

/// 纯消息 无反馈
+ (UIAlertController *)alertMessage:(NSString *)message viewController:(UIViewController *)vc;

/// 没有取消按钮
+ (UIAlertController *)alertMesasge:(NSString *)message confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandle viewController:(UIViewController *)vc;

/// 没有取消按钮(自定义title)
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandler viewController:(UIViewController *)vc;

+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandler viewController:(UIViewController *)vc sureTitle:(NSString*)sureTitle;

/// 有取消按钮
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmHandler cancleHandler:(void(^)(UIAlertAction *action))cancleHandler viewController:(UIViewController *)vc;


+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmHandler confirmTitle:(NSString*)confirmTitle cancleHandler:(void(^)(UIAlertAction *action))cancleHandler cancleTitle:(NSString*)cancleTitle viewController:(UIViewController *)vc;

- (BOOL)shouldAutorotate;

@end
