//
//  CAAnimation+Extension.h
//  WhaleyVR
//
//  Created by zhangliangliang on 9/27/16.
//  Copyright © 2016 Snailvr. All rights reserved.

// 暂时没有引用，可以放到Widget或者UIFrame模块中

#import <QuartzCore/QuartzCore.h>

@interface CAAnimation(MZExtension)

/// 渐变动画
+ (CAAnimation *)mzFadeAppearAnimationWithDuration:(float)duration;
/// 渐变动画
+ (CAAnimation *)mzFadeDisappearAnimationWithDuration:(float)duration;
/// 渐变动画
+ (CAAnimation *)mzFadeTransitionWithDuration:(float)duration;

/// 位置动画
+ (CAAnimation *)mzMoveAnimationWithDuration:(float)duration
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint;

/// 透明度动画
+ (CAAnimation *)mzAlphaAnimationWithDuration:(float)duration
                                    baseAlpha:(float)baseAlpha
                                  targetAlpha:(float)targetAlpha;

/// 比例动画（大小变化）
+ (CAAnimation *)mzScaleAnimationWithDuration:(float)duration
                                    baseScale:(float)baseScale
                                  targetScale:(float)targetScale;

#pragma mark - High Level Animation
/// 闪烁动画
+ (CAAnimation *)mzPlaneTwinkleAnimationWithDuration:(float)duration;

/// 抖动动画
+ (CAAnimation *)mzLineShakeAnimationWithDuration:(float)duration
                                       fromCenter:(CGPoint)sCenter
                                         toCenter:(CGPoint)dCenter;
/// 抖动动画
+ (CAAnimation *)mzPlaneShakeAnimationWithDuration:(float)duration
                                       shakeCenter:(CGPoint)shakeCenter
                                             scope:(float)scope;

/// 弹性动画（膨胀收缩）
+ (CAAnimation *)mzExpandShrinkAnimationWithDuration:(float)duration;

/* Gif转动画
 * 直接用UIWebView播放gif不方便控制gif的【播放次数】及【图片范围】 */
/// Gif转动画
+ (CAAnimation *)mzGifAnimationWithGifData:(NSData *)gifData duration:(float)duration;

/// 动画暂停
+ (void)pauseAnimationWithLayer:(CALayer *)inputLayer;
/// 动画继续
+ (void)resumeAnimationWithLayer:(CALayer *)inputLayer;

@end
