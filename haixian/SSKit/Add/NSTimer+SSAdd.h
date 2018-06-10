//
//  NSTimer+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (DEAdd)

//获取当前时间戳
+(NSString *)getLocationTimeStamp;

//获取当前时间 格式自己定
+(NSString *)getLocationTime;


//时间转换成时间戳
+(NSString *)getStampWithTime:(NSString *)time;

//时间转换成时间戳 YYYY-MM-dd
+(NSString *)getStampWithTime:(NSString *)time stamp:(NSString *)format;
    
//时间戳转换成时间
+ (NSString *)getTimeWithTimeStamp:(long long)timeStamp;

//时间戳转换成时间  并且能设置格式
+ (NSString *)getTimeWithStamp:(NSString *)stamp  forMat:(NSString *)forMat;


//聊天时间显示
+ (NSString *)getChatTimeStr:(long long)timestamp;

//时间戳转换成年月日 星期
+ (NSString *)getWeekTimeStr:(NSString *)timestamp;


+ (NSString *)changeTheDateString:(NSString *)Str;


+ (NSTimeInterval)compareTwoTime:(long long)time1 time2:(long long)time2;

//秒 转化成  天  时  分  秒
+(NSString *)getTimeWithString:(long)timeNumber;



@end
