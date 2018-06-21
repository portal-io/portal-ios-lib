//
//  WVRAPIBaseManager+ReactiveExtension.m
//  WhaleyVR
//
//  Created by Wang Tiger on 2017/7/26.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRAPIBaseManager+ReactiveExtension.h"

@interface WVRAPIBaseManager (_ReactiveExtension)
@property (nonatomic, assign) NSInteger requestId;
@end

@implementation WVRAPIBaseManager (_ReactiveExtension)
- (void)setRequestId:(NSInteger)requestId
{
    objc_setAssociatedObject(self, @selector(requestId), @(requestId), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)requestId
{
    return [objc_getAssociatedObject(self, @selector(requestId)) integerValue];
}

@end

@implementation WVRAPIBaseManager (ReactiveExtension)

- (RACSignal *)requestSignal
{
    @weakify(self);
    RACSignal *requestSignal =
    [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self);
        RACSignal *successSignal = [self rac_signalForSelector:@selector(afterPerformSuccessWithResponse:)];
        [[successSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] subscribeNext:^(id x) {
            [subscriber sendNext:x];
            [subscriber sendCompleted];
        }];
        
        RACSignal *failSignal = [self rac_signalForSelector:@selector(afterPerformFailWithResponse:)];
        [[failSignal map:^id(RACTuple *tuple) {
            return tuple.first;
        }] subscribeNext:^(id x) {
            [subscriber sendError:x];
        }];
        return nil;
    }] replayLazily] takeUntil:self.rac_willDeallocSignal];
    return requestSignal;
}

- (RACCommand *)requestCmd {
    RACCommand *requestCommand = objc_getAssociatedObject(self, @selector(requestCmd));
    if (requestCommand == nil) {
        @weakify(self);
        requestCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            NSDictionary *params = [self.dataSource paramsForAPI:self];
            self.requestId = [self loadDataWithParams:params];
            return [self.requestSignal takeUntil:self.cancelCmd.executionSignals];
        }];
        objc_setAssociatedObject(self, @selector(requestCmd), requestCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return requestCommand;
}

- (RACCommand *)cancelCmd {
    RACCommand *cancelCommand = objc_getAssociatedObject(self, @selector(cancelCmd));
    if (cancelCommand == nil) {
        @weakify(self);
        cancelCommand = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            @strongify(self);
            [self cancelRequestWithRequestId:self.requestId];
            NSLog(@"cancelCommand 取消请求:%lu",self.requestId);
            return [RACSignal empty];
        }];
        objc_setAssociatedObject(self, @selector(cancelCmd), cancelCommand, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cancelCommand;
}

- (RACSignal *)requestErrorSignal {
    return [self.requestCmd.errors subscribeOn:[RACScheduler mainThreadScheduler]];
}

- (RACSignal *)executionSignal {
    return [self.requestCmd.executionSignals switchToLatest];
}

- (void)setDataSource:(id<WVRAPIManagerDataSource>)dataSource
{
    objc_setAssociatedObject(self, @selector(dataSource), dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<WVRAPIManagerDataSource>)dataSource
{
    return objc_getAssociatedObject(self, @selector(dataSource));
}

@end
