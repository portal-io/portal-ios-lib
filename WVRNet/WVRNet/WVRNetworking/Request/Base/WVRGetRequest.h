//
//  WVRGetRequest.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRBaseRequest.h"
#import "WVRRequestPage.h"
#import "WVRRequestProtocol.h"

typedef void (^onComplete)(id complete);
typedef void (^onSuccessed)(id successData);
typedef void (^onFailed)(id failedData);

extern NSString * const kHttpParams_Get_PageSize;
extern NSString * const kHttpParams_Get_PageIndex;


@interface WVRGetRequest : WVRBaseRequest<WVRRequestProtocol>

@property (nonatomic, strong) WVRRequestPage *page;
@property (nonatomic, strong) id originResponse;
@property (nonatomic, copy) onSuccessed successedBlock;
@property (nonatomic, copy) onFailed failedBlock;

- (NSDictionary *)getBodyParam;

@end
