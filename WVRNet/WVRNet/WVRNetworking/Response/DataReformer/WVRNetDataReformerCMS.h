//
//  WVRNetDataReformerCMS.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/27.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRAPIManagerDataReformer.h"

@interface WVRNetDataReformerCMS : NSObject <WVRAPIManagerDataReformer>
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSString *msg;
@property(nonatomic, strong) id data;
@property (nonatomic, weak) NSObject<WVRAPIManagerDataReformer> *child;

@end
