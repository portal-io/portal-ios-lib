//
//  WVRBaseAPIManager.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRAPIBaseManager.h"
#import "WVRNetworkingCache.h"
#import "WVRApiProxy.h"
#import "WVRNetworkingServiceFactory.h"
#import "WVRNetworkingLogger.h"

#define AXCallAPI(REQUEST_METHOD, REQUEST_ID)                                                   \
{                                                                                               \
    __strong typeof(self) strongSelf = self;  \
    REQUEST_ID = [[WVRApiProxy sharedInstance] call##REQUEST_METHOD##WithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(WVRNetworkingResponse *response) { \
        [strongSelf successedOnCallingAPI:response];                                            \
    } fail:^(WVRNetworkingResponse *response) {                                                        \
        [strongSelf failedOnCallingAPI:response];    \
    }];                                                                                         \
    [self.requestIdList addObject:@(REQUEST_ID)];                                               \
}

NSString * const kBSUserTokenInvalidNotification = @"kBSUserTokenInvalidNotification";
NSString * const kBSUserTokenIllegalNotification = @"kBSUserTokenIllegalNotification";
NSString * const kBSUserTokenNoPermissionNotification = @"kBSUserTokenNoPermissionNotification";

NSString * const kBSUserTokenNotificationUserInfoKeyRequestToContinue = @"kBSUserTokenNotificationUserInfoKeyRequestToContinue";
NSString * const kBSUserTokenNotificationUserInfoKeyManagerToContinue = @"kBSUserTokenNotificationUserInfoKeyManagerToContinue";

NSString * const kBSFileUploadParams_formData = @"formData";
NSString * const kBSFileUploadParams_keyName = @"keyName";
NSString * const kBSFileUploadParams_fileName = @"fileName";

@interface WVRAPIBaseManager ()

@property (nonatomic, strong, readwrite) id fetchedRawData;
@property (nonatomic, assign, readwrite) BOOL isLoading;
@property (nonatomic, assign) BOOL isNativeDataEmpty;

@property (nonatomic, copy, readwrite) NSString *errorMessage;
@property (nonatomic, readwrite) WVRAPIManagerErrorType errorType;
@property (nonatomic, strong) NSMutableArray *requestIdList;
@property (nonatomic, strong) WVRNetworkingCache *cache;

@end

@implementation WVRAPIBaseManager

#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        _delegate = nil;
        _validator = nil;
        _fetchedRawData = nil;
        _errorMessage = nil;
        _errorType = WVRAPIManagerErrorTypeDefault;
        
        if ([self conformsToProtocol:@protocol(WVRAPIManager)]) {
            self.child = (id <WVRAPIManager>)self;
        } else {
            NSException *exception = [[NSException alloc] init];
            @throw exception;
        }
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"");
    [self cancelAllRequests];
    self.requestIdList = nil;
}

#pragma mark - public methods
- (void)cancelAllRequests
{
    [[WVRApiProxy sharedInstance] cancelRequestWithRequestIDList:self.requestIdList];
    [self.requestIdList removeAllObjects];
}

- (void)cancelRequestWithRequestId:(NSInteger)requestID
{
    [self removeRequestIdWithRequestID:requestID];
    [[WVRApiProxy sharedInstance] cancelRequestWithRequestID:@(requestID)];
}

- (id)fetchDataWithReformer:(id<WVRAPIManagerDataReformer>)reformer
{
    id resultData = nil;
    if ([reformer respondsToSelector:@selector(reformData:)]) {
        resultData = [reformer reformData:self.fetchedRawData];
    } else {
        resultData = [self.fetchedRawData mutableCopy]; //Deep copy
    }
    return resultData;
}

#pragma mark - calling api

- (NSInteger)loadData
{
    NSDictionary *params = [self bodyParams];
    NSInteger requestId = [self loadDataWithParams:params];
    return requestId;
}

- (NSInteger)loadDataWithParams:(NSDictionary *)params
{
    NSInteger requestId = 0;
    NSDictionary *apiParams = [self reformParams:params];
    
    if (![self shouldCallAPIWithParams:apiParams]) {
        return requestId;
    }
    
    if (![self isCorrectWithParamsData:apiParams]) {
        [self failedOnCallingAPI:nil];
        return requestId;
    }

    if ([self.child shouldLoadFromNative]) {
        [self loadDataFromNative];
    }
    
    if ([self shouldCache] && [self hasCacheWithParams:apiParams]) {
        return requestId;
    }
    
    if (![self isReachable]) {
        [self failedOnCallingAPI:nil];
        return requestId;
    }
    
    requestId = [self requestWithParam:apiParams];
    return requestId;
}

- (NSInteger)requestWithParam:(NSDictionary *)apiParams {
    self.isLoading = YES;
    NSInteger requestId = 0;
    switch (self.child.requestType)
    {
        case WVRAPIManagerRequestTypeGet:
            AXCallAPI(GET, requestId);
//            [self testGetRequest:apiParams];
            break;
        case WVRAPIManagerRequestTypePost:
            AXCallAPI(POST, requestId);
            //            [self testRequest:apiParams];
            break;
        case WVRAPIManagerRequestTypePostJSON:
            AXCallAPI(POSTJSON, requestId);
            break;
        case WVRAPIManagerRequestTypePostFILE:
            AXCallAPI(POSTFILE, requestId);
            break;
        case WVRAPIManagerRequestTypePostForm:
            AXCallAPI(POSTForm, requestId);
            break;
        case WVRAPIManagerRequestTypePut:
            AXCallAPI(PUT, requestId);
            break;
        case WVRAPIManagerRequestTypeDelete:
            AXCallAPI(DELETE, requestId);
            break;
        default:
            NSAssert(false, @"Unknow request method");
            break;
    }
    NSMutableDictionary *params = [apiParams mutableCopy];
    params[kWVRAPIBaseManagerRequestID] = @(requestId);
    [self afterCallingAPIWithParams:params];
    return requestId;
}

// Debug instead define AXCallAPI, don't delete
- (void) testGetRequest:(NSDictionary *)apiParams {
    //    __weak typeof(self) weakSelf = self;
    __strong typeof(self) strongSelf = self;//这里必须是强引用
    NSInteger REQUEST_ID = [[WVRApiProxy sharedInstance] callGETWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(WVRNetworkingResponse *response) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf successedOnCallingAPI:response];
    } fail:^(WVRNetworkingResponse *response) {
        //        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf failedOnCallingAPI:response];
    }];
    [self.requestIdList addObject:@(REQUEST_ID)];
}

// Debug instead define AXCallAPI, don't delete
- (void) testRequest:(NSDictionary *)apiParams {
//    __weak typeof(self) weakSelf = self;
    __strong typeof(self) strongSelf = self;//这里必须是强引用
    NSInteger REQUEST_ID = [[WVRApiProxy sharedInstance] callPOSTWithParams:apiParams serviceIdentifier:self.child.serviceType methodName:self.child.methodName success:^(WVRNetworkingResponse *response) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf successedOnCallingAPI:response];
    } fail:^(WVRNetworkingResponse *response) {
//        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf failedOnCallingAPI:response];
    }];
    [self.requestIdList addObject:@(REQUEST_ID)];
}

#pragma mark - api callbacks
- (void)successedOnCallingAPI:(WVRNetworkingResponse *)response
{
    self.isLoading = NO;
    self.response = response;
    
    if ([self.child shouldLoadFromNative]) {
        if (response.isCache == NO) {
            [[NSUserDefaults standardUserDefaults] setObject:response.responseData forKey:[self.child methodName]];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
    if (response.content) {
        self.fetchedRawData = [response.content copy];
    } else {
        self.fetchedRawData = [response.responseData copy];
    }
    
    [self removeRequestIdWithRequestID:response.requestId];
    
    if (![self isCorrectWithCallBackData:response.content]) {
        response.errorType = WVRAPIManagerErrorTypeContentError;
        [self failedOnCallingAPI:response];
        return;
    }
    
    if ([self shouldCache] && !response.isCache) {
        [self.cache saveCacheWithData:response.responseData serviceIdentifier:self.child.serviceType methodName:self.child.methodName requestParams:response.requestParams];
    }
        
    if ([self beforePerformSuccessWithResponse:response]) {
        if ([self.child shouldLoadFromNative]) {
            if (response.isCache == YES) {
                [self.delegate managerCallAPIDidSuccess:response];
            }
            if (self.isNativeDataEmpty) {
                [self.delegate managerCallAPIDidSuccess:response];
            }
        } else {
            [self.delegate managerCallAPIDidSuccess:response];
        }
    }
    [self afterPerformSuccessWithResponse:response];
}

- (void)failedOnCallingAPI:(WVRNetworkingResponse *)response
{
    self.isLoading = NO;
    self.response = response;
    if ([response.content[@"id"] isEqualToString:@"expired_access_token"]) {
        [self accesstonkenInvalidNotifyWithResponse:response withName:kBSUserTokenInvalidNotification];
    } else if ([response.content[@"id"] isEqualToString:@"illegal_access_token"]) {
        [self accesstonkenInvalidNotifyWithResponse:response withName:kBSUserTokenIllegalNotification];
    } else if ([response.content[@"id"] isEqualToString:@"no_permission_for_this_api"]) {
        [self accesstonkenInvalidNotifyWithResponse:response withName:kBSUserTokenNoPermissionNotification];
    } else {
        [self removeRequestIdWithRequestID:response.requestId];
        if ([self beforePerformFailWithResponse:response]) {
            [self.delegate managerCallAPIDidFailed:response];
        }
        [self afterPerformFailWithResponse:response];
    }
}

- (void)accesstonkenInvalidNotifyWithResponse:(WVRNetworkingResponse *)response withName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] postNotificationName:name
                                                        object:nil
                                                      userInfo:@{
                                                                 kBSUserTokenNotificationUserInfoKeyRequestToContinue:[response.request mutableCopy],
                                                                 kBSUserTokenNotificationUserInfoKeyManagerToContinue:self
                                                                 }];
}

#pragma mark - method for interceptor
/** Both subclass and outer class can implement interceptors, call [super] first when they are coexistent. The order is Subclass interceptor -> Outer class interceptor
    These methods is for Decorate Pattern
 **/
- (BOOL)beforePerformSuccessWithResponse:(WVRNetworkingResponse *)response
{
    BOOL result = YES;
    
    self.errorType = WVRAPIManagerErrorTypeSuccess;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(beforePerformSuccessWithResponse:)]) {
        result = [self.interceptor beforePerformSuccessWithResponse:response];
    }
    return result;
}

- (void)afterPerformSuccessWithResponse:(WVRNetworkingResponse *)response
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(afterPerformSuccessWithResponse:)]) {
        [self.interceptor afterPerformSuccessWithResponse:response];
    }
}

- (BOOL)beforePerformFailWithResponse:(WVRNetworkingResponse *)response
{
    BOOL result = YES;
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(beforePerformFailWithResponse:)]) {
        result = [self.interceptor beforePerformFailWithResponse:response];
    }
    return result;
}

- (void)afterPerformFailWithResponse:(WVRNetworkingResponse *)response
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(afterPerformFailWithResponse:)]) {
        [self.interceptor afterPerformFailWithResponse:response];
    }
}

/** Network request wouldn't be sent if this mehtod return false **/
- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(shouldCallAPIWithParams:)]) {
        return [self.interceptor shouldCallAPIWithParams:params];
    } else {
        return YES;
    }
}

- (void)afterCallingAPIWithParams:(NSDictionary *)params
{
    if (self != self.interceptor && [self.interceptor respondsToSelector:@selector(afterCallingAPIWithParams:)]) {
        [self.interceptor afterCallingAPIWithParams:params];
    }
}

#pragma mark - method for child
- (void)cleanData
{
    [self.cache clean];
    self.fetchedRawData = nil;
    self.errorMessage = nil;
    self.errorType = WVRAPIManagerErrorTypeDefault;
}

/** Add some extra params (e.g. pageNumber and pageSize) **/
- (NSDictionary *)reformParams:(NSDictionary *)params
{
    IMP childIMP = [self.child methodForSelector:@selector(reformParams:)];
    IMP selfIMP = [self methodForSelector:@selector(reformParams:)];
    
    if (childIMP == selfIMP) {
        return params;
    } else {
        NSDictionary *result = nil;
        result = [self.child reformParams:params];
        if (result) {
            return result;
        } else {
            return params;
        }
    }
}

- (BOOL)shouldCache
{
    return kWVRShouldCache;
}

#pragma mark - private methods

- (BOOL)isCorrectWithParamsData:(NSDictionary *) apiParams{
    if (self.validator == nil) {
        return YES;
    }
    return [self.validator isCorrectWithParamsData:apiParams];
}

- (BOOL)isCorrectWithCallBackData:(NSDictionary *) data {
    if (self.validator == nil) {
        return YES;
    }
    return [self.validator isCorrectWithCallBackData:data];
}

- (void)removeRequestIdWithRequestID:(NSInteger)requestId
{
    NSNumber *requestIDToRemove = nil;
    for (NSNumber *storedRequestId in self.requestIdList) {
        if ([storedRequestId integerValue] == requestId) {
            requestIDToRemove = storedRequestId;
        }
    }
    if (requestIDToRemove) {
        [self.requestIdList removeObject:requestIDToRemove];
    }
}

- (BOOL)hasCacheWithParams:(NSDictionary *)params
{
    NSString *serviceIdentifier = self.child.serviceType;
    NSString *methodName = self.child.methodName;
    NSData *result = [self.cache fetchCachedDataWithServiceIdentifier:serviceIdentifier methodName:methodName requestParams:params];
    
    if (result == nil) {
        return NO;
    }
    
//    __weak typeof(self) weakSelf = self;
//    dispatch_async(dispatch_get_main_queue(), ^{
//        __strong typeof (weakSelf) strongSelf = weakSelf;
        WVRNetworkingResponse *response = [[WVRNetworkingResponse alloc] initWithData:result];
        response.requestParams = params;
        [WVRNetworkingLogger logDebugInfoWithCachedResponse:response methodName:methodName serviceIdentifier:[[WVRNetworkingServiceFactory sharedInstance] serviceWithIdentifier:serviceIdentifier]];
        [self successedOnCallingAPI:response];
//    });
    return YES;
}

- (void)loadDataFromNative
{
    NSString *methodName = self.child.methodName;
    NSDictionary *result = (NSDictionary *)[[NSUserDefaults standardUserDefaults] objectForKey:methodName];
    
    if (result) {
        self.isNativeDataEmpty = NO;
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            WVRNetworkingResponse *response = [[WVRNetworkingResponse alloc] initWithData:[NSJSONSerialization dataWithJSONObject:result options:0 error:NULL]];
            [strongSelf successedOnCallingAPI:response];
        });
    } else {
        self.isNativeDataEmpty = YES;
    }
}

#pragma mark - getters and setters
- (WVRNetworkingCache *)cache
{
    if (_cache == nil) {
        _cache = [WVRNetworkingCache sharedInstance];
    }
    return _cache;
}

- (NSMutableArray *)requestIdList
{
    if (_requestIdList == nil) {
        _requestIdList = [[NSMutableArray alloc] init];
    }
    return _requestIdList;
}

- (BOOL)isReachable
{
    BOOL isReachability = [WVRApiProxy sharedInstance].isReachable;
    if (!isReachability) {
        self.errorType = WVRAPIManagerErrorTypeNoNetWork;
    }
    return isReachability;
}

- (BOOL)isLoading
{
    if (self.requestIdList.count == 0) {
        _isLoading = NO;
    }
    return _isLoading;
}

- (BOOL)shouldLoadFromNative
{
    return NO;
}

@end
