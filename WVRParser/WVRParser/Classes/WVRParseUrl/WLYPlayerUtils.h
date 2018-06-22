//
//  WLYPlayerUtils.h
//  Pods
//
//  Created by 黄太烽 on 16/3/1.
//
//

#import <Foundation/Foundation.h>

//#import "MtvPlayerConfig.h"
#import <LuaParser/LPParseResult.h>

@interface WLYPlayerUtils : NSObject
//URLDEcode
+ (NSString *)decodeString:(NSString *)encodedString;
//URLEncode
+ (NSString *)encodeString:(NSString *)unencodedString;

//
+ (NSMutableDictionary *)getParameterList:(NSString *)path;

+ (void)setToken:(NSString *)token;
+ (NSString *)getToken;
+ (NSString *)proxy_url_prefix;

+ (void)setParseResult:(LPParseResult*)parseResult;
+ (LPParseResult *)getParseResult;

//
+ (NSString *)getAgentUrl:(NSString *)url;

+ (NSString *)modifyRemoteM3u8String:(NSString *)m3u8Str prefix:(NSString *)prefix host:(NSString *)host;

+ (NSString *)toAbsUrl:(NSString *)url location:(NSString *)location;

//
+ (NSString *)getDomainFromUrl:(NSString *)url;

+ (NSString *)statusForCode:(NSUInteger)statusCode;

@end
