//
//  WVRParseUrl.h
//  VRManager
//
//  Created by Wang Tiger on 16/6/23.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WVRParserUrlResult.h"
#import "LuaParser/LPParseResult.h"

typedef void (^WVRParserUrlCallback)(WVRParserUrlResult *result);

@interface WVRParseUrl : NSObject

+ (NSURL *)parseMoguvUrl: (NSString *)url pResult:(LPParseResult *)parseResult;
+ (void)parserUrl:(NSString *)originUrl callback:(WVRParserUrlCallback)aCallback;

@end
