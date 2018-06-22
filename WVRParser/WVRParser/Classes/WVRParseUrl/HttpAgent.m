//
//  HttpAgent.m
//  MoreTVPlayerKit
//
//  Created by 黄太烽 on 15/12/30.
//  Copyright © 2015年 whaley. All rights reserved.
//

#import "HttpAgent.h"
#import "WLYPlayerUtils.h"
#import "ProxyServer.h"
#import <SecurityFramework/Security.h>
//#define allTrim( object ) [object stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]

#define TYPE_UNKNOWN 0
#define TYPE_SINGLEFILE 1
#define TYPE_M3U8 2
int resourceType = TYPE_UNKNOWN;

//static NSString *g_securityToken = @"";
//static LPParseResult *g_parseResult = nil;

#define USEPROXYSERVER 1

@interface HttpAgent ()

@end


@implementation HttpAgent 

+ (instancetype)sharedInstance {
    static id sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

#pragma mark - HTTPSERVER

- (void)start {
    if (USEPROXYSERVER) {
        char strip[] = {"127.0.0.1"};
        start_proxy_server(strip, 12581);
    }
}

- (void)stop {
    if (USEPROXYSERVER) {
        stop_proxy_server();
    }
}

- (NSString *)modifyRemoteM3u8String:(NSString *) m3u8Str prefix:(NSString *) prefix host:(NSString *)host {
    BOOL isVod = [m3u8Str containsString:@"#EXT-X-ENDLIST"];
    NSMutableString* retString = [[NSMutableString alloc] init];
    NSArray * listItems =  [m3u8Str componentsSeparatedByString:@"\r\n"];
    NSUInteger count = listItems.count;
    for (int i = 0; i < count; i++) {
        NSString *tagItem = [listItems objectAtIndex:i];
        if ([tagItem hasPrefix:@"#EXT-X-STREAM-INF"]) {
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
            
            //add value
            i++;
            NSString *item = [listItems objectAtIndex:i];
            if (item != nil && ![item isEqualToString:@""] && ![item hasPrefix:@"#"]) {
                //add security
                if ([[WLYPlayerUtils getToken] length] > 0) {
                    if ([item rangeOfString:@"?"].location != NSNotFound) {
                        [item stringByAppendingFormat:@"&%@", [WLYPlayerUtils getToken]];
                    }else{
                        [item stringByAppendingFormat:@"?%@", [WLYPlayerUtils getToken]];
                    }
                }
                //add line
                [retString appendFormat:@"%@&url=%@&curExt=m3u8\r\n", prefix, [HttpAgent encodeString:[self toAbsUrl:item location:host]]];
            }
        }else if ([tagItem hasPrefix:@"#EXTINF"]){
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
            //get duration
            NSArray* tList = [tagItem componentsSeparatedByString:@":"];
            double duration = [[tList objectAtIndex:1] doubleValue];
            
            //add value
            i++;
            NSString *item = [listItems objectAtIndex:i];
            if (item != nil && ![item isEqualToString:@""] && ![item hasPrefix:@"#"]) {
                NSString *absUrl = [self toAbsUrl:item location:host];
                //add security
                if ([[WLYPlayerUtils getToken] length] > 0) {
                    if ([absUrl rangeOfString:@"?"].location != NSNotFound) {
                        [absUrl stringByAppendingFormat:@"&%@", [WLYPlayerUtils getToken]];
                    }else{
                        [absUrl stringByAppendingFormat:@"?%@", [WLYPlayerUtils getToken]];
                    }
                }
                Security *sc = [Security getInstance];
                absUrl = [sc Security_GetUrl:absUrl WithAlgid:sc.cdnAlgid];
                //                WLYLogVerbose(@"%s, ret = %@", __func__, absUrl);
                
                if (isVod) {
                    //
                    absUrl = [NSString stringWithFormat:@"%@&url=%@&duration=%f&curExt=ts", prefix, [HttpAgent encodeString:absUrl], duration];
                }else {
                    //
                    absUrl = [NSString stringWithFormat:@"%@&url=%@&curExt=ts", prefix, [HttpAgent encodeString:absUrl]];
                }
                //add line
                [retString appendFormat:@"%@\r\n",absUrl];
            }
        }else if ([tagItem hasPrefix:@"#EXT-X-ENDLIST"]){
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
        }else{
            //add tag
            [retString appendFormat:@"%@\r\n", tagItem];
        }
    }
    return retString;
}

//to
- (NSString *) toAbsUrl:(NSString *)url location:(NSString *)location {
    if (url == nil && [url isEqualToString:@""]) {
        return @"";
    }
    
    NSString *ret = url;
    if ([ret hasPrefix:@"http"]) {
        return ret;
    } else {
        if ([ret hasPrefix:@"/"]) {
            ret = [[location substringWithRange:NSMakeRange(0, [[location substringWithRange:NSMakeRange(8, [location length] -8)] rangeOfString:@"/"].location + 8)] stringByAppendingString:ret];
        }else {
            ret = [location stringByAppendingString:ret];
        }
    }
    return ret;
}

//get domain from url
- (NSString *)getDomainFromUrl:(NSString *)url {
    if (url == nil && [url isEqualToString:@""]) {
        return @"";
    }
    
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
    return ret;
}

- (void)readStreamFromData:(NSData *)data {
    
    NSInputStream *inputStream = [[NSInputStream alloc]initWithData:data];
    [inputStream open];
    NSInteger maxLength = 1024;
    uint8_t readBuffer [maxLength];
    //是否已经到结尾标识
    BOOL endOfStreamReached = NO;
    // NOTE: this tight loop will block until stream ends
    while (! endOfStreamReached)
    {
        NSInteger bytesRead = [inputStream read: readBuffer maxLength:maxLength];
        if (bytesRead == 0)
        {//文件读取到最后
            endOfStreamReached = YES;
        }
        else if (bytesRead == -1)
        {//文件读取错误
            endOfStreamReached = YES;
        }
        else
        {
//            NSString *readBufferString = [[NSString alloc] initWithBytesNoCopy: readBuffer length: bytesRead encoding: NSUTF8StringEncoding freeWhenDone: NO];
            //                                //将字符不断的加载到视图
            //                                [self appendTextToView: readBufferString];
            //                                [readBufferString release];
            endOfStreamReached = NO;
        }
    }
    [inputStream close];
}

static NSString *const kHTTPAgentCharacters = @" @#$%^&+=\\|[]{}:;\"?/<>,";

//URLEncode
+ (NSString *)encodeString:(NSString *)unencodedString {
    
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";
    
    NSCharacterSet *set = [[NSCharacterSet characterSetWithCharactersInString:kHTTPAgentCharacters] invertedSet];
    NSString *encodedString = [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:set];
    
    return encodedString;
}

//URLDEcode
+ (NSString *)decodeString:(NSString *)encodedString {
    
    NSString *decodedString = [encodedString stringByRemovingPercentEncoding];
    
    return decodedString;
}

@end
