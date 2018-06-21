//
//  WVRNet.h
//  WVRNet
//
//  Created by qbshen on 2017/7/4.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRSessionProtocol.h"

@interface WVRNet : NSObject

+(void)configWith:(id<WVRSessionProtocol>)sessionDelegate;

@end
