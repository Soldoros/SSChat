//
//  NSTimer+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (SSAdd)

//获取当前时间的时间戳
+(long)getLocationTimeStamp;

//获取当前时间(YYYY-MM-dd HH:mm:ss)
+(NSString *)getLocationTime;

//时间(YYYY-MM-dd HH:mm:ss) 转换成时间戳
+(long)getStampWithTime:(NSString *)time;

//时间戳转换成时间(YYYY-MM-dd HH:mm:ss)
+ (NSString *)getTimeWithTimeStamp:(long)timeStamp;

//聊天时间显示
+ (NSString *)getChatTimeStr:(long)timestamp;

//聊天时间显示2
+ (NSString *)getChatTimeStr2:(long)timestamp;

//两个时间戳的时间差(秒)
+ (NSTimeInterval)CompareTwoTime:(long)time1 time2:(long)time2;

//两个时间(YYYY-MM-dd HH:mm:ss) 的时间差(秒)
+ (NSTimeInterval)CompareTwoTimer:(NSString *)timer1 time2:(NSString *)timer2;


@end
