//
//  AudioTool.m
//  2048
//
//  Created by scihi on 14/11/27.
//  Copyright (c) 2014年 Soldoros. All rights reserved.
//

#import "AudioTool.h"


//static SystemSoundID shake_sound_male_id = 0;


@implementation AudioTool


+(void)setAudioMove:(NSString *)source
      setFormatMove:(NSString *)format
{
    SystemSoundID soundID = 0;

    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"hit" ofType:@"wav"];
    if (path)
    {
        AudioServicesCreateSystemSoundID( (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID );
    }
    //播放音效
    AudioServicesPlaySystemSound( soundID );
    
}


+(void)setAudioHit:(NSString *)source
      setFormatHit:(NSString *)format
{
    SystemSoundID soundID = 0;
    
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"move" ofType:@"wav"];
    if (path)
    {
        AudioServicesCreateSystemSoundID( (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID );
    }
    //播放音效
    AudioServicesPlaySystemSound( soundID );
    
    //让手机震动
    //AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
   
}


//开场和结束的音乐
+(void)setAudioStOv:(NSString *)source
      setFormatStOv:(NSString *)format
{
    SystemSoundID soundID = 0;
    
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:@"move" ofType:@"wav"];
    if (path)
    {
        AudioServicesCreateSystemSoundID( (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID );
    }
    //播放音效
    AudioServicesPlaySystemSound( soundID );
}






@end
