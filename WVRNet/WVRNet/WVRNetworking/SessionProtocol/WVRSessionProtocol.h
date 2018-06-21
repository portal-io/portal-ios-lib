//
//  WVRSessionProtocol.h
//  WVRNet
//
//  Created by qbshen on 2017/7/4.
//  Copyright © 2017年 qbshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WVRSessionProtocol <NSObject>

- (NSString *)getAccessToken;

- (void)updateAccessToken:(NSString *)accessToken;

- (NSDictionary *)getCommonParams;

@end
