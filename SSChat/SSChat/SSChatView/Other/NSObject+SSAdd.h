//
//  NSObject+SSAdd.h
//  SSChatView
//
//  Created by soldoros on 2018/10/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSObject (SSAdd)


/**
 根据字符串 限制宽度 字号 行距  纵间距 得到自适应面积

 @param string 字符串
 @param width 最大宽度
 @param font 字号
 @param spacing 行距
 @param row 纵间距
 @return 返回rect
 */
+(CGRect)getRectWith:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(CGFloat)spacing Row:(CGFloat)row;


/**
 根据字符串 限制宽度 字号 行距  纵间距 得到自适应面积

 @param string 可变字符串
 @param width 限宽
 @return 返回文本rect
 */
+(CGRect)getRectWith:(NSMutableAttributedString *)string width:(CGFloat)width;

@end

