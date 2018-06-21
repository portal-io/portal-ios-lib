//
//  WVRNetworkingResponse.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRNetworkingResponse.h"
#import "NSURLRequest+WVRNetworkingMethods.h"
#import "NSObject+WVRNetworkingMethods.h"

@interface WVRNetworkingResponse ()

@property (nonatomic, assign, readwrite) WVRNetworkingResponseStatus status;
@property (nonatomic, copy, readwrite) NSString *contentString;
@property (nonatomic, copy, readwrite) NSDictionary *content;
@property (nonatomic, copy, readwrite) NSURLRequest *request;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSData *responseData;
@property (nonatomic, assign, readwrite) BOOL isCache;

@end

@implementation WVRNetworkingResponse

#pragma mark - life cycle

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(WVRNetworkingResponseStatus)status
{
    self = [super init];
    if (self) {
        self.contentString = responseString;
        self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        self.status = status;
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
//        [self checkResultValid];
    }
    return self;
}

- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error
{
    self = [super init];
    if (self) {
        self.contentString = [responseString WVR_defaultValue:@""];
        self.status = [self responseStatusWithError:error];
        self.requestId = [requestId integerValue];
        self.request = request;
        self.responseData = responseData;
        self.requestParams = request.requestParams;
        self.isCache = NO;
        
        if (responseData) {
            self.content = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:NULL];
        } else {
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"code"] = @(error.code);
            dict[@"msg"] = error.description;
            self.content = dict;
        }
    }
    return self;
}

- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self) {
        self.contentString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        self.status = [self responseStatusWithError:nil];
        self.requestId = 0;
        self.request = nil;
        self.responseData = [data copy];
        self.content = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL];
        self.isCache = YES;
    }
    return self;
}

#pragma mark - private methods

- (WVRNetworkingResponseStatus)responseStatusWithError:(NSError *)error
{
    if (!error) {
        return WVRNetworkingResponseStatusSuccess;
    }
    
    WVRNetworkingResponseStatus result = (error.code == NSURLErrorTimedOut) ?WVRNetworkingResponseStatusErrorTimeout:WVRNetworkingResponseStatusErrorNoNetwork;
    return result;
}

- (void)checkResultValid {
    
    /// 9月5日新增，需要测试，如果后台接口没有返回数据，则按照error处理
    if (self.status == WVRNetworkingResponseStatusSuccess && [self.content isKindOfClass:[NSDictionary class]]) {
        
        NSDictionary *dict = self.content;
        if (dict.count < 1) {
            self.status = WVRNetworkingResponseStatusErrorNoNetwork;
            
//        } else if (dict[@"code"] && ![dict[@"code"] isEqualToString:@"200"]) {
//            
//            self.status = WVRNetworkingResponseStatusErrorNoNetwork;
//            
        } else if ([self.request.URL.absoluteString containsString:@"newVR-service/appservice/program/findByCode"] && !dict[@"data"]) {
            
            // 节目详情接口只要数据为空，则返回错误
            self.status = WVRNetworkingResponseStatusErrorNoNetwork;
        }
    }
}

@end
