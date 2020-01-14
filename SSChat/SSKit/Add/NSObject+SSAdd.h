//
//  NSObject+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface NSObject (DEAdd)


//给个随机数
+(NSInteger)getRandom:(NSInteger)max;

//输出对象
-(void)cout;
//判断字符串是否是整型
+ (BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string;

//判断字符串是否为空
-(BOOL)isEmptyStr;
-(BOOL)isNUllStr;
-(NSString *)emptyStr;

//返回两个数中较大的数
+(NSInteger)getMaxNum:(NSInteger)one other:(NSInteger)two;
//返回两个数中较小的数
+(NSInteger)getMinNum:(NSInteger)one other:(NSInteger)two;

//发送通知
-(void)sendNotifCation:(NSString *)key;

//发送携带信息的通知
-(void)sendNotifCation:(NSString *)key data:(NSDictionary *)dic;

//释放通知
-(void)deleteNotifCation;

//返回日期的时间差 (单位:天)
+(double)FromTheNumberOfDaysOne:(NSString *)string1
                        daysTwo:(NSString *)string2;




/**
 根据字符串 限制宽度 字号 行距 得到自适应面积
 
 @param string 布局用的字符串
 @param font 限制了字体大小
 @param spacing 限制了行距
 @return 返回自适应面积
 */
+(CGRect)getRectWith:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(CGFloat)spacing Row:(CGFloat)row;


/**
 根据可变字符串 得到自适应面积

 @param string 可变字符串
 @param width 固定宽度
 @return 返回面积
 */
+(CGRect)getRectWith:(NSMutableAttributedString *)string width:(CGFloat)width;

//获取可变字体
+(NSAttributedString *)getAtString:(NSString *)string Spacing:(CGFloat)spacing Row:(CGFloat)row Font:(CGFloat)font;


//适应不同设备的数据
+(CGFloat)getNumi5:(CGFloat)i5 i6:(CGFloat)i6 iPlus:(CGFloat)iPlus iPX:(CGFloat)iPX;






@end
