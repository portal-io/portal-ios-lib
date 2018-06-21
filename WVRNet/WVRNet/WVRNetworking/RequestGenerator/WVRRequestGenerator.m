//
//  WVRRequestGenerator.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRRequestGenerator.h"
#import <AFNetworking/AFNetworking.h>
#import "WVRNetworkingService.h"
#import "WVRNetworkingServiceFactory.h"
#import "NSMutableURLRequest+WVRNetworkingMethods.h"
#import "WVRNetworkingConfig.h"
#import "WVRAPIBaseManager.h"

@interface WVRRequestGenerator ()

@property (nonatomic, strong) AFHTTPRequestSerializer *httpRequestSerializer;

@end

@implementation WVRRequestGenerator

#pragma mark - public methods
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static WVRRequestGenerator *sharedInstance = nil;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[WVRRequestGenerator alloc] init];
    });
    return sharedInstance;
}

-(void)checkValide
{
    if (self.sessionDelegate) {
//        return YES;
    }else{
        NSAssert(YES, @"sessionDelegate must not nil");
//        return NO;
    }
}

- (NSURLRequest *)generateGETRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    [self checkValide];
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    NSMutableDictionary *paramsWithCommon = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [paramsWithCommon addEntriesFromDictionary:[self.sessionDelegate getCommonParams]];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"GET" URLString:urlString parameters:paramsWithCommon error:NULL];
    request.requestParams = requestParams;
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    return request;
}

- (NSURLRequest *)generatePOSTRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    [self checkValide];
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    [self.httpRequestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary *paramsWithCommon = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [paramsWithCommon addEntriesFromDictionary:[self.sessionDelegate getCommonParams]];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:paramsWithCommon error:NULL];
//    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePOSTJSONRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    [self.httpRequestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSDictionary *commonParams = [WVRApiCommonParamGenerator commonParamsDictionary];
    NSMutableDictionary *paramsWithCommon = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [paramsWithCommon addEntriesFromDictionary:[self.sessionDelegate getCommonParams]];
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"POST" URLString:urlString parameters:paramsWithCommon error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}


- (NSURLRequest *)generatePOSTFILERequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    [self checkValide];
    
    NSData * fileData = requestParams[kBSFileUploadParams_formData];
    NSString * keyName = requestParams[kBSFileUploadParams_keyName];
    NSString * fileName = requestParams[kBSFileUploadParams_fileName];
    NSMutableDictionary * cur = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [cur removeObjectForKey:kBSFileUploadParams_fileName];
    [cur removeObjectForKey:kBSFileUploadParams_keyName];
    [cur removeObjectForKey:kBSFileUploadParams_formData];
    requestParams = [NSDictionary dictionaryWithDictionary:cur];
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    [self.httpRequestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    NSMutableDictionary *paramsWithCommon = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [paramsWithCommon addEntriesFromDictionary:[self.sessionDelegate getCommonParams]];
    NSMutableURLRequest *request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:paramsWithCommon constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:keyName fileName:fileName mimeType:@"*/*"];
    } error:NULL];
    
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePOSTFormRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName {
    
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    [self.httpRequestSerializer setValue:@"multipart/form-data;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//    NSDictionary *commonParams = [WVRApiCommonParamGenerator commonParamsDictionary];
    NSMutableDictionary *paramsWithCommon = [NSMutableDictionary dictionaryWithDictionary:requestParams];
    [paramsWithCommon addEntriesFromDictionary:[self.sessionDelegate getCommonParams]];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer multipartFormRequestWithMethod:@"POST" URLString:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (NSString *key in paramsWithCommon.allKeys) {
            [formData appendPartWithFormData:[paramsWithCommon[key] dataUsingEncoding:NSUTF8StringEncoding] name:key];
        }
        
    } error:nil];
    
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generatePutRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    [self checkValide];
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"PUT" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}

- (NSURLRequest *)generateDeleteRequestWithServiceIdentifier:(NSString *)serviceIdentifier requestParams:(NSDictionary *)requestParams methodName:(NSString *)methodName
{
    [self checkValide];
    WVRNetworkingService *service = [[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier];
    NSString *urlString;
    if (service.apiVersion.length != 0) {
        urlString = [NSString stringWithFormat:@"%@/%@/%@", service.apiBaseUrl, methodName, service.apiVersion];
    } else {
        urlString = [NSString stringWithFormat:@"%@/%@", service.apiBaseUrl, methodName];
    }
    
    [self.httpRequestSerializer setValue:[[NSUUID UUID] UUIDString] forHTTPHeaderField:@"UUID"];
    
    NSMutableURLRequest *request = [self.httpRequestSerializer requestWithMethod:@"DELETE" URLString:urlString parameters:requestParams error:NULL];
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:requestParams options:0 error:NULL];
    if ([self.sessionDelegate getAccessToken]) {
        [request setValue:[self.sessionDelegate getAccessToken] forHTTPHeaderField:@"AccessToken"];
    }
    request.requestParams = requestParams;
    return request;
}

#pragma mark - getters and setters

- (AFHTTPRequestSerializer *)httpRequestSerializer
{
    if (_httpRequestSerializer == nil) {
        _httpRequestSerializer = [AFHTTPRequestSerializer serializer];
        _httpRequestSerializer.timeoutInterval = kWVRNetworkingTimeoutSeconds;
        _httpRequestSerializer.cachePolicy = NSURLRequestUseProtocolCachePolicy;
    }
    return _httpRequestSerializer;
}

@end
