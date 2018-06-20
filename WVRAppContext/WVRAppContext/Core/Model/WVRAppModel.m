//
//  WVRAppModel.m
//  VRManager
//
//  Created by apple on 16/6/14.
//  Copyright © 2016年 Snailvr. All rights reserved.

// 应用基本数据 单例

#import "WVRAppModel.h"
#include <arpa/inet.h>
#include <net/if.h>
#include <ifaddrs.h>
#include <net/if_dl.h>
#import "WVRAppDebugDefine.h"
#import "WVRAppFrameDefine.h"
#import "WVRDeviceModel.h"

@interface WVRAppModel() {
    
    float _normalItemWidth;
    float _normalItemHeight;
    float _movieItemWidth;
    float _movieItemHeight;
    float _recommendCellHeight;
    
    NSDictionary *_commenParams;
    NSMutableDictionary *_liveTrailDict;
    
    long _iBytes;
    long _oBytes;

    long _inSpeed;
    long _outSpeed;
    
    NSNumber *_footballCameraTipIsShow;
}

@end


@implementation WVRAppModel

@synthesize widthFit = _widthFit;
@synthesize ipAdress = _ipAdress;

// TODO: 这里的变量都是覆写了get方法，为了确保调用到正确的值，请使用get方法获取而非下划线变量

+ (instancetype)sharedInstance {
    static WVRAppModel *_sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        _sharedInstance = [[WVRAppModel alloc] init];
    });
    
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        float normal_screen_width = NORMAL_SCREEN_WIDTH;
        CGRect screenBounds = [[UIScreen mainScreen] bounds];
        float height = CGRectGetHeight(screenBounds);
        float width = CGRectGetWidth(screenBounds);
        
        float finalWidth = MIN(width, height);
        
        _widthFit = (finalWidth / normal_screen_width);
    }
    return self;
}

//+ (void)logReport:(NSString *)msg {
//    
//    if ([WVRUserModel sharedInstance].isTest) {
//        [[[UIAlertView alloc] initWithTitle:@"日志" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
//    }
//    
////    if ([WVRUserModel sharedInstance].isTest) {
////        
////        NSString *url = @"http://172.29.3.16:8181/logs";
////        [WVRRequestClient POSTService:url withParams:@{ @"log": msg } completionBlock:^(id responseObj, NSError *error) {}];
////    }
//}

#pragma mark - data

- (NSDictionary *)commenParams {
    
    if (_commenParams == nil) {
        
        NSString *buildVersion = kAppVersion;
        NSString *systemVersion = [[UIDevice currentDevice] systemVersion];
        NSString *version = kAppVersion;
        
        NSString *appverCode = [[buildVersion componentsSeparatedByString:@"_"] firstObject];
        
        _commenParams = @{ @"systemname": @"ios", @"appname": @"WhaleyVR", @"appver": version, @"systemver": systemVersion, @"appvercode": appverCode };
    }
    
    return _commenParams;
}

// 混淆
#define kLiveTrailDictFileName @"C8411684CD"

- (NSMutableDictionary *)liveTrailDict {
    
    if (!_liveTrailDict) {
        
        NSString *str = [NSString stringWithFormat:@"/Documents/%@", kLiveTrailDictFileName];
        NSString *path = [NSHomeDirectory() stringByAppendingString:str];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            _liveTrailDict = [NSMutableDictionary dictionary];
            return _liveTrailDict;
        }
        
        NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        NSDate *time = [fattributes objectForKey:NSFileModificationDate];
        
        if ([[NSDate date] timeIntervalSinceDate:time] > 24 * 60 * 60) {
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            _liveTrailDict = [NSMutableDictionary dictionary];
            return _liveTrailDict;
        }
        
        NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        _liveTrailDict = [NSMutableDictionary dictionaryWithDictionary:dict];
    }
    return _liveTrailDict;
}

- (void)saveLiveTrailDict {
    
    // debug模式下，重启应用即可重新试看
#if (kAppEnvironmentTest == 0)
    
    NSString *str = [NSString stringWithFormat:@"/Documents/%@", kLiveTrailDictFileName];
    NSString *path = [NSHomeDirectory() stringByAppendingString:str];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [NSKeyedArchiver archiveRootObject:_liveTrailDict toFile:path];
    });
#endif
}

- (void)setFootballCameraTipIsShow:(BOOL)footballCameraTipIsShow {
    _footballCameraTipIsShow = @(footballCameraTipIsShow);
    
    [[NSUserDefaults standardUserDefaults] setObject:_footballCameraTipIsShow forKey:@"_footballCameraTipIsShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (BOOL)footballCameraTipIsShow {
    
    if (!_footballCameraTipIsShow) {
        _footballCameraTipIsShow = [[NSUserDefaults standardUserDefaults] objectForKey:@"_footballCameraTipIsShow"];
    }
    return [_footballCameraTipIsShow boolValue];
}

#pragma mark - UI helper

+ (void)forceToOrientation:(UIInterfaceOrientation)orientation {
    
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        
        SEL selector = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
        [invocation setSelector:selector];
        [invocation setTarget:[UIDevice currentDevice]];
        int val = orientation;
        [invocation setArgument:&val atIndex:2];
        [invocation invoke];
    }
}

+ (void)changeStatusBarOrientation:(UIInterfaceOrientation)orientation {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation];
#pragma clang diagnostic pop
}

+ (void)changeStatusBarOrientation:(UIInterfaceOrientation)orientation animated:(BOOL)animate {
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[UIApplication sharedApplication] setStatusBarOrientation:orientation animated:animate];
#pragma clang diagnostic pop
}

#pragma mark - Length 

- (float)normalItemWidth {
    if (0 == _normalItemWidth) {
        _normalItemWidth = (SCREEN_WIDTH - 2*kItemDistance - kListCellDistance)/2.f;    // floorf()
    }
    return _normalItemWidth;
}

- (float)normalItemHeight {
    if (0 == _normalItemHeight) {
        _normalItemHeight = floorf([[WVRAppModel sharedInstance] normalItemWidth]/7.0 * 4) + kCellLogoHeight;
    }
    return _normalItemHeight;
}

- (float)movieItemWidth {
    if (0 == _movieItemWidth) {
        _movieItemWidth = (SCREEN_WIDTH - 2*kItemDistance - 2*kListCellDistance)/3.f;
    }
    return _movieItemWidth;
}

- (float)movieItemHeight {
    if (0 == _movieItemHeight) {        
        _movieItemHeight = floorf([[WVRAppModel sharedInstance] movieItemWidth]/248.f * 333) + kTitleHeight;
    }
    return _movieItemHeight;
}

- (float)recommendCellHeight {
    
    if (0 == _recommendCellHeight) {
        
        _recommendCellHeight = _widthFit * (211 + 67) + 6;
    }
    return _recommendCellHeight;
}

#pragma mark - Font

+ (float)fontSizeForPx:(float)px {
    
    float fitPx = px * [WVRAppModel sharedInstance].widthFit;
    fitPx = (roundf(fitPx * 10) / 10.f);
    
    return fitPx / 2.f;
}

// font字体适配
+ (UIFont *)fontFitForSize:(float)size {
    
    float fontSize = size * [WVRAppModel sharedInstance].widthFit;
    fontSize = (roundf(fontSize * 10) / 10.f);
    
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)boldFontFitForSize:(float)size {
    
    float fontSize = size * [WVRAppModel sharedInstance].widthFit;
    fontSize = (roundf(fontSize * 10) / 10.f);
    
    return [UIFont boldSystemFontOfSize:fontSize];
}

#pragma mark - request

//+ (void)uploadViewInfoWithCode:(NSString *)srcCode programType:(NSString *)programType videoType:(NSString *)videoType type:(NSString *)type sec:(NSString *)sec title:(NSString *)title {
//    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    
//    dict[@"srcCode"] = srcCode;
//    dict[@"programType"] = programType;
//    dict[@"videoType"] = videoType;
//    dict[@"type"] = type;
//    dict[@"sec"] = sec;
//    dict[@"title"] = title;
//    
//    NSString *url = [NSString stringWithFormat:@"%@%@%@", [WVRUserModel kNewVRBaseURL], kAPI_SERVICE, @"stat/updateBySrcCode"];
//    [WVRRequestClient POSTService:url withParams:dict completionBlock:^(id responseObj, NSError *error) {
//        
//        if (error) {
//            
//            DebugLog(@"%@", error.description);
//            
//        } else {
//            
//            NSDictionary *dict = responseObj;
//            DebugLog(@"%@: %@", dict[@"msg"], dict[@"code"]);
//        }
//    }];
//}


- (void)checkNetworkflow
{
    struct ifaddrs *ifa_list = 0, *ifa;
    if (getifaddrs(&ifa_list) == -1) { return ; }
    
    uint32_t iBytes     = 0;
    uint32_t oBytes     = 0;
    uint32_t allFlow    = 0;
    uint32_t wifiIBytes = 0;
    uint32_t wifiOBytes = 0;
    uint32_t wifiFlow   = 0;
    uint32_t wwanIBytes = 0;
    uint32_t wwanOBytes = 0;
    uint32_t wwanFlow   = 0;
    
    for (ifa = ifa_list; ifa; ifa = ifa->ifa_next)
    {
        if (AF_LINK != ifa->ifa_addr->sa_family)
            continue;
        
        if (!(ifa->ifa_flags & IFF_UP) && !(ifa->ifa_flags & IFF_RUNNING))
            continue;
        
        if (ifa->ifa_data == 0)
            continue;
        
        // network flow
        if (strncmp(ifa->ifa_name, "lo", 2))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
            allFlow = iBytes + oBytes;
        }
        
        //wifi flow
        if (!strcmp(ifa->ifa_name, "en0"))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            wifiIBytes += if_data->ifi_ibytes;
            wifiOBytes += if_data->ifi_obytes;
            wifiFlow    = wifiIBytes + wifiOBytes;
        }
        
        //3G and gprs flow
        if (!strcmp(ifa->ifa_name, "pdp_ip0"))
        {
            struct if_data *if_data = (struct if_data *)ifa->ifa_data;
            wwanIBytes += if_data->ifi_ibytes;
            wwanOBytes += if_data->ifi_obytes;
            wwanFlow    = wwanIBytes + wwanOBytes;
        }
    }
    freeifaddrs(ifa_list);
    
    _inSpeed = _iBytes ? (iBytes - _iBytes) : 0;
    _outSpeed = _oBytes ? (oBytes - _oBytes) : 0;
    
    _iBytes = iBytes;
    _oBytes = oBytes;
}

- (long)curDownSize {
    
    return _iBytes;
}

- (long)checkInNetworkflow {
    
    [self checkNetworkflow];
    return _inSpeed;
}

- (long)checkOutNetworkflow {
    
    [self checkNetworkflow];
    return _outSpeed;
}

- (NSString *)ipAdress {
    if (!_ipAdress) {
        _ipAdress = [WVRDeviceModel deviceIPAdress];;
    }
    return _ipAdress;
}

@end
