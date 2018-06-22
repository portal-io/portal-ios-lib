//
//  LPParseTask.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/24.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPParseTaskInfo.h"

@interface LPParseTask : NSThread

+ (void)createTaskPoolWithSize:(int)size scriptDir:(NSString *)scriptDir;
+ (LPParseTask *)getIdleTask;

// should not try to change this after create, not test yet.
+ (void)setUpScriptDir:(NSString *)scriptDir;

- (void)parseWithInfo:(LPParseTaskInfo *)aInfo;
- (void)updateScriptDir:(NSString *)scriptDir;

@property (nonatomic, strong) LPParseTaskInfo* info;

@end
