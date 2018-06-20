//
//  WVRAppContext.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/17.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WVRAppContext : NSObject
// 设备信息
@property (nonatomic, copy, readonly) NSString *type;
@property (nonatomic, copy, readonly) NSString *model;
@property (nonatomic, copy, readonly) NSString *os;
@property (nonatomic, copy, readonly) NSString *rom;
@property (nonatomic, copy, readonly) NSString *ppi;
@property (nonatomic, copy, readonly) NSString *imei;
@property (nonatomic, copy, readonly) NSString *imsi;
@property (nonatomic, copy, readonly) NSString *deviceName;
@property (nonatomic, assign, readonly) CGSize resolution;

// 运行环境相关
//@property (nonatomic, assign, readonly) BOOL isReachable;
//@property (nonatomic, assign, readonly) BOOL isOnline;

// 用户token相关
@property (nonatomic, copy, readonly) NSString *accessToken;
@property (nonatomic, copy, readonly) NSString *refreshToken;
@property (nonatomic, assign, readonly) NSTimeInterval lastRefreshTime;

// 用户信息
@property (nonatomic, copy) NSDictionary *userInfo;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, readonly) BOOL isLoggedIn;

// app信息
@property (nonatomic, copy, readonly) NSString *sessionId;  // 每次启动App时都会新生成
@property (nonatomic, readonly) NSString *appVersion;
@property (nonatomic, assign) BOOL gShouldAutorotate;       // 是否开启控制器方向旋转
@property (nonatomic, assign) UIInterfaceOrientationMask gSupportedInterfaceO;
@property (nonatomic, assign) UIInterfaceOrientation gPreferredInterfaceO;
@property (nonatomic, assign) BOOL gStatusBarHidden;
@property (nonatomic, assign) BOOL gHomeDidAppear;

@property (nonatomic, assign) BOOL gHomeIndicatorAutoHidden;
// 推送相关
@property (nonatomic, copy) NSData *deviceTokenData;
@property (nonatomic, copy) NSString *deviceToken;
//@property (nonatomic, strong) WVRAPIBaseManager *updateTokenAPIManager;

// 地理位置
@property (nonatomic, assign, readonly) CGFloat latitude;
@property (nonatomic, assign, readonly) CGFloat longitude;

+ (instancetype)sharedInstance;

- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken;
- (void)cleanUserInfo;

- (void)appStarted;
- (void)appEnded;

+ (UIViewController*)curViewController;

@end
