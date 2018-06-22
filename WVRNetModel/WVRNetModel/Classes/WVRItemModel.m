//
//  WVRItemModel.m
//  WhaleyVR
//
//  Created by qbshen on 16/11/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRItemModel.h"

@implementation WVRItemModel

+ (NSArray *)modelPropertyBlacklist {
    
    return @[ @"palyMediaModels", @"HDPlayerUrl", @"SDPlayerUrl", @"STPlayerUrl", @"playerUrls", @"arrangeElements", @"packageItemCharged", @"jumpParamsDic", ];
}

#pragma mark - external func

//- (BOOL)isFree {
//    
//    if (!self.isChargeable) {
//        return YES;
//    }
//    if (self.couponDto.price > 0 || [[self contentPackageQueryDto] price] > 0) {
//        return NO;
//    }
//    return YES;
//}

#pragma mark - getter

- (long)price {
    if ([self contentPackageQueryDto] && [[self contentPackageQueryDto] packageType] == WVRPackageTypeProgramSet) {      // 只能购买合集，不能单独购买节目
        return [[self contentPackageQueryDto] price];
    }
    if (self.couponDto.price > 0) {
        return self.couponDto.price;
    }
    if ([[self contentPackageQueryDto] price] > 0) {
        return [[self contentPackageQueryDto] price];
    }
    if (_price > 0) {
        return _price;
    }
    return 0;
}

- (long)totalTime { return 0; }

- (NSString *)infUrl {
    
    if (_infUrl.length > 0) { return _infUrl; }
    
    return self.linkArrangeValue;       // 兼容H5内页和资讯
}

- (NSString *)infTitle {
    
    if (_infTitle.length > 0) { return _infTitle; }
    
    return self.name;       // 兼容H5内页和资讯
}

- (NSString *)sid {
    if (self.linkArrangeValue) {
        return self.linkArrangeValue;
    }
    if (self.code) {
        return self.code;
    }
    return nil;
}

- (NSString *)title {
    
    return self.name;
}

- (NSString *)address {
    
    return @"";
}

- (WVRContentPackageQueryDto *)contentPackageQueryDto {
    
    return self.contentPackageQueryDtos.firstObject;
}

- (NSString *)definitionForPlayURL {
    
    NSLog(@"You must override %s in a subclass", __func__);
    
    return @"";
}

- (BOOL)isFootball {
    
    NSLog(@"You must override %s in a subclass", __func__);
    
    return NO;
}

- (BOOL)isProgramSet {
    
    WVRContentPackageQueryDto *dto = [self.contentPackageQueryDtos firstObject];
    
    return [dto.type isEqualToString:@"0"];
}

@end
