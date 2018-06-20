//
//  WVRAppFrameDefine.h
//  WVRAppContext
//
//  Created by qbshen on 2017/8/8.
//  Copyright © 2017年 WhaleyVR. All rights reserved.
//

#ifndef WVRAppFrameDefine_h
#define WVRAppFrameDefine_h

/******************** Screen   Size ********************/

#define SCREEN_WIDTH			CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT           CGRectGetHeight([[UIScreen mainScreen] bounds])

#define MIN_SCREEN_WIDTH        MIN(SCREEN_WIDTH, SCREEN_HEIGHT)
#define MAX_SCREEN_WIDTH        MAX(SCREEN_WIDTH, SCREEN_HEIGHT)


#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)


#define kStatuBarHeight         (kDevice_Is_iPhoneX? 44.0f: 20.0f)
#define kNavBarHeight           (kDevice_Is_iPhoneX? 88.0f: 64.0f)
#define kTabBarHeight           (kDevice_Is_iPhoneX? 83.0f: 49.0f)

#import "WVRFrameDefineHelper.h"

#define fitToWidth(len)         (wvr_fitToWidth(len))       // 定宽适配，跟据屏幕宽度适配控件高度
#define adaptToWidth(len)       (wvr_adaptToWidth(len))     // 定宽适配，并取整


#define kItemDistance           0.f                   // cell到边框距离
#define kListCellDistance       1.f                   // cell横向间距
#define kDefaultDistance        8.f                   // 默认间距 一期需求
#define kCellTitleDistance      8.f                   // cell标题边距
#define kTitleHeight            adaptToWidth(30.f)    // cell默认标题区高度 不带描述
#define kCellTitleHeight        adaptToWidth(90/2.f)  // cell默认标题区高度 带描述
#define kCellLogoHeight         adaptToWidth(48.f)    // cell带logo标题区高度
#define kSectionHeaderHeight    50.f                  // 区头默认高度
#define kLineHeight             10.f                  // section间分隔线的高度



#endif /* WVRAppFrameDefine_h */
