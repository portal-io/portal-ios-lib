//
//  WVRRequestGenerator.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRSessionProtocol.h"

@interface WVRRequestGenerator : NSObject
+ (instancetype)sharedInstance;

@property (nonatomic, weak) id<WVRSessionProtocol> sessionDelegate;

/**
 GET请求
 
 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

/**
 POST请求 Form表单提交

 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

/**
 PUT请求
 
 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

/**
 Delete请求
 
 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

/**
 POST请求 Form表单格式 数据体为JSON 对应广来接口
 
 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generatePOSTJSONRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

/**
 POST请求 Form表单提交 雒亮接口
 
 @param serviceIdentifier serviceIdentifier
 @param requestParams Params
 @param methodName methodName
 @return NSURLRequest Object
 */
- (NSURLRequest *)generatePOSTFormRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;

- (NSURLRequest *)generatePOSTFILERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName;
@end
