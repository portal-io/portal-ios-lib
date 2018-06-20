//
//  WVRUserModel.m
//  VRManager
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRUserModel.h"
#import "SAMKeychain.h"
#import "WVRDeviceModel.h"
#import "NSString+Extend.h"
#import "NSDictionary+Extension.h"
#import "WVRNotificationHeader.h"
#import "WVRAppDebugDefine.h"

#define SAMKeychain_Service  (@"uuid")
#define SAMKeychain_Account (@"com.snailvr.glasswork")

#define KEY_CHAIN_WRAPPER_ID (@"AccountNumber")

#define KEY_USER_SESSIONID (@"key_user_session_id")

#define KEY_USER_LOGIN_AVATAR (@"key_user_loginAvatar")
#define KEY_USER_EXPIRE_TIME (@"key_user_expiration_time")

#define KEY_USER_IS_LOGINED (@"key_user_is_logined")
#define KEY_USER_IS_TEST (@"key_user_is_test")
#define KEY_USER_IS_REPORT (@"key_user_is_report")
#define KEY_USER_ACCOUNTID (@"key_user_account_id")
#define KEY_USER_NICKNAME (@"key_user_nick_name")
#define KEY_USER_MOBLIE_NUM (@"key_user_mobile_num")
#define KEY_USER_avatar_cach_path (@"key_user_avatar_cach_path")
#define KEY_USER_REPORT_RANDOM (@"key_user_report_random")

#define KEY_USER_REFRESH_TOKEN (@"key_user_account_refreshtoken")

#define KEY_USER_FIRST_LAUNCH (@"key_user_first_launch")
#define KEY_USER_LIVE_TIP_ISSHOW (@"key_user_liveTipIsShow")

#define KEY_USER_HAVE_PLAYER_MODE (@"key_user_have_player_mode")

#define KEY_USER_PLAYER_MODE (@"key_user_player_mode")

#define KEY_USER_PLAYER_CLARITY_MODE (@"key_user_player_clarity_mode")

#define KEY_USER_IS_BINDQQ (@"key_user_is_bindQQ")

#define KEY_USER_IS_BINDWX (@"key_user_is_bindWX")

#define KEY_USER_IS_BINDWB (@"key_user_is_bindWB")

@interface WVRUserModel() {
    
    NSNumber *_defaultDefinition;
    NSNumber *_isOnlyWifi;
    NSNumber *_isFirstLaunch;
    NSNumber *_isTest;
    NSNumber *_isBIOpen;
    NSNumber *_liveTipIsShow;
    NSNumber *_isLogined;
    NSNumber *_isReport;
    
    NSNumber *_isBindQQ;
    NSNumber *_isBindWX;
    NSNumber *_isBindWB;
}

@end


@implementation WVRUserModel
@synthesize deviceModel = _deviceModel;
@synthesize accountId = _accountId;
@synthesize username = _username;
@synthesize random32 = _random32;
@synthesize mobileNumber = _mobileNumber;
@synthesize sessionId = _sessionId;
@synthesize expiration_time = _expiration_time;
@synthesize loginAvatar = _loginAvatar;
@synthesize refreshtoken = _refreshtoken;
@synthesize firstLaunch = _firstLaunch;
@synthesize playerMode = _playerMode;
@synthesize deviceId = _deviceId;

+ (instancetype)sharedInstance {
    
    static WVRUserModel *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WVRUserModel alloc] init];
    });
    
    return _sharedInstance;
}

#pragma mark - setter

- (void)setIsTest:(BOOL)isTest {

#if (kAppEnvironmentTest == 1)
    _isTest = @(isTest);
    
    [[NSUserDefaults standardUserDefaults] setObject:_isTest forKey:KEY_USER_IS_TEST];
    [[NSUserDefaults standardUserDefaults] synchronize];
#endif
}

- (BOOL)isTest {
    
#if (kAppEnvironmentTest == 0)
    return NO;
#else
    
    if (!_isTest) {
        _isTest = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_TEST];
        if (!_isTest) {
            _isTest = @(NO);
            [[NSUserDefaults standardUserDefaults] setObject:_isTest forKey:KEY_USER_IS_TEST];    // 默认值
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return [_isTest boolValue];
#endif
}

- (void)setIsBIOpen:(BOOL)isBIOpen {
    
#if (kAppEnvironmentTest == 1)
    _isBIOpen = @(isBIOpen);
    [[NSUserDefaults standardUserDefaults] setObject:_isBIOpen forKey:@"kBIOpenKey"];
    [[NSUserDefaults standardUserDefaults] synchronize];
#endif
}

- (BOOL)isBIOpen {
    
#if (kAppEnvironmentTest == 0)
    return NO;
#else
    
    if (!_isBIOpen) {
        _isBIOpen = [[NSUserDefaults standardUserDefaults] objectForKey:@"kBIOpenKey"];
        if (!_isBIOpen) {
            _isBIOpen = @(NO);
            [[NSUserDefaults standardUserDefaults] setObject:_isBIOpen forKey:@"kBIOpenKey"];    // 默认值
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return [_isBIOpen boolValue];
#endif
}

- (void)setRandom32:(NSString *)random32 {
    
    [[NSUserDefaults standardUserDefaults] setObject:random32 forKey:KEY_USER_REPORT_RANDOM];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)random32 {
    
    if (_random32.length < 1) {
        
        _random32 = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_REPORT_RANDOM];
        
        if (_random32.length < 1) {
            
            _random32 = [[NSString alloc] init];
            for (int i = 0; i < 32; i++)
            {
                NSString *number = [NSString stringWithFormat:@"%d", arc4random() % 10];
                _random32 = [_random32 stringByAppendingString:number];
            }
            [self setRandom32:_random32];
        }
    }
    return _random32;
}

#pragma mark - getter

- (UIImage *)tmpAvatar {
    
    if (self.isLogined) {
        
        if (!_tmpAvatar) {
            
            NSString *lib = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
            
            NSString *imageFilePath = [lib stringByAppendingPathComponent:@"selfPhoto.jpg"];
            NSData *data = [NSData dataWithContentsOfFile:imageFilePath];
            UIImage *img = [UIImage imageWithData:data];
            
            _tmpAvatar = img;
            if (!img) {
                
                _tmpAvatar = [UIImage imageNamed:@"avatar_myPage"];
            }
        }
        
    } else {
        _tmpAvatar = [UIImage imageNamed:@"avatar_myPage"];
    }
    
    return _tmpAvatar;
}

- (void)setMobileNumber:(NSString *)mobileNumber {
    
    if (nil == mobileNumber) { return; }
    
    _mobileNumber = mobileNumber;
    
    [[NSUserDefaults standardUserDefaults] setObject:mobileNumber forKey:KEY_USER_MOBLIE_NUM];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)mobileNumber {
    
    if (![self isisLogined]) { return @""; }
    
    if (nil == _mobileNumber) {
        _mobileNumber = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_MOBLIE_NUM];
        
        if (_mobileNumber == nil) { _mobileNumber = @""; }
    }
    
    return _mobileNumber;
}

- (void)setUsername:(NSString *)username {
    
    if (nil == username) { return; }
    
    _username = username;
    
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:KEY_USER_NICKNAME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)username {
    
    if (![self isisLogined]) { return @""; }
    
    if (nil == _username) {
        _username = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_NICKNAME];
        
        if (nil == _username) { _username = @""; }
    }
    return _username;
}


- (NSString *)avatarCachPath {
    
    if (![self isisLogined]) { return @""; }
    
    NSString *lib = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *imageFilePath = [lib stringByAppendingPathComponent:@"selfPhoto.jpg"];
    return imageFilePath;
}

#pragma mark - User Info

- (void)setIsLogined:(BOOL)isLogined {
    
    _isLogined = @(isLogined);
        
    [[NSNotificationCenter defaultCenter] postNotificationName:NAME_NOTF_RESERVE_PRESENTER_REFRESH object:nil];
    [[NSUserDefaults standardUserDefaults] setObject:@(isLogined) forKey:KEY_USER_IS_LOGINED];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:NAME_NOTF_MANUAL_ARRANGE_PROGRAMPACKAGE object:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kLoginStatusNotification object:self userInfo:@{ @"status" : @(isLogined) }];
}

- (BOOL)isisLogined {
    
    if (nil == _isLogined) {
        _isLogined = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_LOGINED];
    }
    return [_isLogined boolValue];
}

- (void)setIsReport:(BOOL)isReport {
    
    _isReport = @(isReport);
    
    [[NSUserDefaults standardUserDefaults] setObject:_isReport forKey:KEY_USER_IS_REPORT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isReport {
    
    if (nil == _isReport) {
        _isReport = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_REPORT];
    }
    
    return [_isReport boolValue];
}

- (void)setAccountId:(NSString *)accountId {
    
    if (nil == accountId) { return; }
    
    _accountId = accountId;
    
    [[NSUserDefaults standardUserDefaults] setObject:accountId forKey:KEY_USER_ACCOUNTID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)accountId {
    
    if (![self isisLogined]) { return @""; }
    
    if (nil == _accountId) {
        _accountId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_ACCOUNTID];
        if (nil == _accountId) { _accountId = @""; }
    }
    return _accountId;
}

/// access token
- (NSString *)sessionId {
    
//    if (![self isisLogined]) { return @""; }
    
    if (nil == _sessionId) {
        _sessionId = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_SESSIONID];
        if (nil == _sessionId) { _sessionId = @""; }
    }
    return _sessionId;
}

#pragma mark - fix bug for jspatch

- (NSString *)expiration_time {
    
    if (nil == _expiration_time) {
        _expiration_time = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_EXPIRE_TIME];
    }
    return _expiration_time;
}

- (void)setExpiration_time:(NSString *)expiration_time {
    
    if (nil == expiration_time) { return; }
    
    _expiration_time = expiration_time;
    
    [[NSUserDefaults standardUserDefaults] setObject:expiration_time forKey:KEY_USER_EXPIRE_TIME];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)loginAvatar {
    
    if (nil == _loginAvatar) {
        _loginAvatar = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_LOGIN_AVATAR];
        NSString * dateTimeParam = [NSString stringWithFormat:@"&dateTime=%@",[self currentTimeStr]];
        _loginAvatar = [_loginAvatar stringByAppendingString:dateTimeParam];
    }
    return _loginAvatar;
}

//获取当前时间戳
- (NSString *)currentTimeStr{
    NSDate* date = [NSDate date];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

- (void)setLoginAvatar:(NSString *)loginAvatar {
    
    if (nil == loginAvatar) { return; }
    
    _loginAvatar = loginAvatar;
    NSString * dateTimeParam = [NSString stringWithFormat:@"&dateTime=%@",[self currentTimeStr]];
    _loginAvatar = [_loginAvatar stringByAppendingString:dateTimeParam];
    [[NSUserDefaults standardUserDefaults] setObject:loginAvatar forKey:KEY_USER_LOGIN_AVATAR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - over fix bug jspatch

- (void)setSessionId:(NSString *)sessionId {
    
    if (nil == sessionId) { return; }
    
    _sessionId = sessionId;
    
    [[NSUserDefaults standardUserDefaults] setObject:sessionId forKey:KEY_USER_SESSIONID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)refreshtoken {
    
    if (_refreshtoken == nil) {
        _refreshtoken = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_REFRESH_TOKEN];
    }
    return _refreshtoken;
}

- (void)setRefreshtoken:(NSString *)refreshtoken {
    
    if (nil == refreshtoken) { return; }
    
    _refreshtoken = refreshtoken;
    
    [[NSUserDefaults standardUserDefaults] setObject:refreshtoken forKey:KEY_USER_REFRESH_TOKEN];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - device Info

- (NSString *)deviceId {
    
    if (_deviceId.length > 0) {
        return _deviceId;
    }
    
    NSString *currentDeviceUUIDStr = [SAMKeychain passwordForService:SAMKeychain_Service account:SAMKeychain_Account];
    if (currentDeviceUUIDStr.length < 1) {
        
        NSUUID * currentDeviceUUID  = [UIDevice currentDevice].identifierForVendor;
        currentDeviceUUIDStr = currentDeviceUUID.UUIDString;
        currentDeviceUUIDStr = [currentDeviceUUIDStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
        currentDeviceUUIDStr = [currentDeviceUUIDStr lowercaseString];
        [SAMKeychain setPassword:currentDeviceUUIDStr forService:SAMKeychain_Service account:SAMKeychain_Account];
    }
    _deviceId = currentDeviceUUIDStr;
    
    return currentDeviceUUIDStr ?: @"";
}

- (NSString *)deviceModel {
    
    if (_deviceModel.length < 1) {
        _deviceModel = [WVRDeviceModel deviceModel];
    }
    return _deviceModel;
}

- (BOOL)liveTipIsShow {
    
    if (nil == _liveTipIsShow) {
        _liveTipIsShow = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_LIVE_TIP_ISSHOW];
    }
    return [_liveTipIsShow boolValue];
}

- (void)setLiveTipIsShow:(BOOL)liveTipIsShow {
    
    _liveTipIsShow = @(liveTipIsShow);
    [[NSUserDefaults standardUserDefaults] setObject:_liveTipIsShow forKey:KEY_USER_LIVE_TIP_ISSHOW];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - User Setting

- (BOOL)firstLaunch {
    
    if (nil == _isFirstLaunch) {
        _isFirstLaunch = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_FIRST_LAUNCH];
    }
    return ![_isFirstLaunch boolValue];
}

- (void)setFirstLaunch:(BOOL)firstLaunch {
    
    _isFirstLaunch = @(!firstLaunch);
    [[NSUserDefaults standardUserDefaults] setObject:_isFirstLaunch forKey:KEY_USER_FIRST_LAUNCH];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setPlayerMode:(NSString *)playerMode {
//    if (!playerMode) {
//        playerMode = PLAYER_MODE_VR;
//    }
//    [self setHavePlayerMode:YES];
//    [[NSUserDefaults standardUserDefaults] setObject:playerMode forKey:KEY_USER_PLAYER_MODE];
//    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)playerMode {
    
//    NSString *pMode = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_PLAYER_MODE];
//    if (!pMode) {
//        return PLAYER_MODE_MOBILE;
//    }
//    return pMode;
    
    return PLAYER_MODE_MOBILE;
}

- (void)setOnlyWifi:(BOOL)onlyWifi {
    
    if (onlyWifi) {
        _isOnlyWifi = @(1);    //1 代表禁止2G/3G/4G环境下使用缓存功能
    } else {
        _isOnlyWifi = @(0);    //0 代表允许2G/3G/4G环境下使用缓存功能
    }
    [[NSUserDefaults standardUserDefaults] setObject:_isOnlyWifi forKey:@"kOnlyWifi"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)isOnlyWifi {
    
    if (!_isOnlyWifi) {
        _isOnlyWifi = [[NSUserDefaults standardUserDefaults] valueForKey:@"kOnlyWifi"];
        
        if (!_isOnlyWifi) {
            
            _isOnlyWifi = @(1);
            [[NSUserDefaults standardUserDefaults] setObject:_isOnlyWifi forKey:@"kOnlyWifi"];    //1 代表禁止2G/3G/4G环境下使用缓存功能
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    return _isOnlyWifi.intValue == 1;
}


- (void)setDefaultDefinition:(NSInteger)defaultDefinition {
    
    _defaultDefinition = @(defaultDefinition);
    
    //0 代表高清  //1 代表超清
    [[NSUserDefaults standardUserDefaults] setObject:_defaultDefinition forKey:@"kDefaultDefinition"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSInteger)defaultDefinition {
    
    if (nil == _defaultDefinition) {
        
        _defaultDefinition = [[NSUserDefaults standardUserDefaults] valueForKey:@"kDefaultDefinition"];
        
        if (!_defaultDefinition) {
            
            _defaultDefinition = @(0);
            [[NSUserDefaults standardUserDefaults] setObject:_defaultDefinition forKey:@"kDefaultDefinition"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    return _defaultDefinition.integerValue;
}

-(BOOL)QQisBinded
{
    if (nil == _isBindQQ) {
        _isBindQQ = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_BINDQQ];
    }
    return [_isBindQQ boolValue];
}

-(void)setQQisBinded:(BOOL)QQisBinded
{
    _isBindQQ = @(QQisBinded);
    
    [[NSUserDefaults standardUserDefaults] setObject:_isBindQQ forKey:KEY_USER_IS_REPORT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)WBisBinded
{
    if (nil == _isBindWB) {
        _isBindWB = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_BINDQQ];
    }
    return [_isBindWB boolValue];
}

-(void)setWBisBinded:(BOOL)WBisBinded
{
    _isBindWB = @(WBisBinded);
    
    [[NSUserDefaults standardUserDefaults] setObject:_isBindWB forKey:KEY_USER_IS_REPORT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(BOOL)WXisBinded
{
    if (nil == _isBindWX) {
        _isBindWX = [[NSUserDefaults standardUserDefaults] objectForKey:KEY_USER_IS_BINDQQ];
    }
    return [_isBindWX boolValue];
}

-(void)setWXisBinded:(BOOL)WXisBinded
{
    _isBindWX = @(WXisBinded);
    
    [[NSUserDefaults standardUserDefaults] setObject:_isBindWX forKey:KEY_USER_IS_REPORT];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark - func


+ (void)registUAForWebView {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        UIWebView *webView = [[UIWebView alloc] init];
        
        NSString *oldUA = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
        
        NSString *newUA = [NSString stringWithFormat:
                           @" APP_PLATFORM/iOS APP_VERSION_CODE/%@ APP_DEVICE_ID/%@ APP_NAME/WhaleyVR APP_VERSION/%@ SYSTEM_VERSION/%@ whaleyvrapp",
                           kBuildVersion,
                           [WVRUserModel sharedInstance].deviceId,
                           kAppVersion,
                           [[UIDevice currentDevice] systemVersion]];
        
        // regist the new agent
        NSString *newAgent = [oldUA stringByAppendingString:newUA];
        
        NSDictionary *dictionary = @{ @"UserAgent" : newAgent };
        
        [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
        
        NSLog(@"new agent :%@", newAgent);
    });
}


+ (NSString *)kWhaleyAccountBaseURL {
    
    return kAPI_WHALEY_ACCOUNT_BASE_URL;
}

+ (NSString *)kNewVRBaseURL {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return kAPI_NEW_VR_BASE_URL_TEST;
    }
#endif
    return kAPI_NEW_VR_BASE_URL_ONLINE;
}

+ (NSString *)kAPI_VERSION {
    
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSString * curVersion = [version stringByReplacingOccurrencesOfString:@"_debug" withString:@""];
    return [NSString stringWithFormat:@"%@", curVersion.length > 0 ? curVersion : @""];
}

+ (NSString *)kStoreBaseURL {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return kAPI_STORE_BASE_URL_TEST;
    }
#endif
    return kAPI_STORE_BASE_URL_ONLINE;
}

+ (NSString *)kBIBaseURL {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return kAPI_WHALEY_BI_BASE_URL_TEST;
    }
#endif
    return kAPI_WHALEY_BI_BASE_URL_ONLINE;
}

+ (NSString *)biBaseURLForTest:(BOOL)test {
    if (test) {
        return kAPI_WHALEY_BI_BASE_URL_TEST;
    }
    return kAPI_WHALEY_BI_BASE_URL_ONLINE;
}

+ (NSString *)kBusBaseURL {
    
    return kAPI_WHALEY_BUS_BASE_URL;
}

+ (NSString *)kSnailvrBaseURL {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return kAPI_SNAILVR_BASE_URL_TEST;
    }
#endif
    return kAPI_SNAILVR_BASE_URL_ONLINE;
}

+ (NSString *)CMCHistory_sign_secret {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return TEST_USER_HISTORY_SIGN_SECRET;
    }
#endif
    return USER_HISTORY_SIGN_SECRET;
}

+ (NSString *)CMCPURCHASE_sign_secret {
    
#if (kAppEnvironmentTest == 1)
    if ([WVRUserModel sharedInstance].isTest) {
        return TEST_USER_PURCHASE_SIGN_SECRET;
    }
#endif
    return USER_PURCHASE_SIGN_SECRET;
}

+ (NSString *)aboutUsShareLink {
    
#if (kAppEnvironmentTest == 1)
    if ([[WVRUserModel sharedInstance] isTest]) {
        return @"http://minisite.test.snailvr.com/app-about-h5/";
    }
#endif
    return @"http://minisite-c.snailvr.com/app-about-h5/";
}

+ (NSString *)hybridWebParams {
    
    NSDictionary *dict = @{
                           @"STORE" : [WVRUserModel kStoreBaseURL],
                           @"WHALEY_ACCOUNT" : [WVRUserModel kWhaleyAccountBaseURL],
                           @"VR_API_AGINOMOTO" : [NSString stringWithFormat:@"%@%@", [WVRUserModel kNewVRBaseURL], kAPI_SERVICE],
                           @"BUS_AGINOMOTO" : [WVRUserModel kBusBaseURL],
                           @"BI" : [WVRUserModel kBIBaseURL],
                           };
    
    NSString *api = [NSString stringWithFormat:@"api=%@", [dict toJsonString]];
    
    int scale = [UIScreen mainScreen].scale;
    NSNumber *height = [NSNumber numberWithInt:20*scale];
    
    NSString *statu = [NSString stringWithFormat:@"statusBarHeight=%@", height];
    NSString *finalStr = [NSString stringWithFormat:@"%@&%@", api ,statu];;
    
    return [finalStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
}

@end
