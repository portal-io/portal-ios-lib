//
//  WVRAppContext.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/17.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRAppContext.h"

@interface WVRAppContext () {
    
    CGSize _resolution;
}

@property (nonatomic, copy, readwrite) NSString *accessToken;
@property (nonatomic, copy, readwrite) NSString *refreshToken;
@property (nonatomic, assign, readwrite) NSTimeInterval lastRefreshTime;
@property (nonatomic, copy, readwrite) NSString *sessionId; // 每次启动App时都会新生成,用于日志标记

@end


@implementation WVRAppContext
@synthesize userInfo = _userInfo;
@synthesize userID = _userID;

#pragma mark - public methods
+ (instancetype)sharedInstance {
    
    static WVRAppContext *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WVRAppContext alloc] init];
    });
    return sharedInstance;
}

//获取当前屏幕显示的viewcontroller
+(UIViewController *)curViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}
#pragma mark - public methods
- (void)updateAccessToken:(NSString *)accessToken refreshToken:(NSString *)refreshToken {
    
    self.accessToken = accessToken;
    self.refreshToken = refreshToken;
    self.lastRefreshTime = [[NSDate date] timeIntervalSince1970] * 1000;
    
    [[NSUserDefaults standardUserDefaults] setObject:accessToken forKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)cleanUserInfo {
    
    self.accessToken = nil;
    self.refreshToken = nil;
    self.userInfo = nil;
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"accessToken"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"refreshToken"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - getters and setters
- (void)setUserID:(NSString *)userID {
    
    _userID = [userID copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userID forKey:@"userId"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString *)userID {
    
    if (_userID == nil) {
        _userID = [[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    }
    return _userID;
}

- (void)setUserInfo:(NSDictionary *)userInfo {
    
    _userInfo = [userInfo copy];
    [[NSUserDefaults standardUserDefaults] setObject:_userInfo forKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSDictionary *)userInfo {
    
    if (_userInfo == nil) {
        _userInfo = [[NSUserDefaults standardUserDefaults] objectForKey:@"userInfo"];
    }
    return _userInfo;
}

- (void)setUserHasFollowings:(BOOL)userHasFollowings {
    
    [[NSUserDefaults standardUserDefaults] setBool:userHasFollowings forKey:@"userHasFollowings"];
}

- (BOOL)userHasFollowings {
    
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"userHasFollowings"];
}

- (NSString *)accessToken {
    
    if (_accessToken == nil) {
        _accessToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"accessToken"];
    }
    return _accessToken;
}

- (NSString *)refreshToken {
    
    if (_refreshToken == nil) {
        _refreshToken = [[NSUserDefaults standardUserDefaults] stringForKey:@"refreshToken"];
    }
    return _refreshToken;
}

- (NSString *)type {
    
    return @"ios";
}

- (NSString *)model {
    
    return [[UIDevice currentDevice] name];
}

- (NSString *)os {
    
    return [[UIDevice currentDevice] systemVersion];
}

- (NSString *)rom {
    
    return [[UIDevice currentDevice] model];
}

- (NSString *)imei {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)imsi {
    
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (NSString *)deviceName {
    
    return [[UIDevice currentDevice] name];
}

- (NSString *)ppi {
    
    NSString *ppi = @"";
    if ([self.deviceName isEqualToString:@"iPod1,1"] ||
        [self.deviceName isEqualToString:@"iPod2,1"] ||
        [self.deviceName isEqualToString:@"iPod3,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,1"] ||
        [self.deviceName isEqualToString:@"iPhone1,2"] ||
        [self.deviceName isEqualToString:@"iPhone2,1"]) {
        
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPod4,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,1"] ||
             [self.deviceName isEqualToString:@"iPhone3,3"] ||
             [self.deviceName isEqualToString:@"iPhone4,1"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone5,1"] ||
             [self.deviceName isEqualToString:@"iPhone5,2"] ||
             [self.deviceName isEqualToString:@"iPhone5,3"] ||
             [self.deviceName isEqualToString:@"iPhone5,4"] ||
             [self.deviceName isEqualToString:@"iPhone6,1"] ||
             [self.deviceName isEqualToString:@"iPhone6,2"]) {
        
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,1"]) {
        ppi = @"401";
    }
    else if ([self.deviceName isEqualToString:@"iPhone7,2"]) {
        ppi = @"326";
    }
    else if ([self.deviceName isEqualToString:@"iPad1,1"] ||
             [self.deviceName isEqualToString:@"iPad2,1"]) {
        ppi = @"132";
    }
    else if ([self.deviceName isEqualToString:@"iPad3,1"] ||
             [self.deviceName isEqualToString:@"iPad3,4"] ||
             [self.deviceName isEqualToString:@"iPad4,1"] ||
             [self.deviceName isEqualToString:@"iPad4,2"]) {
        ppi = @"264";
    }
    else if ([self.deviceName isEqualToString:@"iPad2,5"]) {
        ppi = @"163";
    }
    else if ([self.deviceName isEqualToString:@"iPad4,4"] ||
             [self.deviceName isEqualToString:@"iPad4,5"]) {
        ppi = @"326";
    }
    else {
        ppi = @"264";
    }
    return ppi;
}

- (CGSize)resolution {
    
    if (_resolution.width == 0) {
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        float width = MIN(size.height, size.width);
        
        float heiht = MAX(size.height, size.width);
        
        _resolution = CGSizeMake(width, heiht);
    }
    
    return _resolution;
}

- (NSString *)appVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

- (NSString *)buildVersion {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (CGFloat)latitude {
    
    return 0;
}

- (CGFloat)longitude {
    
    return 0;
}

- (void)appStarted {
    
    self.sessionId = [[NSUUID UUID].UUIDString copy];
}

- (void)appEnded {
    

}

- (BOOL)isLoggedIn {
    
    BOOL result = (self.userID.length != 0);
    return result;
}

//- (BOOL)isOnline {
//    
//    BOOL isOnline = NO;
//    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"WVRNetworkingConfiguration" ofType:@"plist"];
//    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
//        NSDictionary *settings = [[NSDictionary alloc] initWithContentsOfFile:filepath];
//        isOnline = [settings[@"isOnline"] boolValue];
//    } else {
//        isOnline = kWVRServiceIsOnline;
//    }
//    return isOnline;
//}

- (NSString *)deviceToken {
    
    if (_deviceToken == nil) {
        _deviceToken = @"";
    }
    return _deviceToken;
}

- (NSData *)deviceTokenData {
    
    if (_deviceTokenData == nil) {
        _deviceTokenData = [NSData data];
    }
    return _deviceTokenData;
}

//UIInterfaceOrientationMaskPortrait = (1 << UIInterfaceOrientationPortrait),
//UIInterfaceOrientationMaskLandscapeLeft = (1 << UIInterfaceOrientationLandscapeLeft),
//UIInterfaceOrientationMaskLandscapeRight = (1 << UIInterfaceOrientationLandscapeRight),
//UIInterfaceOrientationMaskPortraitUpsideDown = (1 << UIInterfaceOrientationPortraitUpsideDown),
//UIInterfaceOrientationMaskLandscape = (UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
//UIInterfaceOrientationMaskAll = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskPortraitUpsideDown),
//UIInterfaceOrientationMaskAllButUpsideDown = (UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight),
-(UIInterfaceOrientation)gPreferredInterfaceO
{
    switch (self.gSupportedInterfaceO) {
        case UIInterfaceOrientationMaskPortrait:
            return UIInterfaceOrientationPortrait;
            break;
        case UIInterfaceOrientationMaskLandscapeLeft:
            return UIInterfaceOrientationLandscapeLeft;
            break;
        case UIInterfaceOrientationMaskLandscapeRight:
            return UIInterfaceOrientationLandscapeRight;
            break;
        case UIInterfaceOrientationMaskPortraitUpsideDown:
            return UIInterfaceOrientationPortraitUpsideDown;
            break;
        default:
            return UIInterfaceOrientationUnknown;
            break;
    }
}
@end
