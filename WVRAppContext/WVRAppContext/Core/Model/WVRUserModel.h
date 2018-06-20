//
//  WVRUserModel.h
//  VRManager
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRAPIConst.h"

#define PLAYER_MODE_VR          @"player_mode_vr"
#define PLAYER_MODE_MOBILE      @"player_mode_mobile"

@interface WVRUserModel : NSObject

#pragma mark - User Info

@property (nonatomic) BOOL isTest;
@property (nonatomic) BOOL isBIOpen;
@property (nonatomic) BOOL firstLaunch;

@property (nonatomic) BOOL liveTipIsShow;

@property (nonatomic) NSString* playerMode;

//@property (nonatomic) BOOL gShowUserAuthSuccess;

/// 是否已登录
@property (nonatomic, assign, getter=isisLogined) BOOL isLogined;

@property (nonatomic) BOOL isReport;
@property (nonatomic, assign, getter=isFirstLogin) BOOL firstLogin;

/// 手机号
@property (nonatomic, copy) NSString *mobileNumber;

/// 登录密码
@property (nonatomic, copy) NSString *password;

/// access token
@property (nonatomic, copy) NSString *sessionId;

/// 设备ID
@property (nonatomic, readonly) NSString *deviceId;

/// 设备型号
@property (nonatomic, readonly) NSString *deviceModel;

/// userId
@property (nonatomic, copy) NSString *accountId;        // "25047119"    userId

/// 昵称
@property (nonatomic, copy) NSString *username;

/// 头像
@property (nonatomic, copy) NSString *loginAvatar;

@property (nonatomic, strong) NSString * showRoomUserID;

@property (nonatomic) NSString *avatarCachPath;

@property (nonatomic, copy) NSString *sms_token;
@property (nonatomic, copy) NSString *expiration_time;
@property (nonatomic, copy) NSString *now_time;
@property (nonatomic, copy) NSString *openIdForBinding;
@property (nonatomic) NSString *wechatUnionid;
@property (nonatomic) NSString *refreshtoken;

@property (nonatomic, assign) BOOL QQisBinded;
@property (nonatomic, assign) BOOL WBisBinded;
@property (nonatomic, assign) BOOL WXisBinded;

@property (nonatomic, readonly) NSString * random32;

/// 头像Image缓存
@property (nonatomic, strong) UIImage *tmpAvatar;

@property (nonatomic, assign) NSInteger wcBalance;

+ (instancetype)sharedInstance;

//MARK: - API

+ (NSString *)kAPI_VERSION;
+ (NSString *)kWhaleyAccountBaseURL;
+ (NSString *)kNewVRBaseURL;
+ (NSString *)kStoreBaseURL;
+ (NSString *)kBIBaseURL;
+ (NSString *)biBaseURLForTest:(BOOL)test;
+ (NSString *)kBusBaseURL;
+ (NSString *)kSnailvrBaseURL;

+ (NSString *)hybridWebParams;
+ (NSString *)CMCHistory_sign_secret;
+ (NSString *)CMCPURCHASE_sign_secret;
//+ (NSString *)hybridWebUrlPrefix;

+ (NSString *)aboutUsShareLink;

//MARK: - User Setting

@property (nonatomic, assign, getter=isOnlyWifi) BOOL onlyWifi;
@property (nonatomic, assign) NSInteger defaultDefinition;


+ (void)registUAForWebView;

@end
