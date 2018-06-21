//
//  WVRAPIManagerDataReformer.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/21.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@protocol WVRAPIManagerDataReformer <NSObject>
@required
- (id)reformData:(NSDictionary *)data;

@end
