//
//  NSString+Extend.m
//  WhaleyVR
//
//  Created by Bruce on 2016/10/26.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "NSString+Extend.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (Extend)

#pragma mark - JSON
- (NSString *)stringToJson {
    
    if (self.length < 1) {
        return nil;
    }
    
    if (![NSJSONSerialization isValidJSONObject:self]) {
        return nil;
    }
    
    NSError *error = nil;
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if (error != nil) {
        return nil;
        
    } else {
        NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        return string;
    }
}

- (NSDictionary *)stringToDic {
    
    if (self.length < 1) {
        return nil;
    }
    
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error = nil;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"stringToDic_error: %@", error);
        return nil;
    }
    
    return dic;
}

// "!*'();:@&=+$,/?%#[] "

#pragma mark - getParamFromURL

- (NSDictionary *)stringToParamDic {
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    NSArray *paramArr = [self componentsSeparatedByString:@"&"];
    for (NSString *str in paramArr) {
        NSArray *param = [str componentsSeparatedByString:@"="];
        if (param.count == 2) {
            NSString *key = [param firstObject];
            NSString *value = [param lastObject];
            [params setValue:value forKey:key];
        }
    }
    
    return [params copy];
}


/// 字符串转时间 "yyyy-MM-dd HH:mm:ss"
- (NSDate *)dateWithDefaultFormat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [formatter dateFromString:self];
}

- (NSDate *)chinaDateWithDefaultFormat {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *date = [formatter dateFromString:self];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

/// 字符串转时间
- (NSDate *)dateWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter dateFromString:self];
}

/// 字符串转中国时间
- (NSDate *)chinaDateWithFormat:(NSString *)format {
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    NSDate *date = [formatter dateFromString:self];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

- (NSString *)transformZoomURLToSize:(CGSize)size {
    
    NSString *url = self;
    
    if (url.length < 1) { return url; }
    
    NSMutableArray *array = [[url componentsSeparatedByString:@"/"] mutableCopy];
    
    float scale = [UIScreen mainScreen].scale;
    
    NSString *originHeight = [array lastObject];
    float imageHeight = [originHeight floatValue];
    [array removeLastObject];
    NSString *originWidth = [array lastObject];
    float imageWidth = [originWidth floatValue];
    [array removeLastObject];
    
    NSString *tmp = [array lastObject];
    if (![tmp isEqualToString:@"zoom"]) { return url; }     // 无法完成服务端缩放
    
    float width = size.width;
    float height = size.height;
    
    float widthScale;
    float heightScale;
    
    if (imageWidth > imageHeight) {     // 最小缩放比
        
        widthScale = heightScale = imageHeight /height;
    } else {
        widthScale = heightScale = imageWidth /width;
    }
    
    float finalWidth  = ceilf(imageWidth/widthScale * scale);       // 缩放过后宽高
    float finalHeight = ceilf(imageHeight/heightScale * scale);
    
    // 无需缩放
    if (finalWidth > imageWidth || finalHeight > imageHeight) { return url; }
    
    
    long strLength = url.length - originHeight.length - originWidth.length - 1;
    NSString *prefixStr = [url substringToIndex:strLength];
    
    NSString *finalStr = [NSString stringWithFormat:@"%@%d/%d", prefixStr, (int)finalWidth, (int)finalHeight];
    
    return finalStr;
}

- (NSString *)lowerMD5 {
    
    const char *str = [self UTF8String];
    if (str == NULL) {
        str = "";
    }
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *finalStr = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10],
                          r[11], r[12], r[13], r[14], r[15]];
    
    return finalStr;
}

- (NSString *)base64String {
    
    NSString *str = self;
    
    if (str.length == 0) { return str; }
    
    NSData *dataFromBase64String = [[NSData alloc]
                                    initWithBase64EncodedString:str options:kNilOptions];
    NSString *base64DecodedStr = [[NSString alloc]
                               initWithData:dataFromBase64String encoding:NSUTF8StringEncoding];
    
    return base64DecodedStr;
}

- (NSString *)base64Encoded {
    
    NSString *str = self;
    
    if (str.length == 0) { return str; }
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *base64EncodedStr = [data base64EncodedStringWithOptions:kNilOptions];
    
    return base64EncodedStr;
}

- (NSString *)reverseString {
    
    NSString *str = self;
    
    if (str.length == 0) { return str; }
    
    NSMutableString *reverseString = [NSMutableString string];
    for (int i = 0 ; i < str.length; i ++) {
        
        unichar c = [str characterAtIndex:str.length - i - 1];
        [reverseString appendFormat:@"%c", c];
    }
    return reverseString;
}

- (NSString *)customEncrypt {
    
    NSString *str = self;
    
    if (str.length == 0) { return str; }
    
    NSString *base64Encoded = [str base64Encoded];
    NSString *reverseString = [base64Encoded reverseString];

    return reverseString;
}

- (NSString *)customDecrypt {
    
    NSString *str = self;
    
    if (str.length == 0) { return str; }
    
    NSString *reverseString = [str reverseString];
    NSString *base64Decoded = [reverseString base64String];
    
    return base64Decoded;
}

@end
