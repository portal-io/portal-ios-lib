//
//  WVRProgressHUD.m
//  VRManager
//
//  Created by Snailvr on 16/7/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRProgressHUD.h"
#import "WVRAppFrameDefine.h"

@interface WVRProgressHUD()

@end


@implementation WVRProgressHUD


#pragma mark - internal function

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated {
    
    WVRProgressHUD *hud = [[self class] HUDForView:view];
    if (hud) {
        
        [hud startAnimating];
        return hud;
    }
    
    WVRProgressHUD *activity = [[WVRProgressHUD alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    if (view.backgroundColor == [UIColor blackColor] || view.tag == 3001) {
        
        activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    }
    
    // 保持hud在屏幕的正中央
    float height = view.frame.size.height;
    float centerY;
    if (height >= (SCREEN_HEIGHT - kNavBarHeight)) {
        centerY = view.frame.size.height/2.0 - (SCREEN_HEIGHT - view.frame.size.height)/2.0;
    } else {
        centerY = view.frame.size.height/2.0;
    }
    activity.center = CGPointMake(view.frame.size.width/2.0, centerY);
    activity.hidesWhenStopped = YES;
    [activity startAnimating];
    
    [view addSubview:activity];
    
//    view.userInteractionEnabled = NO;
    
    return activity;
}

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated {
    
    WVRProgressHUD *hud = [[self class] HUDForView:view];
//    view.userInteractionEnabled = YES;
    if (hud.superview) {
        [hud removeFromSuperview];
        
        return YES;
    }
    return NO;
}

+ (instancetype)showHUDAddedToWindowWithAnimated:(BOOL)animated {
    
    return [[self class] showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:animated];
}

+ (WVRProgressHUD *)HUDForView:(UIView *)view {
    
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isMemberOfClass:self]) {
            return (WVRProgressHUD *)subview;
        }
    }
    return nil;
}



@end
