//
//  WVRProgressHUD.h
//  VRManager
//
//  Created by Snailvr on 16/7/1.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WVRProgressHUD : UIActivityIndicatorView

@property (nonatomic, assign) BOOL showDimBackground;

+ (instancetype)showHUDAddedTo:(UIView *)view animated:(BOOL)animated;
+ (instancetype)showHUDAddedToWindowWithAnimated:(BOOL)animated;

+ (BOOL)hideHUDForView:(UIView *)view animated:(BOOL)animated;

+ (WVRProgressHUD *)HUDForView:(UIView *)view;

@end
