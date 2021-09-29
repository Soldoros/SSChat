//
//  UIColor+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DEAdd)


/**
 2048的滑块颜色

 @param number 滑块数字
 @return 返回颜色值
 */
+(UIColor *)setTiledColor:(int)number;


//随机色
+(UIColor *)colora;

+ (CGColorRef )redCGColor;

+ (CGColorRef )yellowCGColor;

+ (CGColorRef )greenCGColor;

+ (CGColorRef )blueCGColor;

+ (CGColorRef )brownCGColor;

+ (CGColorRef )magentaCGColor;

+ (CGColorRef )purpleCGColor;

+ (CGColorRef )clearCGColor;

+ (CGColorRef)blackCGColor;

+ (CGColorRef )whiteCGColor;

+ (CGColorRef )lightGrayCGColor;


//获取颜色的rgb 和 alph 值
- (NSDictionary *)getRGB;


//获取颜色的hex值
- (NSString *)getHex;





@end
