//
//  Utils.m
//  Pods
//
//  Created by 黄太烽 on 16/3/1.
//
//

#import "WLYPlayerUtils.h"
#import <SecurityFramework/Security.h>

static NSString *g_securityToken = @"";
static LPParseResult *g_parseResult = nil;
static NSString *const wvr_proxy_url_prefix = @"http://127.0.0.1:12581/?Action=agent";

@implementation WLYPlayerUtils

+ (NSString *)modifyRemoteM3u8String:(NSString *)m3u8Str prefix:(NSString *)prefix host:(NSString *)host {
    
    BOOL isVod = [m3u8Str containsString:@"#EXT-X-ENDLIST"];
    NSMutableString* retString = [[NSMutableString alloc] init];
    NSArray * listItems =  [m3u8Str componentsSeparatedByString:@"\n"];
    NSUInteger count = listItems.count;
//    if ([[listItems objectAtIndex:0] hasPrefix:@"#EXTM3U"]) {
//        return m3u8Str;
//    }
    for (int i = 0; i < count; i ++) {
        NSString *tagItem = [listItems objectAtIndex:i];
        if ([tagItem hasPrefix:@"#EXT-X-STREAM-INF"]) {
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
            
            //add value
            i ++;
            NSString *item = [listItems objectAtIndex:i];
            if (item != nil && ![item isEqualToString:@""] && ![item hasPrefix:@"#"]) {
                //add security
                if ([g_securityToken length] > 0) {
                    if ([item rangeOfString:@"?"].location != NSNotFound) {
                        [item stringByAppendingFormat:@"&%@", g_securityToken];
                    } else {
                        [item stringByAppendingFormat:@"?%@", g_securityToken];
                    }
                }
                Security *sc = [Security getInstance];
                NSString *absUrl = [sc Security_GetUrl:[self toAbsUrl:item location:host] WithAlgid:sc.cdnAlgid];
                //add line
                [retString appendFormat:@"%@&url=%@&curExt=m3u8\r\n",prefix, [WLYPlayerUtils encodeString:absUrl]];
            }
        } else if ([tagItem hasPrefix:@"#EXTINF"]) {
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
            //get duration
            NSArray* tList = [tagItem componentsSeparatedByString:@":"];
            double duration = [[tList objectAtIndex:1] doubleValue];
            
            //add value
            i++;
            NSString *item = [listItems objectAtIndex:i];
            if (item != nil && ![item isEqualToString:@""] && ![item hasPrefix:@"#"]) {
                NSString *absUrl = [WLYPlayerUtils toAbsUrl:item location:host];
                //add security
                if ([g_securityToken length] > 0) {
                    if ([absUrl rangeOfString:@"?"].location != NSNotFound) {
                        absUrl = [absUrl stringByAppendingFormat:@"&%@", g_securityToken];
                    } else {
                        absUrl = [absUrl stringByAppendingFormat:@"?%@", g_securityToken];
                    }
                }
                Security *sc = [Security getInstance];
                absUrl = [sc Security_GetUrl:absUrl WithAlgid:sc.cdnAlgid];
//                WLYLogVerbose(@"%s, ret = %@", __func__, absUrl);
                
                if (isVod) {
                    //
                    absUrl = [NSString stringWithFormat:@"%@&url=%@&duration=%f&curExt=ts", prefix,[WLYPlayerUtils encodeString:absUrl], duration];
                } else {
                    //
                    absUrl = [NSString stringWithFormat:@"%@&url=%@&curExt=ts", prefix,[WLYPlayerUtils encodeString:absUrl]];
                }
                //add line
                [retString appendFormat:@"%@\r\n",absUrl];
            }
        } else if ([tagItem hasPrefix:@"#EXT-X-ENDLIST"]){
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
        } else {
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
        }
    }
    return retString;
}

//to
+ (NSString *)toAbsUrl:(NSString *)url location:(NSString *)location {
    
    if (url.length <= 0) { return @""; }
    
    NSString *ret = url;
    if ([ret hasPrefix:@"http"]) {
        return ret;
    } else {
        if ([ret hasPrefix:@"/"]) {
            ret = [[location substringWithRange:NSMakeRange(0, [[location substringWithRange:NSMakeRange(8, [location length] -8)] rangeOfString:@"/"].location + 8)] stringByAppendingString:ret];
        } else {
            ret = [location stringByAppendingString:ret];
        }
    }
//    WLYLogVerbose(@"%s, ret = %@", __func__, ret);
    return ret;
}

//get domain from url
+ (NSString *)getDomainFromUrl:(NSString *)url {
    
    if (url.length <= 0) { return @""; }
    
    NSString *ret = @"";
    int endPos = -1;
    if ([url hasPrefix:@"http"]) {
        NSUInteger location = [url rangeOfString:@"?"].location;
        if (location != NSNotFound) {
            endPos = (int)location;
        }
    } else {
        //
        NSUInteger location = [url rangeOfString:@"/" options:NSBackwardsSearch].location;
        if (location != NSNotFound) {
            endPos = (int)location;
        }
    }
    if (endPos == -1) {
        ret = url;
        
    } else {
        ret = [url substringWithRange:NSMakeRange(0, endPos)];
    }
    NSUInteger last = [ret rangeOfString:@"/" options:NSBackwardsSearch].location;
    if (last != NSNotFound) {
        ret = [ret substringWithRange:NSMakeRange(0, last)];
    }
    
    if (![ret hasSuffix:@"/"]) {
        ret = [ret stringByAppendingString:@"/"];
    }
//    WLYLogVerbose(@"%s, ret = %@", __func__, ret);
    return ret;
}

//URLEncode
+ (NSString *)encodeString:(NSString *)unencodedString {
    
    NSString *encodedString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];
    
    return encodedString;
}

//URLDecode
+ (NSString *)decodeString:(NSString *)encodedString {
    
    NSString *decodedString  = [encodedString stringByRemovingPercentEncoding];
    
    return decodedString;
}

+ (NSMutableDictionary *)getParameterList:(NSString *)path {
    
    NSMutableDictionary *result = [[NSMutableDictionary alloc] init];
    NSString * uri = path;
    NSUInteger index = [uri rangeOfString:@"?"].location;
    if (index == NSNotFound) {
        return result;
    }
    
    uri = [uri substringFromIndex:index + 1];
    while (index != NSNotFound) {
        NSString * name = nil;
        NSRange eqRange = [uri rangeOfString:@"="];
        NSUInteger eqIndex = eqRange.location;
        if (eqIndex == NSNotFound) {
            break;
        } else {
            name = [uri substringToIndex:eqIndex];
        }
        NSString * value = nil;
        uri = [uri substringFromIndex:eqIndex + 1];
        NSRange andRange = [uri rangeOfString:@"&"];
        NSUInteger andIndex = andRange.location;
        if (andIndex == NSNotFound) {
            value = uri;
            [result setValue:value forKey:name];
            break;
        } else {
            value = [uri substringToIndex:andIndex];
        }
        [result setValue:value forKey:name];
        
        uri = [uri substringFromIndex:andIndex + 1];
    }
    return result;
}

/**
 * Parses the given query string.
 *
 * For example, if the query is "q=John%20Mayer%20Trio&num=50"
 * then this method would return the following dictionary:
 * {
 *   q = "John Mayer Trio"
 *   num = "50"
 * }
 **/
- (NSDictionary *)parseParams:(NSString *)query
{
    NSArray *components = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithCapacity:[components count]];
    
    NSUInteger i;
    for (i = 0; i < [components count]; i++)
    {
        NSString *component = [components objectAtIndex:i];
        if ([component length] > 0)
        {
            NSRange range = [component rangeOfString:@"="];
            if (range.location != NSNotFound)
            {
                NSString *key = [component substringToIndex:(range.location + 0)];
                NSString *value = [component substringFromIndex:(range.location + 1)];
                if (value)
                    [result setObject:value forKey:key];
                else
                    [result setObject:[NSNull null] forKey:key];
            }
        }
    }
    
    return result;
}

+ (void)setToken:(NSString *)token {
    
    g_securityToken = token;
}

+ (void)setParseResult:(LPParseResult*)parseResult {
    
    g_parseResult = parseResult;
}

+ (LPParseResult *)getParseResult {
    
    return g_parseResult;
}

+ (NSString *)getToken {
    
    return g_securityToken;
}

+ (NSString *)proxy_url_prefix {
    
    return wvr_proxy_url_prefix;
}

//#pragma HTTP AGNET
+ (NSString *)getAgentUrl:(NSString *)url {
    
    NSString *urlExt = nil;
    NSString * initURL = nil;
    
    initURL = wvr_proxy_url_prefix;
    
    url = [WLYPlayerUtils encodeString:url];
    
    if (g_parseResult != nil) {
        
        urlExt = g_parseResult.curext;
    }
    
    initURL = [initURL stringByAppendingFormat:@"&url=%@&curExt=%@", url, urlExt];
    
    return initURL;
}

static NSDictionary *proxy_statusCodes = nil;

+ (NSString *)statusForCode:(NSUInteger)statusCode {
        
    if (!proxy_statusCodes) {
        proxy_statusCodes = @{
                         @200 : @"OK",
                         @201 : @"CREATED",
                         @202 : @"ACCEPTED",
                         @203 : @"NON-AUTHORITATIVE INFORMATION",
                         @204 : @"NO CONTENT",
                         @205 : @"RESET CONTENT",
                         @206 : @"PARTIAL CONTENT",
                         @400 : @"BAD REQUEST",
                         @401 : @"UNAUTHORIZED",
                         @402 : @"PAYMENT REQUIRED",
                         @403 : @"FORBIDDEN",
                         @404 : @"NOT FOUND",
                         @405 : @"METHOD NOT ALLOWED",
                         @406 : @"NOT ACCEPTABLE",
                         @407 : @"PROXY AUTHENTICATION REQUIRED",
                         @408 : @"REQUEST TIMEOUT",
                         @409 : @"CONFLICT",
                         @410 : @"GONE",
                         @411 : @"LENGTH REQUIRED",
                         @412 : @"PRECONDITION FAILED",
                         @413 : @"REQUEST ENTITY TOO LARGE",
                         @414 : @"REQUEST-URI TOO LONG",
                         @415 : @"UNSUPPORTED MEDIA TYPE",
                         @416 : @"REQUESTED RANGE NOT SATISFIABLE",
                         @417 : @"EXPECTATION FAILED",
                         @100 : @"CONTINUE",
                         @101 : @"SWITCHING PROTOCOLS",
                         @300 : @"MULTIPLE CHOICES",
                         @301 : @"MOVED PERMANENTLY",
                         @302 : @"FOUND",
                         @303 : @"SEE OTHER",
                         @304 : @"NOT MODIFIED",
                         @305 : @"USE PROXY",
                         @306 : @"RESERVED",
                         @307 : @"TEMPORARY REDIRECT",
                         @500 : @"INTERNAL SERVER ERROR",
                         @501 : @"NOT IMPLEMENTED",
                         @502 : @"BAD GATEWAY",
                         @503 : @"SERVICE UNAVAILABLE",
                         @504 : @"GATEWAY TIMEOUT",
                         @505 : @"HTTP VERSION NOT SUPPORTED",
                         };
    }
    
    NSString *status = [proxy_statusCodes objectForKey:@(statusCode)];
    
    if (status == nil) {
        status = @"UNKNOWN";
    }
    
    return status;
}

@end
