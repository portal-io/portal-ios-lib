//
//  WVRNetworkingConfig.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#ifndef WVRNetworkingConfig_h
#define WVRNetworkingConfig_h

typedef NS_ENUM(NSUInteger, WVRNetworkingResponseStatus)
{
    WVRNetworkingResponseStatusSuccess,             // 请求成功
    WVRNetworkingResponseStatusErrorTimeout,        // 请求超时错误
    WVRNetworkingResponseStatusErrorNoNetwork       // 请求失败或无网络链接
};

static NSString *WVRKeychainServiceName = @"xxxxx";
static NSString *WVRUDIDName = @"xxxx";

static BOOL kWVRShouldCache = NO;
static BOOL kWVRServiceIsOnline = NO;
static NSTimeInterval kWVRNetworkingTimeoutSeconds = 20.0f;
static NSTimeInterval kWVRCacheOutdateTimeSeconds = 5 * 60;
static NSUInteger kWVRCacheCountLimit = 1000;



#endif /* WVRNetworkingConfig_h */
