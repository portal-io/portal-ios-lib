//
//  LPParserResult.h
//  LuaPaserTest
//
//  Created by liuyong on 15/12/21.
//  Copyright © 2015年 Whaley. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LPUrlElement.h"
#import "LPHotPoint.h"

typedef enum {
    kSuccess,
    kErrorUnknow,
    kErrorTimeout,
    kErrorRule,
    kErrorIO,
    kErrorForbidden,
    kErrorUnSupport,
    kErrorInitFailed,
    kErrorLua,
    kErrorRuntime,
    kErrorNoValidLuaVM,
    kErrorLuaNotReady
} LPResultType;

typedef enum {
    kAll = 0,
    kST = 1,
    kSD = 2,
    kHD = 3,
    kXD = 4,
    k4K = 5,
    kSDA = 6,
    kSDB = 7,
} LPVideoQuality;


@interface LPParseResult : NSObject

+ (LPParseResult *)resultWithJson:(NSString *)aJson;
+ (LPParseResult *)resultWithType:(LPResultType)type;

- (LPParseResult *)initWithJson:(NSString *)aJson;
- (LPParseResult *)initWithType:(LPResultType)type;

/// getUrlList
- (NSArray<LPUrlElement *> *)getUrlElementList;

- (void)addUrlByBitType:(NSString *)bitType url:(NSString *)aUrl;

@property (nonatomic, copy  ) NSString *page;
@property (nonatomic, copy  ) NSString *curext;
@property (nonatomic, strong) NSDictionary *head;
@property (nonatomic, strong) NSArray<LPHotPoint *> *hotPoints;
@property (nonatomic, assign) LPResultType resultType;
@property (nonatomic, assign) LPVideoQuality videoQuality;
@property (nonatomic, assign) long duration;
@property (nonatomic, assign) BOOL isMoguv;
@property (nonatomic, assign) BOOL isParsed;
@property (nonatomic, assign) BOOL useHttpAgent;

@end
