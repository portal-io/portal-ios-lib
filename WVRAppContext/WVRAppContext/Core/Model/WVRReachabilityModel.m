//
//  WVRReachabilityModel.m
//  VRManager
//
//  Created by Snailvr on 16/7/6.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRReachabilityModel.h"
#import "Reachability.h"
#import "WVRNotificationHeader.h"

@interface WVRReachabilityModel()

@property (nonatomic, assign) NetworkStatus lastNetStatus;      // 网络状态变更前的网络状态
@property (nonatomic, assign) NetworkStatus currentNetStatus;   // 当前网络状态

@property (nonatomic, strong) Reachability *internetReachability;

@end


@implementation WVRReachabilityModel
@synthesize currentNetStatus = _currentNetStatus;

static WVRReachabilityModel *_sharedNetwork = nil;

#pragma mark - initialize

+ (instancetype)sharedInstance {
    
    static dispatch_once_t onceToken;
    
    dispatch_once (&onceToken, ^{
        _sharedNetwork = [[WVRReachabilityModel alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:_sharedNetwork selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        _sharedNetwork.internetReachability = [Reachability reachabilityForInternetConnection];
        [_sharedNetwork.internetReachability startNotifier];
    });
    
    return _sharedNetwork;
}

// 初始化网络监测
+ (void)setupReachability {
    
    [_sharedNetwork updateInterfaceWithReachability:_sharedNetwork.internetReachability];
}

- (void)reachabilityChanged:(NSNotification *)note {
    
    Reachability* curReach = [note object];
//    BOOL result = [curReach isKindOfClass:[Reachability class]];
//    NSParameterAssert(result);
    [self updateInterfaceWithReachability:curReach];
}

- (void)updateInterfaceWithReachability:(Reachability *)reachability {
    
    self.currentNetStatus = [reachability currentReachabilityStatus];
}

#pragma mark - setter getter

- (void)setCurrentNetStatus:(NetworkStatus)currentNetStatus {
    
    _lastNetStatus = _currentNetStatus;
    _currentNetStatus = currentNetStatus;
    
    if (_lastNetStatus != currentNetStatus) {
        [[self class] postNotificationForNetStatus:currentNetStatus];
    }
}

- (BOOL)isWifi {
    
    return _currentNetStatus == ReachableViaWiFi;
}

- (BOOL)isReachNet {
    
    return _currentNetStatus == ReachableViaWWAN;
}

- (BOOL)isNoNet {
    
    return _currentNetStatus == NotReachable;
}

#pragma mark - action

static bool _shouldPostNoNetNotification = false;

void postNoNetNotification() {
    if (_shouldPostNoNetNotification) {
        NSLog(@"WVRReachabilityModel 网络断开");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNoNetNotification object:nil];
        NSLog(@"WVRReachabilityModel 网络状态发生变化");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetStatusChagedNoti object:nil];
    }
}

+ (void)postNotificationForNetStatus:(NetworkStatus)status {
    
    WVRReachabilityModel *model = [WVRReachabilityModel sharedInstance];
    
    if (status == NotReachable) {
        _shouldPostNoNetNotification = true;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            postNoNetNotification();
        });
        
    } else {
        _shouldPostNoNetNotification = false;
        if (model.lastNetStatus == NotReachable) {
            NSLog(@"WVRReachabilityModel 无网变有网");
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetReachableNotification object:nil];
        }
        if (status == ReachableViaWWAN) {
            NSLog(@"WVRReachabilityModel 变为移动网络");
            [[NSNotificationCenter defaultCenter] postNotificationName:kNetReachNotification object:nil];
        }
        NSLog(@"WVRReachabilityModel 网络状态发生变化");
        [[NSNotificationCenter defaultCenter] postNotificationName:kNetStatusChagedNoti object:nil];
    }
}

#pragma mark - 网络可用状态判断

+ (BOOL)isNetWorkOK {
    
    WVRReachabilityModel *model = [[self class] sharedInstance];
    
    return model.currentNetStatus != NotReachable;
}

- (NSString *)netWorkStatusString {
    
    switch (self.currentNetStatus) {
        case NotReachable:
            return @"";
        case ReachableViaWWAN:
            return @"rech";
        case ReachableViaWiFi:
            return @"wifi";
    }
    return @"";
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
