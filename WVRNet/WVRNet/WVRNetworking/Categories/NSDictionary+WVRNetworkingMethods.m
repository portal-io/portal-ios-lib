//
//  NSDictionary+WVRNetworkingMethods.m
//  WhaleyVR
//
//  Created by Wang Tiger on 17/2/17.
//  Copyright © 2017年 Snailvr. All rights reserved.
//

#import "NSDictionary+WVRNetworkingMethods.h"
#import "NSArray+WVRNetworkingMethods.h"

@implementation NSDictionary (WVRNetworkingMethods)

- (NSString *)CT_urlParamsStringSignature:(BOOL)isForSignature
{
    NSArray *sortedArray = [self CT_transformedUrlParamsArraySignature:isForSignature];
    return [sortedArray AX_paramsString];
}

- (NSString *)CT_urlParamsValuesStringSignature:(BOOL)isForSignature
{
    NSString * result= [self CT_transformedUrlParamsValuesArraySignature:isForSignature];
    return result;
}

/** Convert dictionary to JSON */
- (NSString *)CT_jsonString
{
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:NULL];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

/** Convert params */
- (NSArray *)CT_transformedUrlParamsArraySignature:(BOOL)isForSignature
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            //CFURLCreateStringByAddingPercentEscapes deprecated
//            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
            [result addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }
    }];
    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return sortedResult;
}

- (NSString *)CT_transformedUrlParamsValuesArraySignature:(BOOL)isForSignature
{
    __block NSString *result = [[NSString alloc] init];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        if (![obj isKindOfClass:[NSString class]]) {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        if (!isForSignature) {
            obj = [obj stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
            //CFURLCreateStringByAddingPercentEscapes deprecated
            //            obj = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,  (CFStringRef)obj,  NULL,  (CFStringRef)@"!*'();:@&;=+$,/?%#[]",  kCFStringEncodingUTF8));
        }
        if ([obj length] > 0) {
           result = [result stringByAppendingString:obj];
        }
    }];
//    NSArray *sortedResult = [result sortedArrayUsingSelector:@selector(compare:)];
    return result;
}
@end
