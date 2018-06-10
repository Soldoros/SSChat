//
//  UIImage+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "UIImage+SSAdd.h"

@implementation UIImage (DEAdd)



//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGRect)frame
{
    CGRect rect = frame;
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


//将image类型转换成data类型
+(NSData *)getDataWithImage:(UIImage *)image
{
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil)
    {
        data = UIImageJPEGRepresentation(image, 1.0);
    }
    else
    {
        data = UIImagePNGRepresentation(image);
    }
    return data;
}


//图片缩放
-(UIImage *)getImgAtScaleSize:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    
    [self drawInRect:CGRectMake(0,0, size.width, size.height)];
    
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
    
}


//base64格式的图片数据 用于图片上传的参数
+(NSString *)getImageAtBase64:(UIImage *)image
{
    NSData *imageData =nil;
   // NSString *mimeType =@"image/jpeg";

    //图片要压缩的比例，此处100根据需求，自行设置
    CGFloat x =100 / image.size.height;
    if (x >1){
        x = 1.0;
    }
    imageData = UIImageJPEGRepresentation(image, x);
    NSString *encodedImageStr = [imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//改变图片的颜色
- (UIImage *)imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


@end
