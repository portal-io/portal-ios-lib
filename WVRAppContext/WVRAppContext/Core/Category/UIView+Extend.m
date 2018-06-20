//
//  UIView+Extend.m
//  VRManager
//
//  Created by apple on 16/6/13.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "UIView+Extend.h"
#import "WVRProgressHUD.h"
#import <Toast/UIView+Toast.h>

@implementation UIView (Extend)

- (CGFloat)x         {   return CGRectGetMinX(self.frame);   }
- (CGFloat)y         {   return CGRectGetMinY(self.frame);   }
- (CGFloat)width     {   return CGRectGetWidth(self.frame);  }
- (CGFloat)height    {   return CGRectGetHeight(self.frame); }
- (CGPoint)origin    {   return self.frame.origin;           }
- (CGSize)size       {   return self.frame.size;             }
- (CGFloat)left      {   return CGRectGetMinX(self.frame);   }
- (CGFloat)right     {   return CGRectGetMaxX(self.frame);   }
- (CGFloat)top       {   return CGRectGetMinY(self.frame);   }
- (CGFloat)bottom    {   return CGRectGetMaxY(self.frame);   }
- (CGFloat)bottomX   { return self.frame.origin.x+self.frame.size.width; }
- (CGFloat)bottomY   { return self.frame.origin.y + self.frame.size.height; }
- (CGFloat)centerX   {   return self.center.x;               }
- (CGFloat)centerY   {   return self.center.y;               }
- (CGPoint)boundsCenter  {   return CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));   };

- (void)setX:(CGFloat)x {
    
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(CGFloat)y {
    
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(CGFloat)width {
    
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (void)setHeight:(CGFloat)height {
    
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)setOrigin:(CGPoint)origin {
    
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)setLeft:(CGFloat)left {
    
    CGRect frame = self.frame;
    frame.origin.x = left;
    frame.size.width = MAX(self.right-left, 0);
    self.frame = frame;
}

- (void)setRight:(CGFloat)right {
    
    CGRect frame = self.frame;
    frame.size.width = MAX(right-self.left, 0);
    self.frame = frame;
}

- (void)setTop:(CGFloat)top {
    
    CGRect frame = self.frame;
    frame.origin.y = top;
    frame.size.height = MAX(self.bottom-top, 0);
    self.frame = frame;
}

- (void)setBottom:(CGFloat)bottom {
    
    CGRect frame = self.frame;
    frame.size.height = MAX(bottom-self.top, 0);
    self.frame = frame;
}

- (void)setBottomX:(CGFloat)_bottomX {
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(_bottomX - frame.size.width, frame.origin.y, frame.size.width, frame.size.height);
}

- (void)setBottomY:(CGFloat)_bottomY {
    
    CGRect frame = self.frame;
    self.frame = CGRectMake(frame.origin.x, _bottomY - frame.size.height, frame.size.width, frame.size.height);
}

- (void)setCenterX:(CGFloat)centerX {
    
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (void)setCenterY:(CGFloat)centerY {
    
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

#pragma mark - HUD 

// 在当前页面显示HUD
- (void)showProgress {
    
    [WVRProgressHUD showHUDAddedTo:self animated:YES];
}

// 隐藏HUD
- (void)hideProgress {
    
    [WVRProgressHUD hideHUDForView:self animated:NO];
}


#pragma mark - 获取view所在控制器

/**
 获取当前view所在的控制器

 @return 如果不在控制器里，则返回nil
 */
- (UIViewController *)wvr_viewController {
    
    for (UIView *view = self; view; view = view.superview) {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
