//
//  NSDate+Extensions.m
//  LLWeChat
//
//  Created by 谌文 on 17/9/17.
//  Copyright © 2017年 GYJZH. All rights reserved.
//

#import "NSDate+Extensions.h"

static NSInteger SEC_PER_DAY = 24 * 60 * 60;

@implementation NSDate (Extensions)

/*
 * 过去时间距离当前时间的时间间隔的描述,本方法返回长字符串
 * 时间格式为,支持多语言:
 * 1、当天的消息直接显示: HH:MM
 * 2、昨天的消息显示为:  昨天 HH:MM
 * 3、本周内的消息显示为: 星期几 HH:MM ~ Friday HH:MM
 * 4、超过一周的消息显示为: 2016年7月1日 19:20 ~ Jul 12 2016 11:47
 * */
- (NSString *)timeIntervalBeforeNowLongDescription {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    //格式化日期字符串,只保留年、月、日信息
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selfDateFormatString = [dateFormatter stringFromDate:self];
    NSString *nowDateFormatString = [dateFormatter stringFromDate:[NSDate date]];
    
    //当天
    if ([selfDateFormatString isEqualToString:nowDateFormatString]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        return [dateFormatter stringFromDate:self];
    }else {
        //格式化日期,将日期格式化为日期当天的0时0分0秒
        NSDate *selfDateFormatDate = [dateFormatter dateFromString:selfDateFormatString];
        NSDate *nowDateFormatDate = [dateFormatter dateFromString:nowDateFormatString];
        
        NSTimeInterval timeInterval = [nowDateFormatDate timeIntervalSinceDate:selfDateFormatDate];
        
        //昨天
        if (timeInterval == SEC_PER_DAY) {
            [dateFormatter setDateFormat:@"HH:mm"];
            return [NSString stringWithFormat:@"昨天 %@",[dateFormatter stringFromDate:self]];
        }
        //一周内
        else if (timeInterval < 7 * SEC_PER_DAY) {
            [dateFormatter setDateFormat:@"EEEE HH:mm"];
            return [dateFormatter stringFromDate:self];
        }
        //一周以前的时间
        else {
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
            return [dateFormatter stringFromDate:self];
        }
    }
}

/*
 * 过去时间距离当前时间的时间间隔的描述, 本方法返回短字符串
 * 时间格式为:
 * 1、当天的消息直接显示:  HH:MM
 * 2、昨天的消息显示为:    昨天
 * 3、本周内的消息显示为:  星期几 ~ Friday
 * 4、超过一周的消息显示为: 6/16/16
 * */
- (NSString *)timeIntervalBeforeNowShortDescription {
    static NSDateFormatter *dateFormatter;
    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
    }
    
    //格式化日期字符串,只保留年、月、日信息
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *selfDateFormatString = [dateFormatter stringFromDate:self];
    NSString *nowDateFormatString = [dateFormatter stringFromDate:[NSDate date]];
    
    //当天
    if ([selfDateFormatString isEqualToString:nowDateFormatString]) {
        [dateFormatter setDateFormat:@"HH:mm"];
        return [dateFormatter stringFromDate:self];
    } else {
        //格式化日期,将日期格式化为日期当天的0时0分0秒
        NSDate *selfDateFormatDate = [dateFormatter dateFromString:selfDateFormatString];
        NSDate *nowDateFormatDate = [dateFormatter dateFromString:nowDateFormatString];
        
        NSTimeInterval timeInterval = [nowDateFormatDate timeIntervalSinceDate:selfDateFormatDate];
        
        //昨天
        if (timeInterval == SEC_PER_DAY) {
            return @"昨天";
        }
        //一周内
        else if (timeInterval < 7 * SEC_PER_DAY) {
            [dateFormatter setDateFormat:@"EEEE"];
            return [dateFormatter stringFromDate:self];
        }
        //一周以前的时间
        else {
            [dateFormatter setDateFormat:@"M/d/yy"];
            return [dateFormatter stringFromDate:self];
        }
        
    }
}




#pragma  环信 IM 时间戳相关
/**
 * SDK返回的时间戳单位是毫秒,Client使用的时间戳单位是秒
 */
- (double)timeIntervalSince1970InMilliSecond {
    double ret;
    ret = [self timeIntervalSince1970] * 1000;
    
    return ret;
}

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)timeIntervalInMilliSecond {
    NSDate *ret = nil;
    double timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if(timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return ret;
}
@end
