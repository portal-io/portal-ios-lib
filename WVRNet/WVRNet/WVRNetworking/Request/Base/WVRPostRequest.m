//
//  WVRPostRequest.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRPostRequest.h"
#import "WVRRequestPage.h"
#import "AFHTTPSessionManager.h"
#import "WVRRequestOptManager.h"
#import "WVRBaseResponse.h"
#import "YYModel.h"

static const NSInteger SUCCESS_STATUS = 1 | 200;

NSString * const kHttpParams_Page = @"page";
NSString * const kHttpParams_Num = @"num";
NSString * const kHttpParams_Index_nav_pic_width = @"nav_pic_width";
NSString * const kHttpParams_Index_nav_pic_height = @"nav_pic_height";
NSString * const kHttpParams_Index_nav_pic_type = @"nav_pic_type";
NSString * const kHttpParams_Index_type_icon_width = @"type_icon_width";
NSString * const kHttpParams_Index_type_icon_height = @"type_icon_height";
NSString * const kHttpParams_Index_type_icon_type = @"type_icon_type";
NSString * const kHttpParams_Index_item_pic_width = @"item_pic_width";
NSString * const kHttpParams_Index_item_pic_height = @"item_pic_height";
NSString * const kHttpParams_Index_item_pic_type = @"item_pic_type";


@implementation WVRPostRequest

- (void)ThrowOverridException
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

/* protocol WVRRequestProtocol method */
- (id)execute {
//    AFHTTPSessionManager *manager = [[WVRRequestOptManager sharedInstance] getAFManagerInstance];
    
    AFHTTPSessionManager *manager = [[WVRRequestOptManager sharedInstance] getAFManagerInstance];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain",@"text/xml", nil];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates = NO;
    manager.requestSerializer.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [manager POST:(NSString*)[self getUrl] parameters:[self getBodyParam] constructingBodyWithBlock:^(id _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self onRequestSuccess:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self onRequestFailed:@"网络异常"];
    }];
    
    [task resume];
    return task;
}

- (NSDictionary *)getBodyParam {
    
    NSDictionary * params = [self bodyParams];
    NSLog(@"\n-------分割线-------\n3bodyParams--:\n %@\n-------分割线-------\n", [self dictionaryToJson:params]);
    return params;
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
    NSLog(@"\nrequest URL: %@", url);
    return url;
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
    
    WVRBaseResponse *baseResponse = [WVRBaseResponse yy_modelWithDictionary:result];
    NSInteger status = baseResponse.status;
    if (status == SUCCESS_STATUS) {
        [self parsePage:baseResponse];
        [self onDataSuccess:baseResponse];
    } else {
        [self onDataFailed:baseResponse.msg];
    }
}

/* protocol WVRRequestProtocol method */
- (void)onRequestFailed:(id)responesObject
{
    NSLog(@"\n-------分割线-------\nfail responesObject:\n %@\n-------分割线-------\n",responesObject);
    [self onDataFailed:responesObject];
}

/* protocol WVRRequestProtocol method*/
- (void)onDataSuccess:(id)dataObject
{
    [self ThrowOverridException];
}

/* protocol WVRRequestProtocol method*/
- (void)onDataFailed:(id)dataObject
{
    [self ThrowOverridException];
}

- (void)parsePage:(id)response
{
    NSDictionary *pageResult = (NSMutableDictionary *)response;
    
    WVRRequestPage *page = [WVRRequestPage yy_modelWithDictionary:pageResult];
    self.page = page;
}
@end
