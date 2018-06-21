//
//  WVRAPINetDataReformerBUS.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/3/2.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRAPINetDataReformerBUS.h"

@implementation WVRAPINetDataReformerBUS
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
    _status = [data valueForKey:@"code"];
    _message = [data valueForKey:@"msg"];
    _data = [data valueForKey:@"data"];
    _time = [data valueForKey:@"time"];
    return _data;
}

@end
