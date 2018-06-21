//
//  WVRAPIHandle.m
//  VRManager
//
//  Created by apple on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRAPIHandle.h"

@implementation WVRAPIHandle

+ (NSDictionary *)appendCommenParams:(NSDictionary *)param {
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:@{}];
    
    for (NSString *key in param.allKeys) {
        dict[key] = param[key];
    }
    
    return [dict copy];
}

@end
