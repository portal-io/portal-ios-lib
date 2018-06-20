//
//  NSDictionary+Extension.h
//  BestPayWealth
//
//  Created by LiuBruce on 15/9/22.
//  Copyright © 2015年 BestPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

/// 将字典转为JSON字符串
- (NSString *)toJsonString;

/// 将字典转为JSON字符串 PrettyPrinted
- (NSString *)toJsonStringPretty;

/// 将参数字典转化为字符串  请求参数转换已细分为以下两个方法
//- (NSString *)parseParams;

/// 将参数字典转化为字符串(UTF8编码)
- (NSString *)parseGETParams;

/// 将参数字典转化为2进制流(UTF8编码)
- (NSData *)parsePOSTParams;

@end
