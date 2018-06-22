//
//  LPParser.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/21.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPParseResult.h"

typedef void (^LPParseCallback)(LPParseResult *);

@interface LPParser : NSObject

+ (LPParser *)sharedParser;

- (void)parseUrl:(NSString *)aUrl callback:(LPParseCallback)aCallback;
- (void)parseUrl:(NSString *)aUrl callback:(LPParseCallback)aCallback targetQuality:(LPVideoQuality)quality;

@property NSString *scriptRoot;
@property BOOL debug;

@end
