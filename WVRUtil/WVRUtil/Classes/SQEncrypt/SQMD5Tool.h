//
//  SQMD5Tool.h
//  youthGo
//
//  Created by qbshen on 16/5/23.
//  Copyright © 2016年 qbshen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQMD5Tool : NSObject

/// 默认MD5后缀为 WHALEYVR_SNAILVR_AUTHENTICATION
+ (NSString *)encryptByMD5:(NSString *)str;

/**
 MD5加盐签名 md5Suffix为key

 @param str 要加签名的string
 @param md5Suffix 盐（salt，key）
 @return sign string
 */
+ (NSString *)encryptByMD5:(NSString *)str md5Suffix:(NSString *)md5Suffix;

@end
