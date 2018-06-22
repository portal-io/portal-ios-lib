//
//  LPParseTaskInfo.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/25.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPParser.h"

@interface LPParseTaskInfo : NSObject
+ (LPParseTaskInfo*) taskInfoWithUrl: (NSString*) aurl callback: (LPParseCallback) aCallback;
+ (LPParseTaskInfo*) taskInfoWithUrl: (NSString*) aurl callback: (LPParseCallback) aCallback videoQuality:(LPVideoQuality) quality;

@property NSString* url;
@property (copy) LPParseCallback callback;
@property LPVideoQuality targetQuality;
@end
