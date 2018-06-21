//
//  WVRBaseRequest.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kHttpParams_storapi_timestamp ;

@interface WVRBaseRequest : NSObject

@property (nonatomic, strong) NSDictionary *bodyParams;

- (NSString *)getActionUrl;
- (NSString *)getHost;
- (NSString *)signParamsMD5;

@end
