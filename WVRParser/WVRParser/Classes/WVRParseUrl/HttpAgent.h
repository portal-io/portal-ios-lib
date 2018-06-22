//
//  HttpAgent.h
//  MoreTVPlayerKit
//
//  Created by 黄太烽 on 15/12/30.
//  Copyright © 2015年 whaley. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpAgent : NSObject

+ (instancetype)sharedInstance;

- (void)start;
- (void)stop;

@end
