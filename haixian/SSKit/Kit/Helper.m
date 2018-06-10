//
//  Helper.m
//  EVNCustomSearchBar
//
//  Created by developer on 2017/9/28.
//  Copyright © 2017年 仁伯安. All rights reserved.
//

#import "Helper.h"

@implementation Helper

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    //Create a context of the appropriate size
    UIGraphicsBeginImageContext(size);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);

    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);

    //Fill the color
    CGContextFillRect(currentContext, fillRect);

    //Snap the picture and close the context
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return colorImage;
}

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName
{
    NSString *bundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"EVNCustomSearchBar.bundle"];
    NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
    NSString *img_path = [bundle pathForResource:imgName ofType:@"png"];
    return [UIImage imageWithContentsOfFile:img_path];
}

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears

    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }

    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];

    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}

@end
