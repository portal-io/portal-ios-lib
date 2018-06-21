//
//  WVRApiProxy.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingResponse.h"

typedef void(^AXCallback)(WVRNetworkingResponse *response);

@interface WVRApiProxy : NSObject

+ (instancetype)sharedInstance;

/**
 GET请求

 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callGETWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

/**
 POST请求 Form表单提交
 
 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callPOSTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

/**
 POST请求 Form表单格式 数据体为JSON 对应广来接口
 
 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callPOSTJSONWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

/**
 POST请求 Form表单提交 雒亮接口
 
 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callPOSTFormWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

- (NSInteger)callPOSTFILEWithParams:(NSDictionary *)params  serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;
/**
 PUT请求
 
 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callPUTWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

/**
 Delete请求
 
 @param params requestParams
 @param servieIdentifier servieIdentifier
 @param methodName methodName
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSInteger)callDELETEWithParams:(NSDictionary *)params serviceIdentifier:(NSString *)servieIdentifier methodName:(NSString *)methodName success:(AXCallback)success fail:(AXCallback)fail;

/**
 通用请求

 @param request 自定义NSURLRequest
 @param success success block
 @param fail fail block
 @return RequestID
 */
- (NSNumber *)callApiWithRequest:(NSURLRequest *)request success:(AXCallback)success fail:(AXCallback)fail;

/**
 取消请求

 @param requestID 请求对应的requestID
 */
- (void)cancelRequestWithRequestID:(NSNumber *)requestID;

/**
 批量取消请求

 @param requestIDList 请求对应的requestID数组
 */
- (void)cancelRequestWithRequestIDList:(NSArray<NSNumber *> *)requestIDList;

/**
 显示状态栏网络请求标识
 */
- (void)startMonitoring;

/**
 当前网络状态

 @return 是否有网络连接
 */
- (BOOL)isReachable;

@end
