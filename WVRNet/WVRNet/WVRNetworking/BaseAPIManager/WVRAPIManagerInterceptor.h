//
//  WVRAPIManagerInterceptor.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/22.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingResponse.h"

@protocol WVRAPIManagerInterceptor <NSObject>
@optional
- (BOOL)beforePerformSuccessWithResponse:(WVRNetworkingResponse *)response;
- (void)afterPerformSuccessWithResponse:(WVRNetworkingResponse *)response;

- (BOOL)beforePerformFailWithResponse:(WVRNetworkingResponse *)response;
- (void)afterPerformFailWithResponse:(WVRNetworkingResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;
@end
