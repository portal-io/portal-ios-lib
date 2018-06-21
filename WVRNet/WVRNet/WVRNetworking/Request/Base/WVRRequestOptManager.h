//
//  WVRRequestOptManager.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface WVRRequestOptManager : NSObject

+ (WVRRequestOptManager *)sharedInstance;
- (AFHTTPSessionManager *) getAFManagerInstance;

@end
