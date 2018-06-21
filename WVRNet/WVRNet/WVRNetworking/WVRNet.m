//
//  WVRNet.m
//  WVRNet
//
//  Created by qbshen on 2017/7/4.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import "WVRNet.h"
#import "WVRRequestGenerator.h"

@implementation WVRNet

+(void)configWith:(id<WVRSessionProtocol>)sessionDelegate{
    [WVRRequestGenerator sharedInstance].sessionDelegate = sessionDelegate;
}
@end
