//
//  WVRAPIManager.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/22.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRAPIManagerRequestType.h"

/** Subclass of APIManager must implement this protocol **/
@protocol WVRAPIManager <NSObject>

@required
- (NSString *)methodName;
- (NSString *)serviceType;
- (WVRAPIManagerRequestType)requestType;
- (BOOL)shouldCache;

// used for pagable API Managers mainly
@optional
- (void)cleanData;
- (NSDictionary *)reformParams:(NSDictionary *)params;
- (NSInteger)loadDataWithParams:(NSDictionary *)params;
- (BOOL)shouldLoadFromNative;

@end
