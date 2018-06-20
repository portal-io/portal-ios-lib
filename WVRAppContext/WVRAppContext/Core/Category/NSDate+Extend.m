//
//  NSDate+Extend.m
//  WhaleyVR
//
//  Created by Snailvr on 16/9/8.
//  Copyright © 2016年 Snailvr. All rights reserved.
//

#import "NSDate+Extend.h"

@implementation NSDate (Extend)

/// 本地当前时间
+ (NSDate *)localDate {
    
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone systemTimeZone];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

/// 中国时间
+ (NSDate *)chinaDate {
    
    NSDate *date = [NSDate date];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

//[dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]]

// 时间戳转时间
+ (NSDate *)stringToDate:(NSString *)dateStr {
    
    if (dateStr.length < 10) {
        return nil;
    }
    
    NSTimeInterval _interval = [[dateStr substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    return date;
}

// 时间戳转中国时间
+ (NSDate *)stringToChinaDate:(NSString *)dateStr {
    
    if (dateStr.length < 10) {
        return nil;
    }
    
    NSTimeInterval _interval = [[dateStr substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    
    return localDate;
}

- (NSString *)dayweek {
    
    NSString *weekDay;
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:self];
    
    long weekNumber = [comps weekday];
    
    switch (weekNumber) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
            
        default:
            break;
    }
    
    return weekDay;
}

- (NSInteger)year {
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:self];
    
    long y = [comps year];
    
    return y;
}

- (NSInteger)month {
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitMonth;
    comps = [calendar components:unitFlags fromDate:self];
    
    long m = [comps month];
    
    return m;
}

- (NSInteger)day {
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitDay;
    comps = [calendar components:unitFlags fromDate:self];
    
    long d = [comps day];
    
    return d;
}

- (NSInteger)hour {
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitHour;
    comps = [calendar components:unitFlags fromDate:self];
    
    long h = [comps hour];
    
    return h;
}

- (NSInteger)minute {
    
    // 中国阳历
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitMinute;
    comps = [calendar components:unitFlags fromDate:self];
    
    long m = [comps minute];
    
    return m;
}

- (NSInteger)second {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitSecond;
    comps = [calendar components:unitFlags fromDate:self];
    
    long s = [comps second];
    
    return s;
}

// 获取基本信息 年月日星期几
- (NSArray *)getDateInfo {
    
    NSString *weekDay;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    comps = [calendar components:unitFlags fromDate:self];
    
    NSString *year = [NSString stringWithFormat:@"%d", (int)[comps year]];
    
    int m = (int)[comps month];
    NSString *month = [NSString stringWithFormat:@"%02d", m];
    
    int d = (int)[comps day];
    NSString *day = [NSString stringWithFormat:@"%02d", d];
    
    long weekNumber = [comps weekday];
    
    switch (weekNumber) {
        case 1:
            weekDay = @"星期日";
            break;
        case 2:
            weekDay = @"星期一";
            break;
        case 3:
            weekDay = @"星期二";
            break;
        case 4:
            weekDay = @"星期三";
            break;
        case 5:
            weekDay = @"星期四";
            break;
        case 6:
            weekDay = @"星期五";
            break;
        case 7:
            weekDay = @"星期六";
            break;
            
        default:
            break;
    }
    
    return @[ year, month, day, weekDay ];
}

/// 日期转字符串 "yyyy-MM-dd HH:mm:ss"
- (NSString *)dateToString {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    return [dateFormatter stringFromDate:self];
}

+ (NSString *)monthNumberToString:(NSInteger)month {
    
    switch (month) {
//            一月 Jan.January
        case 1:
            return @"Jan";
            break;
//            二月 Feb.February
        case 2:
            return @"Feb";
            break;
//            三月 Mar.March
        case 3:
            return @"Mar";
            break;
//            四月 Apr.April
        case 4:
            return @"Apr";
            break;
//            五月 May.May
        case 5:
            return @"May";
            break;
//            六月 June.June
        case 6:
            return @"Jun";
            break;
//            七月 July.July
        case 7:
            return @"Jul";
            break;
//            八月 Aug.Aguest
        case 8:
            return @"Aug";
            break;
//            九月 Sept.September
        case 9:
            return @"Sep";
            break;
//            十月 Oct.October
        case 10:
            return @"Oct";
            break;
//            十一月 Nov.November
        case 11:
            return @"Nov";
            break;
//            十二月 Dec.December
        case 12:
            return @"Dec";
            break;
    }
    
    return @"";
}

+ (long)getTimeDifferenceFormTimeInterval:(NSTimeInterval)timeInterval {
    
    NSDate *nowDate  = [NSDate date];
    
    NSTimeInterval _interval = timeInterval;
    if (timeInterval > 100000000000) {
        _interval = timeInterval / 1000;
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    
    /// 都转为东八区时间
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned int unitFlags = NSCalendarUnitDay;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:localDate toDate:nowDate options:0];
    long day = [comps day];
    
    return day;
}

+ (long)getTimeDifferenceFormDate:(NSDate *)date {
    
    NSDate *nowDate = [NSDate date];
    
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];;
    NSInteger interval = [timeZone secondsFromGMTForDate:date];
    
    /// 都转为东八区时间
    NSDate *localDate = [date dateByAddingTimeInterval:interval];
    nowDate = [nowDate dateByAddingTimeInterval:interval];
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps = [gregorian components:NSCalendarUnitDay fromDate:localDate toDate:nowDate options:0];
    long day = [comps day];
    
    return day;
}

@end
