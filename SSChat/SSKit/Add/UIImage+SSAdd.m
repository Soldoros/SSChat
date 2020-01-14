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

//获取本地视频的第一帧 返回图片
+(UIImage *)getImage:(NSString *)videoURL{
    
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:videoURL] options:nil];
    AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    gen.appliesPreferredTrackTransform = YES;
    
    CMTime time = CMTimeMakeWithSeconds(0.0, 600);
    NSError *error = nil;
    CMTime actualTime;
    CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
    UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
    CGImageRelease(image);
    
    return thumb;
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



//设置图片拉伸模式和保护的左右宽度
+(UIImage *)imageWithImage:(NSString *)imageStr width:(CGFloat)width{
    
    UIImage *image = [UIImage imageNamed:imageStr];
    UIEdgeInsets insets = UIEdgeInsetsMake(0, width, 0, width);
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    
    return image;
}



//设置图片拉伸模式和保护区域
+(UIImage *)imageWithImage:(NSString *)imageStr insets:(UIEdgeInsets)insets{
    UIImage *image = [UIImage imageNamed:imageStr];
    image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
    return image;
}



//根据gif图片路径返回图片数组
+ (NSArray *)getImagesWithGif:(NSURL *)fileUrl {
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((CFURLRef)fileUrl, NULL);
    size_t gifCount = CGImageSourceGetCount(gifSource);
    NSMutableArray *frames = [[NSMutableArray alloc]init];
    for (size_t i = 0; i< gifCount; i++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        UIImage *image = [UIImage imageWithCGImage:imageRef];
        
        //压缩尺寸
        UIImage *image2 = [self scaleToSize:CGSizeMake(image.size.width/2, image.size.height/2) img:image];
        
        [frames addObject:image2];
        CGImageRelease(imageRef);
    }
    return frames;
}



//压缩图片
+ (UIImage*) scaleToSize:(CGSize)size img:(UIImage *)img{
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 2.0);
    
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;
}




@end
