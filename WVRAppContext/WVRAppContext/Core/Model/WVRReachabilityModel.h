//
//  WVRReachabilityModel.h
//  VRManager
//
//  Created by Snailvr on 16/7/6.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WVRReachabilityModel : NSObject

/// WiFi
@property (nonatomic, assign, readonly) BOOL isWifi;
/// 蜂窝网
@property (nonatomic, assign, readonly) BOOL isReachNet;
/// 无网络
@property (nonatomic, assign, readonly) BOOL isNoNet;

/// 单例
+ (instancetype)sharedInstance;

/// App初始化时调用
+ (void)setupReachability;

/// 当前网络是否可用
+ (BOOL)isNetWorkOK;

/// 当前网络状态转化为字符串，用来日志记录和上报
- (NSString *)netWorkStatusString;

@end
