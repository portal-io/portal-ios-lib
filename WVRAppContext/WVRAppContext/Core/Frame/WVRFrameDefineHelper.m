//
//  WVRFrameDefineHelper.m
//  WhaleyVR
//
//  Created by Bruce on 2017/8/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRFrameDefineHelper.h"

@implementation WVRFrameDefineHelper

static float _kWidthFitScale_ = 1;      // 定宽适配比例

+ (void)load {
    
    float normal_screen_width = NORMAL_SCREEN_WIDTH;
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    float height = CGRectGetHeight(screenBounds);
    float width = CGRectGetWidth(screenBounds);
    
    float finalWidth = MIN(width, height);
    
    _kWidthFitScale_ = (finalWidth / normal_screen_width);
}

inline float wvr_fitToWidth(float len) {
    
    float result = len * _kWidthFitScale_;
    result = (roundf(result * 10) / 10.f);
    
    return result;
}

inline float wvr_adaptToWidth(float len) {
    
    float result = roundf(len * _kWidthFitScale_);
    
    return result;
}

@end
