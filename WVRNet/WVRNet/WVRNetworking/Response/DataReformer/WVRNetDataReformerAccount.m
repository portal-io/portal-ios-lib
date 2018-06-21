//
//  WVRNetDataReformerAccount.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/28.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRNetDataReformerAccount.h"

@implementation WVRNetDataReformerAccount
#pragma mark - life cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(WVRAPIManagerDataReformer)]) {
            self.child = (id <WVRAPIManagerDataReformer>)self;
        }
    }
    return self;
}

#pragma mark - WVRAPIManagerDataReformer
- (id)reformData:(NSDictionary *)data {
    _code = [data valueForKey:@"code"];
    _msg = [data valueForKey:@"msg"];
    _data = [data valueForKey:@"data"];
    return _data;
}

@end
