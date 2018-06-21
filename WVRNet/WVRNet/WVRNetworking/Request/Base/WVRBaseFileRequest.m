//
//  WVRPostRequest.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRBaseFileRequest.h"
#import "WVRRequestPage.h"
#import "AFHTTPSessionManager.h"
#import "WVRRequestOptManager.h"
#import "WVRBaseResponse.h"
#import "YYModel.h"

static const NSInteger SUCCESS_STATUS = 1 | 200;


@implementation WVRBaseFileRequest
- (void)ThrowOverridException
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

/* protocol WVRRequestProtocol method */
- (id)execute{
    
    AFHTTPSessionManager *manager = [[WVRRequestOptManager sharedInstance] getAFManagerInstance];
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"application/json", @"text/json",@"text/plain",@"text/xml", nil];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.securityPolicy.allowInvalidCertificates=NO;
//    manager.requestSerializer.timeoutInterval = 10;
    
    NSURLSessionDataTask *task = [manager POST:(NSString*)[self getUrl]parameters:[self getBodyParam] constructingBodyWithBlock:^(id _Nonnull formData){
        [self addFileToForm:formData];
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
    NSLog(@"\n-------分割线-------\n2bodyParams:\n %@\n-------分割线-------\n", [self dictionaryToJson:params]);
    return params;
}

- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (id)getOriginResponse{
    return [self originResponse];
}

/* protocol WVRRequestProtocol method */
- (void)cancel{
}

/* protocol WVRRequestProtocol method */
- (NSString *)getUrl
{
    NSString *baseUrl = [self getHost];
    NSString *url = [baseUrl stringByAppendingString:[self getActionUrl]];
    NSLog(@"\nrequest URL: %@",url);
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
    NSDictionary *result = (NSMutableDictionary*)responesObject;
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
    NSLog(@"%@", responesObject);
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

- (void) addFileToForm: (id<AFMultipartFormData>)formData
{
    if (self.fileDatas) {
        for (NSData* data in self.fileDatas) {
            [formData appendPartWithFileData:data name:[NSString stringWithFormat:@"%@_%lu",_keyName,(unsigned long)[self.fileDatas indexOfObject:data]] fileName:[NSString stringWithFormat:@"%f.0.png",[[NSDate date] timeIntervalSince1970]] mimeType:@"*/*"];
        }
    }else{
        if (_fileData == nil) {
            return;
        }
        //    [formData appendPartWithFileURL:[NSURL fileURLWithPath:theImagePath] name:@"file" error:nil];
        
        [formData appendPartWithFileData:_fileData name:_keyName fileName:_fileName mimeType:@"*/*"];
    }
}

- (NSString *)getFileKeyName:(int) index
{
    return [NSString stringWithFormat:@"%@%@%d%@",_keyName,@"[",index,@"]"];
}

@end
