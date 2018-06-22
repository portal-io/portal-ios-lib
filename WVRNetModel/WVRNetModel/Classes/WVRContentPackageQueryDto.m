//
//  WVRContentPackageQueryDto.m
//  WhaleyVR
//
//  Created by Bruce on 2017/4/15.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRContentPackageQueryDto.h"

@implementation WVRContentPackageQueryDto

- (instancetype)init {
    self = [super init];
    if (self) {
        _couponDto = [[WVRCouponDto alloc] init];
    }
    return self;
}

#pragma mark - getter

- (long)price {
    
    return [_couponDto price];
}


- (WVRPackageType)packageType {
    
    return self.type.integerValue;
}

@end


@implementation WVRCouponDto

#pragma mark - YYModel

//- dic {
//descriptionStr:description
//}

#pragma mark - getter

- (long)price {
    
    if (_discountPrice) {
        return _discountPrice.integerValue;
    }
    return _price;
}

@end
