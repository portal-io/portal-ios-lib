//
//  WVRNetworkingResponse.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingConfig.h"
#import "WVRAPIManagerErrorType.h"

@interface WVRNetworkingResponse : NSObject

@property (nonatomic, assign, readonly) WVRNetworkingResponseStatus status;
@property (nonatomic, assign) WVRAPIManagerErrorType errorType;
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) NSDictionary *content;
@property (nonatomic, assign, readonly) NSInteger requestId;
@property (nonatomic, copy, readonly) NSURLRequest *request;
@property (nonatomic, copy, readonly) NSData *responseData;
@property (nonatomic, copy) NSDictionary *requestParams;
@property (nonatomic, assign, readonly) BOOL isCache;


/**
 Success Response

 @param responseString responseString
 @param requestId requestId
 @param request request
 @param responseData responseData
 @param status status
 @return Response Of Check Is Vlide
 */
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData status:(WVRNetworkingResponseStatus)status;

/**
 Error Response

 @param responseString responseString
 @param requestId requestId
 @param request request
 @param responseData responseData
 @param error error
 @return Error Response
 */
- (instancetype)initWithResponseString:(NSString *)responseString requestId:(NSNumber *)requestId request:(NSURLRequest *)request responseData:(NSData *)responseData error:(NSError *)error;

/**
 Response Of Cache

 @param data Cache Data
 @return Response Object
 */
- (instancetype)initWithData:(NSData *)data;


@end
