//
//  WVRApiSignatureGenerator.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/3/3.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "WVRApiSignatureGenerator.h"
#import "NSDictionary+WVRNetworkingMethods.h"
#import "NSArray+WVRNetworkingMethods.h"
#import <CommonCrypto/CommonDigest.h>

@implementation WVRApiSignatureGenerator
#pragma mark - public methods
+ (NSString *)signGetWithSigParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey
{
    NSString *sigString = [allParams CT_urlParamsStringSignature:YES];
    return [self encryptByMD5:[NSString stringWithFormat:@"%@%@", sigString, privateKey]];
}

+ (NSString *)signRestfulGetWithAllParams:(NSDictionary *)allParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey
{
    NSString *part1 = [NSString stringWithFormat:@"%@/%@", apiVersion, methodName];
    NSString *part2 = [allParams CT_urlParamsStringSignature:YES];
    NSString *part3 = privateKey;
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@", part1, part2, part3];
    return [self encryptByMD5:beforeSign];
}

+ (NSString *)signPostWithApiParams:(NSDictionary *)apiParams privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey
{
    NSMutableDictionary *sigParams = [NSMutableDictionary dictionaryWithDictionary:apiParams];
    sigParams[@"api_key"] = publicKey;
    NSString *sigString = [sigParams CT_urlParamsStringSignature:YES];
    return [self encryptByMD5:[NSString stringWithFormat:@"%@%@", sigString, privateKey]];
}

+ (NSString *)signRestfulPOSTWithApiParams:(id)apiParams commonParams:(NSDictionary *)commonParams methodName:(NSString *)methodName apiVersion:(NSString *)apiVersion privateKey:(NSString *)privateKey
{
    NSString *part1 = [NSString stringWithFormat:@"%@/%@", apiVersion, methodName];
    NSString *part2 = [commonParams CT_urlParamsStringSignature:YES];
    NSString *part3 = nil;
    if ([apiParams isKindOfClass:[NSDictionary class]]) {
        part3 = [(NSDictionary *)apiParams CT_jsonString];
    } else if ([apiParams isKindOfClass:[NSArray class]]) {
        part3 = [(NSArray *)apiParams AX_jsonString];
    } else {
        return @"";
    }
    
    NSString *part4 = privateKey;
    
    NSString *beforeSign = [NSString stringWithFormat:@"%@%@%@%@", part1, part2, part3, part4];
    return [self encryptByMD5:beforeSign];
}

+ (NSString *)signPostWithApiParamsValues:(NSString *)sigString privateKey:(NSString *)privateKey publicKey:(NSString *)publicKey
{
    return [self encryptByMD5:[NSString stringWithFormat:@"%@%@", sigString, privateKey] md5Suffix:@""];
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
@end
