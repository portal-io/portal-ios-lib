//
//  UIView+EasyLayout.m
//  YHB_Prj
//
//  Created by Chris Yang on 16/3/8.
//  Copyright © 2016年 striveliu. All rights reserved.
//

#import "UIView+EasyLayout.h"

@implementation UIView(EasyLayout)

#pragma mark - Get X
- (CGFloat)getXForSubviewToLeftWithSpace:(CGFloat)space
{
    return self.bounds.origin.x + space;
}

- (CGFloat)getXForSubviewToRightWithSpace:(CGFloat)space viewWidth:(CGFloat)viewWidth
{
    return self.bounds.origin.x + self.bounds.size.width - space - viewWidth;
}

- (CGFloat)getXForSubviewInCentenWithOffset:(CGFloat)offset viewWidth:(CGFloat)viewWidth
{
    return self.bounds.origin.x + (self.bounds.size.width - viewWidth) / 2 + offset;
}

/* Brother view */
- (CGFloat)getXForBrotherViewToLeftWithSpace:(CGFloat)space;
{
    return self.frame.origin.x + self.frame.size.width + space;
}

- (CGFloat)getXForBrotherViewToRightWithSpace:(CGFloat)space viewWidth:(CGFloat)viewWidth
{
    return self.frame.origin.x - space - viewWidth;
}

- (CGFloat)getXForBrotherViewInCentenWithOffset:(CGFloat)offset viewWidth:(CGFloat)viewWidth
{
    return self.frame.origin.x + (self.frame.size.width - viewWidth) / 2 + offset;
}

#pragma mark - Get Y
- (CGFloat)getYForSubviewToTopWithSpace:(CGFloat)space
{
    return self.bounds.origin.y + space;
}

- (CGFloat)getYForSubviewToBottomWithSpace:(CGFloat)space viewHeight:(CGFloat)viewHeight
{
    return self.bounds.origin.y + self.bounds.size.height - space - viewHeight;
}

- (CGFloat)getYForSubviewInCentenWithOffset:(CGFloat)offset viewHeight:(CGFloat)viewHeight
{
    return self.bounds.origin.y + (self.bounds.size.height - viewHeight) / 2 + offset;
}

/* Brother view */
- (CGFloat)getYForBrotherViewToTopWithSpace:(CGFloat)space
{
    return self.frame.origin.y +self.frame.size.height + space;
}

- (CGFloat)getYForBrotherViewToBottomWithSpace:(CGFloat)space viewHeight:(CGFloat)viewHeight
{
    return self.frame.origin.y - space - viewHeight;
}

- (CGFloat)getYForBrotherViewInCentenWithOffset:(CGFloat)offset viewHeight:(CGFloat)viewHeight
{
    return self.frame.origin.y + (self.frame.size.height - viewHeight) / 2 + offset;
}

#pragma mark - Rect Single
- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                          toLeft:(CGFloat)toLeft
                           toTop:(CGFloat)toTop;
{
    return CGRectMake([self getXForSubviewToLeftWithSpace:toLeft],
                      [self getYForSubviewToTopWithSpace:toTop],
                      width,
                      height);
}

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                         toRight:(CGFloat)toRight
                           toTop:(CGFloat)toTop
{
    return CGRectMake([self getXForSubviewToRightWithSpace:toRight viewWidth:width],
                      [self getYForSubviewToTopWithSpace:toTop],
                      width,
                      height);
}

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                          toLeft:(CGFloat)toLeft
                        toBottom:(CGFloat)toBottom
{
    return CGRectMake([self getXForSubviewToLeftWithSpace:toLeft],
                      [self getYForSubviewToBottomWithSpace:toBottom viewHeight:height],
                      width,
                      height);
}

- (CGRect)rectInSubviewWithWidth:(CGFloat)width
                          height:(CGFloat)height
                         toRight:(CGFloat)toRight
                        toBottom:(CGFloat)toBottom
{
    return CGRectMake([self getXForSubviewToRightWithSpace:toRight viewWidth:width],
                      [self getYForSubviewToBottomWithSpace:toBottom viewHeight:height],
                      width,
                      height);
}

#pragma mark - Rect Center
- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
{
    return [self centerRectInSubviewWithWidth:width height:height xOffset:0 yOffser:0];
}

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                               xOffset:(CGFloat)xOffset
                               yOffser:(CGFloat)yOffset
{
    return CGRectMake([self getXForSubviewInCentenWithOffset:xOffset viewWidth:width],
                      [self getYForSubviewInCentenWithOffset:yOffset viewHeight:height],
                      width,
                      height);
}

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                                toLeft:(CGFloat)toLeft
{
    return CGRectMake([self getXForSubviewToLeftWithSpace:toLeft],
                      [self getYForSubviewInCentenWithOffset:0 viewHeight:height],
                      width,
                      height);
}

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                               toRight:(CGFloat)toRight
{
    return CGRectMake([self getXForSubviewToRightWithSpace:toRight viewWidth:width],
                      [self getYForSubviewInCentenWithOffset:0 viewHeight:height],
                      width,
                      height);
}

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                                 toTop:(CGFloat)toTop
{
    return CGRectMake([self getXForSubviewInCentenWithOffset:0 viewWidth:width],
                      [self getYForSubviewToTopWithSpace:toTop],
                      width,
                      height);
}

- (CGRect)centerRectInSubviewWithWidth:(CGFloat)width
                                height:(CGFloat)height
                              toBottom:(CGFloat)toBottom
{
    return CGRectMake([self getXForSubviewInCentenWithOffset:0 viewWidth:width],
                      [self getYForSubviewToBottomWithSpace:toBottom viewHeight:height],
                      width,
                      height);
}

#pragma mark -
- (CGRect)centerRectInSubviewWithView:(UIView *)childView
{
    return [self centerRectInSubviewWithWidth:childView.bounds.size.width
                                       height:childView.bounds.size.height];
}

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                               toLeft:(CGFloat)toLeft
{
    return [self centerRectInSubviewWithWidth:childView.bounds.size.width
                                       height:childView.bounds.size.height
                                       toLeft:toLeft];
}

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                              toRight:(CGFloat)toRight
{
    return [self centerRectInSubviewWithWidth:childView.bounds.size.width
                                       height:childView.bounds.size.height
                                      toRight:toRight];
}

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                                toTop:(CGFloat)toTop
{
    return [self centerRectInSubviewWithWidth:childView.bounds.size.width
                                       height:childView.bounds.size.height
                                        toTop:toTop];
}

- (CGRect)centerRectInSubviewWithView:(UIView *)childView
                             toBottom:(CGFloat)toBottom
{
    return [self centerRectInSubviewWithWidth:childView.bounds.size.width
                                       height:childView.bounds.size.height
                                     toBottom:toBottom];
}

@end
