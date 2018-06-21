//
//  WVRGetRequest.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRGetRequest.h"
#import "AFHTTPSessionManager.h"
#import "WVRRequestOptManager.h"
#import "WVRBaseResponse.h"
#import "YYModel.h"

#import "WVRAPIHandle.h"

static const NSInteger SUCCESS_STATUS = 200;
static const NSInteger VR_SUCCESS_STATUS = 1;
static NSString *const DATA_KEY = @"data";
static NSString *const kHttpParamKey_sessionId = @"accessToken";

NSString *const kHttpParams_Get_PageSize = @"pageSize";
NSString *const kHttpParams_Get_PageIndex = @"pageIndex";


@implementation WVRGetRequest

- (void)ThrowOverridException
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

/* protocol WVRRequestProtocol method */
- (id)execute {
    
    AFHTTPSessionManager *manager = [[WVRRequestOptManager sharedInstance] getAFManagerInstance];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html", @"application/json", @"text/json", @"text/plain", @"text/xml", nil];
    manager.requestSerializer.timeoutInterval = 10;
    
   // manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    //
    NSURLSessionDataTask *operation = [manager GET:(NSString *)[self getUrl] parameters:[self getBodyParam] progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self onRequestSuccess:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self onRequestFailed:@"网络异常"];
    }];
    
    [operation resume];
    return operation;
}

- (NSDictionary *)getBodyParam {
    
    // 此类请求都是将参数拼接在URL后，无需再传参数  - (NSString *)getUrl
    
    return nil;
}

- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (id)getOriginResponse {
    return [self originResponse];
}

 /* protocol WVRRequestProtocol method */
- (void)cancel {
}

/* protocol WVRRequestProtocol method */
- (NSString *)getUrl
{
    NSString *baseUrl = [self getHost];
    NSString *url = [baseUrl stringByAppendingString:[self getActionUrl]];
    NSString *paramUrl = [self getParamUrl];
    
    if (paramUrl.length > 0) {
        
        url =  [NSString stringWithFormat:@"%@?%@", url, paramUrl];
    }
    
    NSLog(@"\n-------分割线-------\nrequestURL:\n %@\n-------分割线-------\n", url);
    return url;
}

- (NSDictionary *)getRequestUrlParam {
    
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:[self bodyParams]];
    
//    if (self.needVerify) {
//        HttpConfig *httpConfig = [self httpConfig];
//        NSAssert(nil != httpConfig.accessToken , @"accessToken must not nil");
//        dict[kHttpParamKey_sessionId] = httpConfig.accessToken;
//    }
    
    return [self bodyParams];
}

- (NSString *)getParamUrl
{
    NSString *paramUrl = @"";
    NSDictionary *dict = [self getRequestUrlParam];
    
    if (!dict) { return nil; }
    
    for (NSString *key in dict.allKeys) {
        
//        NSString *codeKey = [key stringByRemovingPercentEncoding];    // 防止二次编码
//        codeKey = [codeKey stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        NSString *codeValue = dict[key];
//        codeValue = [codeValue stringByRemovingPercentEncoding];
//        codeValue = [codeValue stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        paramUrl = [paramUrl stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", key, codeValue]];
    }
    
    if (paramUrl.length < 1) { return nil; }
    
    return [paramUrl substringToIndex:paramUrl.length - 1];
}

/* protocol WVRRequestProtocol method */
- (id)result
{
    return nil;
}

/* protocol WVRRequestProtocol method */
- (void)onRequestSuccess:(id)responesObject
{
    NSDictionary *result = responesObject;
    self.originResponse = responesObject;
    NSMutableDictionary *dataResult = [[NSMutableDictionary alloc] initWithObjectsAndKeys:[result objectForKey:DATA_KEY], DATA_KEY, nil];
    
    WVRBaseResponse *baseResponse = [WVRBaseResponse yy_modelWithDictionary:result];
    NSInteger status = baseResponse.status;
    if (status == SUCCESS_STATUS || status == VR_SUCCESS_STATUS) {
//        [self parsePage:baseResponse];
        [self onDataSuccess:dataResult];
    } else {
        [self onDataFailed:baseResponse.msg];
    }
}

/* protocol WVRRequestProtocol method */
- (void)onRequestFailed:(id)responesObject
{
    NSLog(@"%@", responesObject);
    [self onDataFailed:responesObject];
}

- (void)parsePage:(id)response
{
    NSDictionary *pageResult = response;
    
    WVRRequestPage *page = [WVRRequestPage yy_modelWithDictionary:pageResult];
    self.page = page;
}


@end
