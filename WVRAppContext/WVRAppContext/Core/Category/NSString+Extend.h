//
//  NSString+Extend.h
//  WhaleyVR
//
//  Created by Bruce on 2016/10/26.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extend)

#pragma mark - JSON
- (NSString *)stringToJson;

- (NSDictionary *)stringToDic;

#pragma mark - getParamFromURL
- (NSDictionary *)stringToParamDic;

/// 字符串转时间 "yyyy-MM-dd HH:mm:ss"
- (NSDate *)dateWithDefaultFormat;

/// 字符串转中国时间 "yyyy-MM-dd HH:mm:ss"
- (NSDate *)chinaDateWithDefaultFormat;

/// 字符串转时间
- (NSDate *)dateWithFormat:(NSString *)format;

/// 字符串转中国时间
- (NSDate *)chinaDateWithFormat:(NSString *)format;

/// 带zoom的URL链接转换大小
- (NSString *)transformZoomURLToSize:(CGSize)size;

- (NSString *)lowerMD5;

- (NSString *)base64String;     // decode
- (NSString *)base64Encoded;    // encode

- (NSString *)reverseString;    // 倒序排列

- (NSString *)customEncrypt;    // 自定义加密
- (NSString *)customDecrypt;    // 自定义解密

@end
