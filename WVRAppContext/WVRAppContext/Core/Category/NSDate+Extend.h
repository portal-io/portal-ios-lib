//
//  NSDate+Extend.h
//  WhaleyVR
//
//  Created by Snailvr on 16/9/8.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extend)

@property (nonatomic, readonly, copy  ) NSString  *dayweek;
@property (nonatomic, readonly, assign) NSInteger year;
@property (nonatomic, readonly, assign) NSInteger month;
@property (nonatomic, readonly, assign) NSInteger day;
@property (nonatomic, readonly, assign) NSInteger hour;
@property (nonatomic, readonly, assign) NSInteger minute;
@property (nonatomic, readonly, assign) NSInteger second;


/// 本地当前时间
+ (NSDate *)localDate;

/// 中国时间
+ (NSDate *)chinaDate;

/// 时间戳转时间
+ (NSDate *)stringToDate:(NSString *)dateStr;

/// 时间戳转中国时间
+ (NSDate *)stringToChinaDate:(NSString *)dateStr;

/// 年月日 星期几
- (NSArray *)getDateInfo;

/// 日期转字符串 "yyyy-MM-dd HH:mm:ss"
- (NSString *)dateToString;

/// 月份数字转字符
+ (NSString *)monthNumberToString:(NSInteger)month;

/// 获取时间戳所代表的日期和今天相差几天（东8时区）
+ (long)getTimeDifferenceFormTimeInterval:(NSTimeInterval)timeInterval;

/// 获取date所代表的日期和今天相差几天（东8时区）
+ (long)getTimeDifferenceFormDate:(NSDate *)date;

@end
