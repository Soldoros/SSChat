//
//  AudioTool.h
//  2048
//
//  Created by scihi on 14/11/27.
//  Copyright (c) 2014年 Soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>



@interface AudioTool : NSObject



+(void)setAudioMove:(NSString *)source
      setFormatMove:(NSString *)format;

+(void)setAudioHit:(NSString *)source
      setFormatHit:(NSString *)format;

//开场和结束的音乐
+(void)setAudioStOv:(NSString *)source
      setFormatStOv:(NSString *)format;


@end
