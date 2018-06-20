//
//  WVRAppDebugDefine.h
//  WVRAppContext
//
//  Created by qbshen on 2017/8/8.
//  Copyright © 2017年 WhaleyVR. All rights reserved.
//


#import "WVRAppDefine.h"

#ifndef WVRAppDebugDefine_h
#define WVRAppDebugDefine_h

#import <CocoaLumberjack/CocoaLumberjack.h>
#import <CocoaLumberjack/DDLogMacros.h>

/**********************  DDLog  **********************/

#ifdef DEBUG
#define ddLogLevel (DDLogLevelVerbose)
#else
#if (kAppEnvironmentTest == 1)
#define ddLogLevel (DDLogLevelInfo)
#else
#define ddLogLevel (DDLogLevelOff)
#endif
#endif


/**********************  调试输出  **********************/

#if (kAppEnvironmentTest == 0)

#define NSLog(...)              // release时，如果是测试环境就打印到文件，否则不打印 kAppEnvironmentTest
#define DebugLog(...)

#else                           // debug时打印

//#define NSLog(fmt, ...)         NSLog((fmt), ##__VA_ARGS__);      // debug时正常NSLog，不用宏定义
#define DebugLog(fmt, ...)      NSLog((@"%s " "[Line: %d] " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);        // 打印详情

//#define NSLog(...)      printf("%s\n", [[NSString stringWithFormat:__VA_ARGS__] UTF8String])
//#define DebugLog(...)   printf("%s Line %d %s\n", __PRETTY_FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String])                // 打印详情
#endif


#endif /* WVRAppDebugDefine_h */
