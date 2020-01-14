//
//  SSAudioPlayer.m
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSAudioPlayer.h"

@implementation SSAudioPlayer


//默认播放MP3格式
+(void)PlayAudioMove:(NSString *)source{
    [SSAudioPlayer PlayAudioMove:source formatType:@"mp3"];
}


//播放音效
+(void)PlayAudioMove:(NSString *)source
          formatType:(NSString *)formatType;{
    
    SystemSoundID soundID = 0;
    NSString *path = [[NSBundle mainBundle]
                      pathForResource:source ofType:formatType];
    if (path){
        AudioServicesCreateSystemSoundID( (CFURLRef)CFBridgingRetain([NSURL fileURLWithPath:path]), &soundID );
    }
    AudioServicesPlaySystemSound( soundID );
}




//设置震动
+(void)PlayAudioVibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}




@end
