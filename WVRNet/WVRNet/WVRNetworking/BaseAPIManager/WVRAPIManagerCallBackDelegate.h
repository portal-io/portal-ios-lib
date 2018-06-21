//
//  WVRAPIManagerCallBackDelegate.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/21.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingResponse.h"

@protocol WVRAPIManagerCallBackDelegate <NSObject>
@required
- (void)managerCallAPIDidSuccess:(WVRNetworkingResponse *)response;
- (void)managerCallAPIDidFailed:(WVRNetworkingResponse *)response;
@end
