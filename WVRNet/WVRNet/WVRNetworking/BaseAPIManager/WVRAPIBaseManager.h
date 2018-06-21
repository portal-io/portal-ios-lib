//
//  WVRBaseAPIManager.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/16.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WVRAPIManagerCallBackDelegate.h"
#import "WVRAPIManagerDataReformer.h"
#import "WVRAPIManagerValidator.h"
#import "WVRAPIManagerErrorType.h"
#import "WVRAPIManagerInterceptor.h"
#import "WVRAPIManager.h"


UIKIT_EXTERN NSString * const kBSFileUploadParams_formData ;
UIKIT_EXTERN NSString * const kBSFileUploadParams_keyName ;
UIKIT_EXTERN NSString * const kBSFileUploadParams_fileName ;

@class WVRAPIBaseManager;

static NSString * const kWVRAPIBaseManagerRequestID = @"kWVRAPIBaseManagerRequestID";

typedef void (^onSuccessed)(id successData);
typedef void (^onFailed)(id failedData);

#pragma mark - WVRAPIBaseManager
@interface WVRAPIBaseManager : NSObject
/** Notify the property weak **/
@property (nonatomic, weak) id<WVRAPIManagerCallBackDelegate> delegate;
@property (nonatomic, weak) id<WVRAPIManagerValidator> validator;
@property (nonatomic, weak) NSObject<WVRAPIManager> *child;
@property (nonatomic, weak) id<WVRAPIManagerInterceptor> interceptor;

/** BaseManager shouldn't set errorMessage, subclass supply them to ViewController **/
@property (nonatomic, copy, readonly) NSString *errorMessage;
@property (nonatomic, readonly) WVRAPIManagerErrorType errorType;
@property (nonatomic, strong) WVRNetworkingResponse *response;

/* Params in url (e.g http://xxx/yyy/{id}) */
@property (nonatomic, strong) NSDictionary *urlParams;
/* Params splicing url (e.g http://xxx/yyy?id=param or Post key=value)*/
@property (nonatomic, strong) NSDictionary *bodyParams;

@property (nonatomic, assign, readonly) BOOL isReachable;
@property (nonatomic, assign, readonly) BOOL isLoading;

- (id)fetchDataWithReformer:(id<WVRAPIManagerDataReformer>)reformer;

- (NSInteger)loadData;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;

- (void)cancelAllRequests;
- (void)cancelRequestWithRequestId:(NSInteger)requestID;

// Intecept methods, need 'super' after inheriting
- (BOOL)beforePerformSuccessWithResponse:(WVRNetworkingResponse *)response;
- (void)afterPerformSuccessWithResponse:(WVRNetworkingResponse *)response;

- (BOOL)beforePerformFailWithResponse:(WVRNetworkingResponse *)response;
- (void)afterPerformFailWithResponse:(WVRNetworkingResponse *)response;

- (BOOL)shouldCallAPIWithParams:(NSDictionary *)params;
- (void)afterCallingAPIWithParams:(NSDictionary *)params;

/** Subclass could implement this method to add additional params.
    Subclass needn't call [super reformParams:params].
    WVRAPIBaseManager call this first, and then validator method.
    This method will override the added params **/
- (NSDictionary *)reformParams:(NSDictionary *)params;

- (void)cleanData;
- (BOOL)shouldCache;

- (void)successedOnCallingAPI:(WVRNetworkingResponse *)response;
- (void)failedOnCallingAPI:(WVRNetworkingResponse *)response;

/** Block for business layer **/
@property (nonatomic, copy) onSuccessed successedBlock;
@property (nonatomic, copy) onFailed failedBlock;

@end
