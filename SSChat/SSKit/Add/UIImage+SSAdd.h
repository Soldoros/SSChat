//
//  UIImage+DEAdd.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface UIImage (DEAdd)

//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color andFrame:(CGRect)frame;

//获取本地视频的第一帧 返回图片
+(UIImage *)getImage:(NSString *)videoURL;

//将image类型转换成data类型
+(NSData *)getDataWithImage:(UIImage *)image;

//图片缩放
-(UIImage *)getImgAtScaleSize:(CGSize)size;

//base64格式的图片数据 用于图片上传的参数
+(NSString *)getImageAtBase64:(UIImage *)image;

//改变图片的颜色
- (UIImage *)imageWithColor:(UIColor *)color;



/**
 设置图片拉伸模式和保护区域

 @param imageStr 传入图片名称
 @param width 设置保护区域宽度
 @return 返回图片
 */
+(UIImage *)imageWithImage:(NSString *)imageStr width:(CGFloat)width;


/**
 设置图片拉伸模式和保护区域

 @param imageStr 传入图片名称
 @param insets 设置保护区域
 @return 返回图片
 */
+(UIImage *)imageWithImage:(NSString *)imageStr insets:(UIEdgeInsets)insets;



//根据gif图片路径返回图片数组
+ (NSArray *)getImagesWithGif:(NSURL *)fileUrl;

//压缩图片
+ (UIImage*) scaleToSize:(CGSize)size img:(UIImage *)img;



/**
 生成二维码 IOS7.0以后可以使用
 
 @param content 字符串
 @param size 二维码尺寸
 @param logo 二维码logo
 @param logoFrame logo大小
 @param red 三原色值的red值
 @param green 三原色值的green值
 @param blue 三原色值的blue值
 @return 返回二维码图片
 */
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(CGFloat)blue;







/**
 生成条形码
 
 @param content 字符串
 @param size 条形码尺寸
 @param red 三原色值的red值
 @param green 三原色值的green值
 @param blue 三原色值的blue值
 @return 返回条形码图片
 */
+ (UIImage *)barcodeImageWithContent:(NSString *)content
                       codeImageSize:(CGSize)size
                                 red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(CGFloat)blue;










@end
