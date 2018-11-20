//
//  UIImage+SSAdd.h
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>



@interface UIImage (SSAdd)


//颜色转换成图片
+ (UIImage *)imageFromColor:(UIColor *)color;

//改变图片的颜色
-(UIImage *)imageWithColor:(UIColor *)color;

//获取本地视频的第一帧 返回图片
+(UIImage *)getImage:(NSString *)videoURL;

@end


