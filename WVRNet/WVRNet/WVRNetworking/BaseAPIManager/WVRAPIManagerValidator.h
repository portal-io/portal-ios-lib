//
//  WVRAPIManagerValidator.h
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/21.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WVRAPIManagerValidator <NSObject>
@required
- (BOOL)isCorrectWithCallBackData:(NSDictionary *)data;
- (BOOL)isCorrectWithParamsData:(NSDictionary *)data;
@end
