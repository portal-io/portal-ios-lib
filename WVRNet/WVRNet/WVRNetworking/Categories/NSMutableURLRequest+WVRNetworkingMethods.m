//
//  NSMutableURLRequest+WVRNetworkingMethods.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "NSMutableURLRequest+WVRNetworkingMethods.h"
#import <objc/runtime.h>

static void *WVRNetworkingRequestParams;

@implementation NSMutableURLRequest (WVRNetworkingMethods)
- (void)setRequestParams:(NSDictionary *)requestParams
{
    objc_setAssociatedObject(self, &WVRNetworkingRequestParams, requestParams, OBJC_ASSOCIATION_COPY);
}

- (NSDictionary *)requestParams
{
    return objc_getAssociatedObject(self, &WVRNetworkingRequestParams);
}

@end
