//
//  WVRAppDefine.h
//  WVRAppContext
//
//  Created by qbshen on 2017/8/8.
//  Copyright © 2017年 WhaleyVR. All rights reserved.
//

#ifndef WVRAppDefine_h
#define WVRAppDefine_h

#define tag_TOAST_IN_WINDOWS 2000

#define kWeakSelf(type)  __weak typeof(type) weak##type = type;

/******************** Macro ********************/

#define kRootViewController [[[[UIApplication sharedApplication] windows] firstObject] rootViewController]

/******************** App Environment ********************/

#define kAppEnvironmentTest 1           // 全局内测环境配置 0代表线上 1代表内测


/******************** System Version ********************/

#define kSystemVersion   [[[UIDevice currentDevice] systemVersion] floatValue]
#define kBuildVersion    [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define kAppVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//#define IS_IOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0? YES : NO) //判断是否为IOS9的系统


#endif /* WVRAppDefine_h */
