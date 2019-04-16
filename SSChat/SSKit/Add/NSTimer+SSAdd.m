//
//  NSTimer+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.


#import "NSTimer+SSAdd.h"

@implementation NSTimer (SSAdd)

//获取当前时间的时间戳
+(long)getLocationTimeStamp{
    
    return (long)[[NSDate date] timeIntervalSince1970];
}

//获取当前时间(YYYY-MM-dd HH:mm:ss)
+(NSString *)getLocationTime{
    return [NSTimer getTimeWithTimeStamp:[NSTimer getLocationTimeStamp]];
}

//时间(YYYY-MM-dd HH:mm:ss) 转换成时间戳
+(long)getStampWithTime:(NSString *)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *lastDate = [formatter dateFromString:time];
    long long firstStamp = [lastDate timeIntervalSince1970];
    return firstStamp;
    
}

//时间戳转换成时间(YYYY-MM-dd HH:mm:ss)
+ (NSString *)getTimeWithTimeStamp:(long)timeStamp{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒 /1000
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


//聊天时间显示
+ (NSString *)getChatTimeStr:(long)timestamp{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *currentDate = [NSDate date];
    
    // 获取当前时间的年、月、日
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:timestamp/1000.0];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    CGFloat msgYear = components.year;
    CGFloat msgMonth = components.month;
    CGFloat msgDay = components.day;
    
    // 判断
    NSDateFormatter *dateFmt = [[NSDateFormatter alloc] init];
    dateFmt.timeZone = [NSTimeZone timeZoneForSecondsFromGMT:8];
    if (currentYear == msgYear && currentMonth == msgMonth && currentDay == msgDay) {
        //今天
        dateFmt.dateFormat = @"今天 HH:mm";
    }else if (currentYear == msgYear && currentMonth == msgMonth && currentDay-1 == msgDay ){
        //昨天
        dateFmt.dateFormat = @"昨天 HH:mm";
    }else{
        //昨天以前
        dateFmt.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    
    return [dateFmt stringFromDate:msgDate];
}


//聊天时间
+ (NSString *)getChatTimeStr2:(long)timestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.timeStyle = NSDateFormatterShortStyle;
    formatter.dateStyle = NSDateFormatterFullStyle;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    NSString *dateString = [formatter stringFromDate:date];
    
    NSString *chatTime =  [dateString substringFromIndex:11];
    return chatTime;
    
}


//两个时间戳的时间差(秒)
+(NSTimeInterval)CompareTwoTime:(long)time1 time2:(long)time2{
    NSTimeInterval balance = llabs(time2- time1);
    
    return balance;
}

//两个时间(YYYY-MM-dd HH:mm:ss) 的时间差(秒)
+(NSTimeInterval)CompareTwoTimer:(NSString *)timer1 time2:(NSString *)timer2{
    long long time1 = [NSTimer getStampWithTime:timer1];
    long long time2 = [NSTimer getStampWithTime:timer2];
    return [NSTimer CompareTwoTime:time1 time2:time2];
}






@end
