//
//  WVRAPINetDataReformerBUS.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/3/2.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRAPIManagerDataReformer.h"

@interface WVRAPINetDataReformerBUS : NSObject <WVRAPIManagerDataReformer>
@property(nonatomic, strong) NSString *status;
@property(nonatomic, strong) NSString *message;
@property(nonatomic, strong) NSDate *time;
@property(nonatomic, strong) id data;
@property (nonatomic, weak) NSObject<WVRAPIManagerDataReformer> *child;

@end
