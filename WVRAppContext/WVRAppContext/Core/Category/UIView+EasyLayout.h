//
//  UIView+EasyLayout.h
//  YHB_Prj
//
//  Created by Chris Yang on 16/3/8.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CY_SCREEN_WIDTH             [UIScreen mainScreen].bounds.size.width
#define CY_SCREEN_HEIGHT            [UIScreen mainScreen].bounds.size.height

#define CY_STATUS_BAR_HEIGHT            20
#define CY_NAV_BAR_HEIGHT               44
#define CY_TAB_BAR_HEIGHT               49

@interface UIView(EasyLayout)

#pragma mark - Get X
- (CGFloat)getXForSubviewToLeftWithSpace:(CGFloat)space;
- (CGFloat)getXForSubviewToRightWithSpace:(CGFloat)space viewWidth:(CGFloat)viewWidth;
- (CGFloat)getXForSubviewInCentenWithOffset:(CGFloat)offset viewWidth:(CGFloat)viewWidth;

- (CGFloat)getXForBrotherViewToLeftWithSpace:(CGFloat)space;
- (CGFloat)getXForBrotherViewToRightWithSpace:(CGFloat)space viewWidth:(CGFloat)viewWidth;
- (CGFloat)getXForBrotherViewInCentenWithOffset:(CGFloat)offset viewWidth:(CGFloat)viewWidth;

#pragma mark - Get Y
- (CGFloat)getYForSubviewToTopWithSpace:(CGFloat)space;
- (CGFloat)getYForSubviewToBottomWithSpace:(CGFloat)space viewHeight:(CGFloat)viewHeight;
- (CGFloat)getYForSubviewInCentenWithOffset:(CGFloat)offset viewHeight:(CGFloat)viewHeight;

- (CGFloat)getYForBrotherViewToTopWithSpace:(CGFloat)space;
- (CGFloat)getYForBrotherViewToBottomWithSpace:(CGFloat)space viewHeight:(CGFloat)viewHeight;
- (CGFloat)getYForBrotherViewInCentenWithOffset:(CGFloat)offset viewHeight:(CGFloat)viewHeight;

#pragma mark - Rect Base
- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                          toLeft:(CGFloat)toLeft
                           toTop:(CGFloat)toTop;

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                         toRight:(CGFloat)toRight
                           toTop:(CGFloat)toTop;

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                          toLeft:(CGFloat)toLeft
                        toBottom:(CGFloat)toBottom;

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                         toRight:(CGFloat)toRight
                        toBottom:(CGFloat)toBottom;

#pragma mark - Rect Center
- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height;

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                               xOffset:(CGFloat)xOffset
                               yOffser:(CGFloat)yOffset;

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                                toLeft:(CGFloat)toLeft;

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                               toRight:(CGFloat)toRight;

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                                 toTop:(CGFloat)toTop;

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                              toBottom:(CGFloat)toBottom;

#pragma mark - Rect Center View-base
- (CGRect)centerRectInSubviewWithView:(UIView *)childView;

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                               toLeft:(CGFloat)toLeft;

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                              toRight:(CGFloat)toRight;

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                                toTop:(CGFloat)toTop;

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                             toBottom:(CGFloat)toBottom;

@end

