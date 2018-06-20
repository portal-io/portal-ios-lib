//
//  WVRFrameDefineHelper.h
//  WhaleyVR
//
//  Created by Bruce on 2017/8/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WVRFrameDefineHelper : NSObject

/// 以375为标准定宽适配
#define NORMAL_SCREEN_WIDTH     375.f

extern float wvr_fitToWidth(float len);
extern float wvr_adaptToWidth(float len);

@end
