//
//  WVRNetworkingLogger.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/23.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingService.h"
#import "WVRNetworkingResponse.h"

@interface WVRNetworkingLogger : NSObject

+ (void)logDebugInfoWithRequest:(NSURLRequest *)request apiName:(NSString *)apiName service:(WVRNetworkingService *)service requestParams:(id)requestParams httpMethod:(NSString *)httpMethod;
+ (void)logDebugInfoWithResponse:(NSHTTPURLResponse *)response responseString:(NSString *)responseString request:(NSURLRequest *)request error:(NSError *)error;
+ (void)logDebugInfoWithCachedResponse:(WVRNetworkingResponse *)response methodName:(NSString *)methodName serviceIdentifier:(WVRNetworkingService *)service;

+ (instancetype)sharedInstance;

@end
