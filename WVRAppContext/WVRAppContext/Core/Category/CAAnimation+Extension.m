//
//  CAAnimation+Extension.m
//  WhaleyVR
//
//  Created by zhangliangliang on 9/27/16.
//  Copyright © 2016 Snailvr. All rights reserved.
//

#import "CAAnimation+Extension.h"
#import <ImageIO/ImageIO.h>
#import <UIKit/UIKit.h>

@implementation CAAnimation(MZExtension)

#pragma mark - 基础-渐变动画

+ (CAAnimation *)mzFadeAppearAnimationWithDuration:(float)duration {
    
    return [self mzAlphaAnimationWithDuration:duration baseAlpha:0 targetAlpha:1.0f];
}

+ (CAAnimation *)mzFadeDisappearAnimationWithDuration:(float)duration {
    
    return [self mzAlphaAnimationWithDuration:duration baseAlpha:1.0f targetAlpha:0];
}

+ (CAAnimation *)mzFadeTransitionWithDuration:(float)duration {
    
    CATransition *animation = [[CATransition alloc] init];
    [animation setBaseConfig];
    
    animation.duration = duration;
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.type = kCATransitionFade;
    
    return animation;
}

#pragma mark - 基础-位置动画

+ (CAAnimation *)mzMoveAnimationWithDuration:(float)duration
                                  startPoint:(CGPoint)startPoint
                                    endPoint:(CGPoint)endPoint {
    
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    [moveAnimation setBaseConfig];
    
    [moveAnimation setFromValue:[NSValue valueWithCGPoint:startPoint]];
    [moveAnimation setToValue:[NSValue valueWithCGPoint:endPoint]];
    [moveAnimation setDuration:duration];
    
    return moveAnimation;
}

#pragma mark - 基础-透明度动画

+ (CAAnimation *)mzAlphaAnimationWithDuration:(float)duration
                                    baseAlpha:(float)baseAlpha
                                  targetAlpha:(float)targetAlpha {
    
    CABasicAnimation *appearAnimatino = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [appearAnimatino setBaseConfig];
    
    appearAnimatino.fromValue = [NSNumber numberWithFloat:baseAlpha];
    appearAnimatino.toValue = [NSNumber numberWithFloat:targetAlpha];
    appearAnimatino.duration = duration;
    
    return appearAnimatino;
}

#pragma mark - 基础-比例动画

+ (CAAnimation *)mzScaleAnimationWithDuration:(float)duration
                                    baseScale:(float)baseScale
                                  targetScale:(float)targetScale {
    
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAnimation setBaseConfig];
    
    [scaleAnimation setFromValue:[NSNumber numberWithFloat:baseScale]];
    [scaleAnimation setToValue:[NSNumber numberWithFloat:targetScale]];
    [scaleAnimation setDuration:duration];
    
    return scaleAnimation;
}

#pragma mark - 高级-闪烁动画

+ (CAAnimation *)mzPlaneTwinkleAnimationWithDuration:(float)duration {
    
    CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    [scaleAnimation setBaseConfig];
    
    NSArray *valueArray = @[
                            [NSNumber numberWithFloat:1.0f],
                            [NSNumber numberWithFloat:0.3f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:0.5f],
                            [NSNumber numberWithFloat:0.9f],
                            [NSNumber numberWithFloat:0.6f],
                            [NSNumber numberWithFloat:0.2f],
                            [NSNumber numberWithFloat:0.7f],
                            [NSNumber numberWithFloat:0.1f],
                            [NSNumber numberWithFloat:0.45f],
                            [NSNumber numberWithFloat:0.2f],
                            [NSNumber numberWithFloat:1.0f],
                            ];
    
    [scaleAnimation setValues:valueArray];
    [scaleAnimation setDuration:duration];
    
    return scaleAnimation;
}

#pragma mark - 高级-抖动动画

#define SHAKE_ITEM(center, sizeRatio, zLength) \
[NSValue valueWithCGPoint:CGPointMake((center).x + (zLength) * (sizeRatio) * (xUnit), (center).y + (zLength) * (sizeRatio) * (yUnit))]
+ (CAAnimation *)mzLineShakeAnimationWithDuration:(float)duration
                                       fromCenter:(CGPoint)sCenter
                                         toCenter:(CGPoint)dCenter {
    
    float xLength = dCenter.x - sCenter.x;
    float yLength = dCenter.y - sCenter.y;
    float zLength = powf(xLength, 2) + powf(yLength, 2);
    zLength = sqrtf(zLength);
    
    float xUnit = xLength / zLength;
    float yUnit = yLength / zLength;
    
    float smallerRatio = 0.2;
    float sizeRatio0 = 0;
    float sizeRatio1 = 0.4 * smallerRatio;
    float sizeRatio2 = -0.3 * smallerRatio;
    float sizeRatio3 = 0.2 * smallerRatio;
    float sizeRatio4 = -0.1 * smallerRatio;
    float sizeRatio5 = 0 * smallerRatio;
    
    
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setBaseConfig];
    
    [keyAn setDuration:duration];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      SHAKE_ITEM(dCenter, sizeRatio0, zLength),
                      SHAKE_ITEM(dCenter, sizeRatio1, zLength),
                      SHAKE_ITEM(dCenter, sizeRatio2, zLength),
                      SHAKE_ITEM(dCenter, sizeRatio3, zLength),
                      SHAKE_ITEM(dCenter, sizeRatio4, zLength),
                      SHAKE_ITEM(dCenter, sizeRatio5, zLength),
                      nil];
    [keyAn setValues:array];
    
    return keyAn;
}

#define PLANE_SHAKE_ITEM(center, scope, xRatio, yRatio) \
[NSValue valueWithCGPoint:CGPointMake((center).x + (xRatio) * (scope), (center).y + (yRatio) * (scope))]

+ (CAAnimation *)mzPlaneShakeAnimationWithDuration:(float)duration
                                       shakeCenter:(CGPoint)shakeCenter
                                             scope:(float)scope; {
    
    CAKeyframeAnimation *keyAn = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    [keyAn setBaseConfig];
    
    [keyAn setDuration:duration];
    NSArray *array = [[NSArray alloc] initWithObjects:
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.6, 0.8),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.7, -0.4),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.3, 0.2),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, -0.6, 0.5),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, -0.1, 0.1),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.1, -0.8),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.9, -0.5),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.6, 0.5),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.2, -0.3),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.6, -0.8),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, -0.6, -0.7),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, -0.1, -0.2),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.9, 0.7),
                      PLANE_SHAKE_ITEM(shakeCenter, scope, 0.1, 0.2),
                      nil];
    [keyAn setValues:array];
    
    return keyAn;
}

#pragma mark - 高级-弹性动画

+ (CAAnimation *)mzExpandShrinkAnimationWithDuration:(float)duration {
    
    CAKeyframeAnimation *scaleAniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    [scaleAniamtion setBaseConfig];
    
    NSArray *valueArray = @[
                            [NSNumber numberWithFloat:1.05f],
                            [NSNumber numberWithFloat:0.9f],
                            [NSNumber numberWithFloat:1.15f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.3f],
                            [NSNumber numberWithFloat:0.7f],
                            [NSNumber numberWithFloat:1.45f],
                            
                            [NSNumber numberWithFloat:0.7f],
                            [NSNumber numberWithFloat:1.3f],
                            [NSNumber numberWithFloat:0.8f],
                            [NSNumber numberWithFloat:1.15f],
                            [NSNumber numberWithFloat:0.9f],
                            [NSNumber numberWithFloat:1.05f],
                            [NSNumber numberWithFloat:1.0f],
                            ];
    [scaleAniamtion setValues:valueArray];
    [scaleAniamtion setDuration:1];
    
    return scaleAniamtion;
}


#pragma mark - Gif转CAAnimation动画

+ (CAAnimation *)mzGifAnimationWithGifData:(NSData *)gifData duration:(float)duration {
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    
    NSArray *valueArray = [self imageRefArrayFromGifSource:gifSource];
    NSArray *frameDurationArray = [self frameDurationArrayFromGifSource:gifSource];
    NSArray *keyTimeArray = [self keyTimesArrayFromFrameDurationArray:frameDurationArray];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    [animation setDuration:duration];
    [animation setValues:valueArray];
    [animation setKeyTimes:keyTimeArray];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    CFRelease(gifSource);
    return animation;
}

+ (CAAnimation *)animationFromGifData:(NSData *)gifData {
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((CFDataRef)gifData, NULL);
    
    NSArray *valueArray = [self imageRefArrayFromGifSource:gifSource];
    NSArray *frameDurationArray = [self frameDurationArrayFromGifSource:gifSource];
    NSArray *keyTimeArray = [self keyTimesArrayFromFrameDurationArray:frameDurationArray];
    double duration = [self totalDurationFromDurationArray:frameDurationArray];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
    
    [animation setDuration:duration];
    [animation setValues:valueArray];
    [animation setKeyTimes:keyTimeArray];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    CFRelease(gifSource);
    return animation;
}

+ (NSArray *)imageRefArrayFromGifSource:(CGImageSourceRef)gifSource {
    
    size_t imageNum = CGImageSourceGetCount(gifSource);
    
    NSMutableArray *tmpImageArray = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < imageNum; ++i) {
        
        CGImageRef tmpImageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [tmpImageArray addObject:(__bridge id _Nonnull)(tmpImageRef)];
        CGImageRelease(tmpImageRef);
    }
    
    return [NSArray arrayWithArray:tmpImageArray];
}

+ (NSArray *)frameDurationArrayFromGifSource:(CGImageSourceRef)gifSource {
    
    size_t imageNum = CGImageSourceGetCount(gifSource);
    
    NSMutableArray *tmpTimeArray = [[NSMutableArray alloc] init];
    for (size_t i = 0; i < imageNum; ++i) {
        NSDictionary *tmpDic = CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL));
        NSDictionary *gifDic = [tmpDic valueForKey:(NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *tmpNum = [gifDic valueForKey:(NSString *)kCGImagePropertyGIFDelayTime];
        [tmpTimeArray addObject:tmpNum];
    }
    
    return [NSArray arrayWithArray:tmpTimeArray];
}

+ (NSArray *)keyTimesArrayFromFrameDurationArray:(NSArray *)durationArray {
    
    float duration = [self totalDurationFromDurationArray:durationArray];
    
    NSMutableArray *tmpArray = [[NSMutableArray alloc] init];
    float progress = 0;
    
    for (NSNumber *tmpNumber in durationArray) {
        
        float tmpKeyTime = progress / duration;
        [tmpArray addObject:@(tmpKeyTime)];
        
        progress += [tmpNumber floatValue];
    }
    
    return [NSArray arrayWithArray:tmpArray];
}

+ (float)totalDurationFromDurationArray:(NSArray *)durationArray {
    
    float totalDuration = 0;
    
    for (NSNumber *tmpNumber in durationArray) {
        totalDuration += [tmpNumber floatValue];
    }
    
    return totalDuration;
}

#pragma mark -  动画暂停 & 继续

+ (void)pauseAnimationWithLayer:(CALayer *)inputLayer {
    
    if (0 == inputLayer.speed) {
        return;
    }
    
    CFTimeInterval interval = [inputLayer convertTime:CACurrentMediaTime() fromLayer:nil];
    [inputLayer setTimeOffset:interval];
    inputLayer.speed = 0;
}

+ (void)resumeAnimationWithLayer:(CALayer *)inputLayer {
    
    if (1 == inputLayer.speed) {
        return;
    }
    
    CFTimeInterval beginTime = CACurrentMediaTime() - inputLayer.timeOffset;
    inputLayer.timeOffset = 0;
    inputLayer.beginTime = beginTime;
    inputLayer.speed = 1.0;
}

#pragma mark - MISC

- (void)setBaseConfig {
    
    [self setRemovedOnCompletion:YES];
    [self setRepeatCount:1];
}

@end
