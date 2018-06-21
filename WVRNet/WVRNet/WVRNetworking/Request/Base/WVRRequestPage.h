//
//  WVRRequestPage.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "YYModel.h"

@interface WVRRequestPage : NSObject

@property (nonatomic, copy  ) NSString *total;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, assign) NSInteger remain;
@property (nonatomic, assign) NSInteger page;

@end
