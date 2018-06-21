//
//  WVRAPIBaseManager+ReactiveExtension.h
//  WhaleyVR
//
//  Created by Wang Tiger on 2017/7/26.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRAPIBaseManager.h"
#import <ReactiveObjC/ReactiveObjC.h>

@protocol WVRAPIManagerDataSource <NSObject>
@required
- (NSDictionary *)paramsForAPI:(WVRAPIBaseManager *)manager;
@end

@interface WVRAPIBaseManager (ReactiveExtension)

@property (nonatomic, strong, readonly) RACCommand *requestCmd;
@property (nonatomic, strong, readonly) RACCommand *cancelCmd;
@property (nonatomic, strong, readonly) RACSignal *requestErrorSignal;
@property (nonatomic, strong, readonly) RACSignal *executionSignal;
@property (nonatomic, weak) id<WVRAPIManagerDataSource> dataSource;
- (RACSignal *)requestSignal;
@end
