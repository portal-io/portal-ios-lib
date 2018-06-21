//
//  WVRBaseResponse.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface WVRBaseResponse : NSObject

@property (nonatomic) NSInteger status;
@property (copy, nonatomic) NSString *msg;
@property (copy, nonatomic) NSString *cacheDate;

@end
