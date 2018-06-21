//
//  WVRNetworkingServiceFactory.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/20.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRNetworkingService.h"

@interface WVRNetworkingServiceFactory : NSObject
+ (instancetype)sharedInstance;
- (WVRNetworkingService<WVRNetworkingServiceProtocol> *)serviceWithIdentifier:(NSString *)identifier;

@end
