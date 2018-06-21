//
//  WVRRequestProtocol.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

@protocol WVRRequestProtocol

@required
- (id)execute;
- (void)cancel;
- (NSString *)getUrl;
- (id)result;
- (void)onRequestSuccess:(id)responesObject;
- (void)onRequestFailed:(id)responesObject;

@optional
- (void)onDataSuccess:(id)dataObject;
- (void)onDataFailed:(id)dataObject;

@end
