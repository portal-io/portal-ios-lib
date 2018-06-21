//
//  WVRBaseRequest.m
//  VRManager
//
//  Created by Wang Tiger on 16/6/15.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "WVRBaseRequest.h"
#import <CommonCrypto/CommonDigest.h>

NSString * const kHttpParams_storapi_timestamp = @"timestamp";

@implementation WVRBaseRequest

- (NSString *)signParamsMD5
{
    NSArray* keys = [self.bodyParams allKeys];
    NSArray* newKeys = [keys sortedArrayUsingSelector:@selector(compare:)];
    NSString * keyStr = @"";
    for (NSString * curKey in newKeys) {
        keyStr = [keyStr stringByAppendingString:curKey];
        keyStr = [keyStr stringByAppendingString:@"="];
        keyStr = [keyStr stringByAppendingString:self.bodyParams[curKey]];
        keyStr = [keyStr stringByAppendingString:@"&"];
    }
    keyStr = [keyStr substringToIndex:keyStr.length - 1];
    NSString * resultMD5Str = [WVRBaseRequest encryptByMD5:keyStr];
    return resultMD5Str;
}

#define APP_MD5_SUFFIX (@"WHALEYVR_SNAILVR_AUTHENTICATION")

// 默认MD5后缀为 WHALEYVR_SNAILVR_AUTHENTICATION
+ (NSString *)encryptByMD5:(NSString *)str
{
    return [self encryptByMD5:str md5Suffix:APP_MD5_SUFFIX];
}

+ (NSString *)encryptByMD5:(NSString *)str md5Suffix:(NSString *)md5Suffix
{
    NSString * srcStr = [str stringByAppendingString:md5Suffix];
    const char *cStr = [srcStr UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    
    NSString *hexStr = @"";
    for (int i = 0; i < 16; i ++)
    {
        //        NSString *newHexStr = [NSString stringWithFormat:@"%x",(result[i]&0xff)|0x100]; // 16进制数
        NSString *newHexStr = [NSString stringWithFormat:@"%02x", (result[i])]; // 16进制数
        if ([newHexStr length] == 1) {
            hexStr = [NSString stringWithFormat:@"%@0%@", hexStr, newHexStr];
        } else {
            hexStr = [NSString stringWithFormat:@"%@%@", hexStr, newHexStr];
        }
    }
    return hexStr;
}

- (NSString *)getActionUrl
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

- (NSString *)getHost
{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"You must override %@ in a subclass", NSStringFromSelector(_cmd)]
                                 userInfo:nil];
}

@end
