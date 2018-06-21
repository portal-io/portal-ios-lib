//
//  WVRNetworkingService.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WVRNetworkingService;

@protocol WVRNetworkingServiceProtocol <NSObject>

typedef NS_ENUM(NSUInteger, WVRNetworkingEnv)
{
    WVRNetworkingEnvDev,
    WVRNetworkingEnvTest,
    WVRNetworkingEnvProduct
};

@property (nonatomic, readonly) NSString *devApiBaseUrl;
@property (nonatomic, readonly) NSString *testApiBaseUrl;
@property (nonatomic, readonly) NSString *productApiBaseUrl;

@optional
@property (nonatomic, readonly) NSString *devApiVersion;
@property (nonatomic, readonly) NSString *testApiVersion;
@property (nonatomic, readonly) NSString *productApiVersion;

@end

@interface WVRNetworkingService : NSObject
@property (nonatomic, strong, readonly) NSString *apiBaseUrl;
@property (nonatomic, strong, readonly) NSString *apiVersion;
@property (nonatomic, assign) WVRNetworkingEnv env;

@property (nonatomic, weak) id<WVRNetworkingServiceProtocol> customService;

@end
