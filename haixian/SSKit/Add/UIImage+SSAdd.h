//
//  UIImage+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (DEAdd)

//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGRect)frame;

//将image类型转换成data类型
+(NSData *)getDataWithImage:(UIImage *)image;

//图片缩放
-(UIImage *)getImgAtScaleSize:(CGSize)size;

//base64格式的图片数据 用于图片上传的参数
+(NSString *)getImageAtBase64:(UIImage *)image;

//改变图片的颜色
- (UIImage *)imageWithColor:(UIColor *)color;



@end
