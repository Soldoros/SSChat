//
//  NSObject+SSAdd.m
//  SSChatView
//
//  Created by soldoros on 2018/10/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "NSObject+SSAdd.h"

@implementation NSObject (SSAdd)


//根据字符串 限制宽度 字号 行距  纵间距 得到自适应面积
+(CGRect)getRectWith:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(CGFloat)spacing Row:(CGFloat)row{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = spacing;
    
    CGSize constraintSize = CGSizeMake(width, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |
    NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attributes = @{NSFontAttributeName: font ,NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(row)};
    
    CGRect rect = [string boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    
    
    return rect;
}


//根据可变字符串 限制宽度 字号 行距  纵间距 得到自适应面积
+(CGRect)getRectWith:(NSMutableAttributedString *)string width:(CGFloat)width{
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine;
    
    CGRect rect = [string boundingRectWithSize:size options:options context:NULL];
    
    return rect;
}

@end
