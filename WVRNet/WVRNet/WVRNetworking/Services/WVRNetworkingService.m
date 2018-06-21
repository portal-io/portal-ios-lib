//
//  WVRNetworkingService.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRNetworkingService.h"
#import "WVRNetworkingServiceFactory.h"

@implementation WVRNetworkingService

- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(WVRNetworkingServiceProtocol)]) {
            self.customService = (id<WVRNetworkingServiceProtocol>)self;
        }
    }
    return self;
}

#pragma mark - getters and setters
- (WVRNetworkingEnv) env
{
    return WVRNetworkingEnvProduct;
}

- (NSString *)apiBaseUrl
{
    NSString *url = @"";
    switch (self.env) {
        case WVRNetworkingEnvDev:
            url = self.customService.devApiBaseUrl;
            break;
        case WVRNetworkingEnvTest:
            url = self.customService.testApiBaseUrl;
            break;
        case WVRNetworkingEnvProduct:
            url = self.customService.productApiBaseUrl;
            break;
        default:
            NSAssert(false, @"Unknow networking environment");
            break;
    }
    return url;
}

- (NSString *)apiVersion
{
    NSString *version = @"";
    switch (self.env) {
        case WVRNetworkingEnvDev:
            version = self.customService.devApiVersion;
            break;
        case WVRNetworkingEnvTest:
            version = self.customService.testApiVersion;
            break;
        case WVRNetworkingEnvProduct:
            version = self.customService.productApiVersion;
            break;
        default:
            NSAssert(false, @"Unknow networking environment");
            break;
    }
    return version;
}

@end
