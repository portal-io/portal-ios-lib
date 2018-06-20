//
//  NSDictionary+Extension.m
//  BestPayWealth
//
//  Created by LiuBruce on 15/9/22.
//  Copyright © 2015年 BestPay. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)


- (NSString *)toJsonString {
    
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error) { return nil; }
        
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

- (NSString *)toJsonStringPretty {
    
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
    
    if (error) { return nil; }
    
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return string;
}

/// 将参数字典转化为字符串
- (NSString *)parseParams {
    
    if (self.count < 1) {
        return @"";
    }
    
    NSString *keyValueFormat;
    NSMutableString *result = [NSMutableString string];
    NSDictionary *dict = self;
    
    int count = 1;
    for (NSString *key in dict) {
        
        NSString *symbol = (count < dict.count) ? @"&" : @"";
        
        keyValueFormat = [NSString stringWithFormat:@"%@=%@%@", key, dict[key], symbol];
        [result appendString:keyValueFormat];
        
        count += 1;
    }
    
//    DebugLog(@"\n-------切割线-------\n参数解析结果：%@\n-------切割线-------\n", result);
    return result;
}

/// 将参数字典转化为字符串(UTF8编码)
- (NSString *)parseGETParams {
    
    if (self.count < 1) {
        return @"";
    }
    
    NSString *str = [self parseParams];
    
    NSString *finalStr = [str stringByRemovingPercentEncoding];
    finalStr = [finalStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    return finalStr;
}

/// 将参数字典转化为2进制流(UTF8编码)
- (NSData *)parsePOSTParams {
    
    if (self.count < 1) {
        return [NSData data];
    }
    
    NSString *str = [self parseParams];
    
    return [str dataUsingEncoding:NSUTF8StringEncoding];
}


@end
