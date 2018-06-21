//
//  WVRPostRequest.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRBaseRequest.h"
#import "WVRRequestProtocol.h"
#import "WVRRequestPage.h"

typedef void (^onComplete)(id complete);
typedef void (^onSuccessed)(id successData);
typedef void (^onFailed)(id failedData);

@interface WVRPostRequest : WVRBaseRequest<WVRRequestProtocol>

@property (nonatomic, strong) id originResponse;
@property (nonatomic, strong) WVRRequestPage *page;
@property (nonatomic, copy) onSuccessed successedBlock;
@property (nonatomic, copy) onFailed failedBlock;
- (NSDictionary *)getBodyParam;

@end
