//
//  SSAudioPlayer.h
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface SSAudioPlayer : NSObject



/**
 播放音效 默认播放MP3格式

 @param source 资源文件名
 */
+(void)PlayAudioMove:(NSString *)source;


/**
 播放音效

 @param source 资源文件名
 @param formatType 资源文件类型 wav mp3 ...
 */
+(void)PlayAudioMove:(NSString *)source
      formatType:(NSString *)formatType;


/**
 设置手机震动
 */
+(void)PlayAudioVibration;









@end
