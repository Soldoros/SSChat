//
//  NSTimer+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.


#import "NSTimer+SSAdd.h"

@implementation NSTimer (DEAdd)

+(NSString *)getLocationTimeStamp{
    
    return [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
}


//获取当前时间 格式自己定
+(NSString *)getLocationTime{
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [dateformatter stringFromDate:[NSDate date]];
    
}

//时间转换成时间戳 格式可以定
+(NSString *)getStampWithTime:(NSString *)time stamp:(NSString *)format{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    NSDate *lastDate = [formatter dateFromString:time];
    long firstStamp = [lastDate timeIntervalSince1970];
    
    return  [NSString stringWithFormat:@"%ld",firstStamp];
}


//时间转换成时间戳 YYYY-MM-dd  HH:mm:ss
+(NSString *)getStampWithTime:(NSString *)time{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate *lastDate = [formatter dateFromString:time];
    long firstStamp = [lastDate timeIntervalSince1970];
    
    return  [NSString stringWithFormat:@"%ld",firstStamp];
}



//时间戳转换成时间
+ (NSString *)getTimeWithTimeStamp:(long long)timeStamp{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    
    // 毫秒值转化为秒 /1000
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


//时间戳转换成时间  并且能设置格式
+ (NSString *)getTimeWithStamp:(NSString *)stamp  forMat:(NSString *)forMat{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:forMat];
    
    // 毫秒值转化为秒 /1000
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[stamp doubleValue]];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}


//聊天时间显示
+ (NSString *)getChatTimeStr:(long long)timestamp
{
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


//时间戳转换成年月日 星期
+ (NSString *)getWeekTimeStr:(NSString *)timestamp{
    // 创建日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // 获取当前时间
    NSDate *currentDate = [NSDate date];
    
    // 获取当前时间的年、月、日。利用日历
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:currentDate];
    NSInteger currentYear = components.year;
    NSInteger currentMonth = components.month;
    NSInteger currentDay = components.day;
    
    // 获取消息发送时间的年、月、日
    NSDate *msgDate = [NSDate dateWithTimeIntervalSince1970:[timestamp longLongValue]];
    components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth|NSCalendarUnitDay fromDate:msgDate];
    
    NSString *msgYear = [NSString stringWithFormat:@"%.0ld",components.year];
    NSString *msgMonth = [NSString stringWithFormat:@"%.0ld",components.month];
    NSString *msgDay = [NSString stringWithFormat:@"%.0ld",components.day];

    NSString *week = [self getWeekDayFordate:[timestamp longLongValue]];
    
    return makeMoreStr(msgMonth,@"月",msgDay,@"日 ",week,nil);
}


//根据时间戳获取星期几
+ (NSString *)getWeekDayFordate:(long long)data
{
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSDate *newDate = [NSDate dateWithTimeIntervalSince1970:data];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:newDate];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}


//"08-10 晚上08:09:41.0" ->
//"昨天 上午10:09"或者"2012-08-10 凌晨07:09"
+ (NSString *)changeTheDateString:(NSString *)Str
{
    NSString *subString = [Str substringWithRange:NSMakeRange(0, 19)];
    NSDate *lastDate = [NSDate dateFromString:subString withFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:lastDate];
    lastDate = [lastDate dateByAddingTimeInterval:interval];
    
    NSString *dateStr;  //年月日
    NSString *period;   //时间段
    NSString *hour;     //时
    
    if ([lastDate year]==[[NSDate date] year]) {
        NSInteger days = [NSDate daysOffsetBetweenStartDate:lastDate endDate:[NSDate date]];
        if (days <= 2) {
            dateStr = [lastDate stringYearMonthDayCompareToday];
        }else{
            dateStr = [lastDate stringMonthDay];
        }
    }else{
        dateStr = [lastDate stringYearMonthDay];
    }
    
    
    if ([lastDate hour]>=5 && [lastDate hour]<12) {
        period = @"AM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }else if ([lastDate hour]>=12 && [lastDate hour]<=18){
        period = @"PM";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else if ([lastDate hour]>18 && [lastDate hour]<=23){
        period = @"Night";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]-12];
    }else{
        period = @"Dawn";
        hour = [NSString stringWithFormat:@"%02d",(int)[lastDate hour]];
    }
    return [NSString stringWithFormat:@"%@ %@ %@:%02d",dateStr,period,hour,(int)[lastDate minute]];
}



+ (NSTimeInterval)compareTwoTime:(long long)time1 time2:(long long)time2{
    NSTimeInterval balance = llabs(time2- time1)/1000;
  
    return balance/60;
}


//秒 转换成  天 时  分 秒
+(NSString *)getTimeWithString:(long)timeNumber{
    long day = timeNumber / (60 * 60 * 24);
    long hours = (timeNumber-day * 60 * 60 * 24)/(60 * 60);
    long minutes = (timeNumber-day*(60 * 60 * 24)-hours*60*60) /60;
    long seconds = timeNumber-day*(60 * 60 * 24)-hours*60*60-minutes*60;
    
    NSString *dayStr = [NSString stringWithFormat:@"%ld",day];
    NSString *hoursStr = [NSString stringWithFormat:@"%ld",hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%ld",minutes];
    NSString *secondsStr = [NSString stringWithFormat:@"%ld",seconds];
    
    if(day==0 && hours==0){
        return makeMoreStr(minutesStr,@"分",secondsStr,@"秒",nil);
    }else if (day==0){
        return makeMoreStr(hoursStr,@"小时",minutesStr,@"分",secondsStr,@"秒",nil);
    }else{
        return makeMoreStr(dayStr,@"天",hoursStr,@"小时",minutesStr,@"分",secondsStr,@"秒",nil);
    }
}











@end
