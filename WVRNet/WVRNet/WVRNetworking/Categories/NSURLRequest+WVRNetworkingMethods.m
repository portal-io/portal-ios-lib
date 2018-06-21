//
//  NSURLRequest+WVRNetworkingRequestParam.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "NSURLRequest+WVRNetworkingMethods.h"
#import <objc/runtime.h>

static void *WVRNetworkingRequestParams;

@implementation NSURLRequest (WVRNetworkingMethods)

- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &WVRNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &WVRNetworkingRequestParams);
}

@end
