//
//  UIColor+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UIColor+SSAdd.h"

@implementation UIColor (DEAdd)


+(UIColor *)setTiledColor:(int)number
{
    UIColor *color;
    switch (number)
    {
        case 2:    color = makeColorRgb(253, 255, 246); break;
        case 4:    color = makeColorRgb(211, 219, 190); break;
        case 8:    color = makeColorRgb(154, 152, 176); break;
        case 16:   color = makeColorRgb(99, 107, 126);  break;
        case 32:   color = makeColorRgb(95, 115, 86);   break;
        case 64:   color = makeColorRgb(100, 84, 75);   break;
        case 128:  color = makeColorRgb(110, 135, 125); break;
        case 256:  color = makeColorRgb(65, 100, 125);  break;
        case 512:  color = makeColorRgb(124, 117, 54);  break;
        case 1024: color = makeColorRgb(46, 79, 80);    break;
        case 2048: color = makeColorRgb(105, 95, 130);  break;
        case 4096: color = makeColorRgb(131, 91, 64);   break;
        case 8192: color = makeColorRgb(36, 50, 75);    break;
            
        default: break;
    }
    
    return color;
    
    
}


//随机色
+(UIColor *)colora{
    
    return [UIColor colorWithRed:arc4random() % 250 / 255.0f green:arc4random() % 250 / 255.0f blue:arc4random() % 250 / 255.0f alpha:1];
}

+ (CGColorRef )redCGColor{
    return  (CGColorRef )[[UIColor redColor]CGColor];
}

+ (CGColorRef )yellowCGColor{
    return  (CGColorRef )[[UIColor yellowColor]CGColor];
}

+ (CGColorRef )greenCGColor{
    return  (CGColorRef )[[UIColor greenColor]CGColor];
}

+ (CGColorRef )blueCGColor{
    return  (CGColorRef )[[UIColor blueColor]CGColor];
}

+ (CGColorRef )brownCGColor{
    return  (CGColorRef )[[UIColor brownColor]CGColor];
}

+ (CGColorRef )magentaCGColor{
    return  (CGColorRef )[[UIColor magentaColor]CGColor];
}

+ (CGColorRef )purpleCGColor{
    return  (CGColorRef )[[UIColor purpleColor]CGColor];
}

+ (CGColorRef)clearCGColor{
    return  (CGColorRef )[[UIColor clearColor]CGColor];
}

+ (CGColorRef)blackCGColor{
    return  (CGColorRef)[[UIColor blackColor]CGColor];
}

+ (CGColorRef)whiteCGColor{
    return  (CGColorRef)[[UIColor whiteColor]CGColor];
}

+ (CGColorRef)lightGrayCGColor{
    return  (CGColorRef )[[UIColor lightGrayColor]CGColor];
}






//获取颜色的rgb值
- (NSDictionary *)getRGB
{
    CGFloat r=0,g=0,b=0,a=0;
    if ([self respondsToSelector:@selector(getRed:green:blue:alpha:)]) {
        [self getRed:&r green:&g blue:&b alpha:&a];
    }
    else {
        const CGFloat *components = CGColorGetComponents(self.CGColor);
        r = components[0];
        g = components[1];
        b = components[2];
        a = components[3];
    }
    
    return @{@"R":@(r),
             @"G":@(g),
             @"B":@(b),
             @"A":@(a)};
}

//获取颜色的hex值
- (NSString *)getHex
{
    NSDictionary *colorDic = [self getRGB];
    int r = [colorDic[@"R"] floatValue] * 255;
    int g = [colorDic[@"G"] floatValue] * 255;
    int b = [colorDic[@"B"] floatValue] * 255;
    NSString *red = [NSString stringWithFormat:@"%02x", r];
    NSString *green = [NSString stringWithFormat:@"%02x", g];
    NSString *blue = [NSString stringWithFormat:@"%02x", b];
    
    return [NSString stringWithFormat:@"#%@%@%@", red, green, blue];
}





@end
