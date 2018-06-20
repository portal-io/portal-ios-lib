//
//  UIAlertController+Extend.m
//  VRManager
//
//  Created by apple on 16/6/27.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIAlertController+Extend.h"

@implementation UIAlertController (Extend)

// 纯消息 无反馈
+ (UIAlertController *)alertMessage:(NSString *)message viewController:(UIViewController *)vc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:okAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

// 没有取消按钮
+ (UIAlertController *)alertMesasge:(NSString *)message confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandle viewController:(UIViewController *)vc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"提示", nil) message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:confirmActionHandle];
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

// 没有取消按钮(自定义title)
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandler viewController:(UIViewController *)vc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:confirmActionHandler];
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

// 没有取消按钮(自定义title)
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmActionHandler viewController:(UIViewController *)vc sureTitle:(NSString *)sureTitle {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:confirmActionHandler];
    
    [alertController addAction:confirmAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

// 有取消按钮
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmHandler cancleHandler:(void(^)(UIAlertAction *action))cancleHandler viewController:(UIViewController *)vc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"确定", nil) style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"取消", nil) style:UIAlertActionStyleCancel handler:cancleHandler];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancleAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

// 有取消按钮
+ (UIAlertController *)alertTitle:(NSString *)title mesasge:(NSString *)message preferredStyle:(UIAlertControllerStyle)preferredStyle confirmHandler:(void(^)(UIAlertAction *action))confirmHandler confirmTitle:(NSString *)confirmTitle cancleHandler:(void(^)(UIAlertAction *action))cancleHandler cancleTitle:(NSString *)cancleTitle viewController:(UIViewController *)vc {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:preferredStyle];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:confirmHandler];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:cancleTitle style:UIAlertActionStyleCancel handler:cancleHandler];
    
    [alertController addAction:confirmAction];
    [alertController addAction:cancleAction];
    
    [vc presentViewController:alertController animated:YES completion:nil];
    
    return alertController;
}

- (BOOL)shouldAutorotate {
    
    return NO;
}

@end
