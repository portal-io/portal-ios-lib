//
//  WVRRequestOptManager.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRRequestOptManager.h"

@interface WVRRequestOptManager ()

@property AFHTTPSessionManager* afOptManager;

@end


@implementation WVRRequestOptManager

+ (instancetype)sharedInstance
{
//    NSProcessInfo * pif = [NSProcessInfo processInfo];
//    NSString * pidN = [pif processName];
//    NSLog(@"pidname  %@", pidN);
    
    static WVRRequestOptManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[WVRRequestOptManager alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {

        NSURLSessionConfiguration *defaultConfiguration = [self.class defaultURLSessionConfiguration];
        self.afOptManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:defaultConfiguration];
    }
    return self;
}

+ (NSURLCache *)defaultURLCache {
    return [[NSURLCache alloc] initWithMemoryCapacity:100 * 1024 * 1024
                                         diskCapacity:150 * 1024 * 1024
                                             diskPath:@"com.alamofire.imagedownloader"];
}

+ (NSURLSessionConfiguration *)defaultURLSessionConfiguration {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    //TODO set the default HTTP headers
    
    configuration.HTTPShouldSetCookies = YES;
    /**
     HTTPShouldUsePipelining表示receiver(理解为iOS客户端)的下一个信息是否必须等到上一个请求回复才能发送。
     如果为YES表示可以，NO表示必须等receiver收到先前的回复才能发送下个信息。
     */
    configuration.HTTPShouldUsePipelining = NO;
    /**NSURLRequestReloadRevalidatingCacheData
     *  NSURLRequestUseProtocolCachePolicy = 0, 默认的缓存策略， 如果缓存不存在，直接从服务端获取。如果缓存存在，会根据response中的Cache-Control字段判断下一步操作，如: Cache-Control字段为must-revalidata, 则询问服务端该数据是否有更新，无更新的话直接返回给用户缓存数据，若已更新，则请求服务端
     */
    configuration.requestCachePolicy = NSURLRequestUseProtocolCachePolicy;
    configuration.allowsCellularAccess = YES;
    configuration.timeoutIntervalForRequest = 10.0;
    configuration.URLCache = [[self class] defaultURLCache];
    
    return configuration;
}


- (AFHTTPSessionManager *)getAFManagerInstance
{
    return self.afOptManager;
}

@end
