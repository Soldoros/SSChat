//
//  SSAudioPlayer.m
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSAudioPlayer.h"
#import <CoreFoundation/CoreFoundation.h>

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
    CFRunLoopRun();
}

//设置震动
+(void)PlayAudioVibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

//停止响铃及振动
+(void)StopAudioVibration{
    
    AudioServicesRemoveSystemSoundCompletion(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
}


//播放系统音效
+(void)PlaySystemSound{
    AudioServicesPlaySystemSound(1007);
}


//连续响铃及震动
-(void)startShakeSound:(NSString *)source type:(NSString *)type{
    
    _sound = 0;
    NSString *path = [[NSBundle mainBundle] pathForResource:source ofType:type];
    if (path){
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:
                                                         path], &_sound);
    }
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesPlayAlertSound(_sound);
    
    AudioServicesAddSystemSoundCompletion(_sound, NULL, NULL, soundCompleteCallback, NULL);
}

void soundCompleteCallback(SystemSoundID sound,void * clientData) {
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    AudioServicesPlayAlertSound(sound);
}

-(void)stopShakeSound{
    AudioServicesDisposeSystemSoundID(kSystemSoundID_Vibrate);
    AudioServicesDisposeSystemSoundID(_sound);
    AudioServicesRemoveSystemSoundCompletion(_sound);
}

@end
