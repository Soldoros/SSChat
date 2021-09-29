//
//  SSMediaManager.m
//  Project
//
//  Created by soldoros on 2021/9/20.
//

//媒体管理
#import "SSMediaManager.h"



static SSMediaManager *manager = nil;

@implementation SSMediaManager

+(SSMediaManager *_Nullable)shareMediaManager{
    
    static dispatch_once_t once;
    dispatch_once(&once,^{
        manager = [SSMediaManager new];
    });
    return manager;
}

//是否可以访问麦克风
- (void)isRecordGranted{
    
    __weak typeof(self)wself = self;
    AVAudioSessionRecordPermission permission = AVAudioSession.sharedInstance.recordPermission;
    if (permission == AVAudioSessionRecordPermissionDenied || permission == AVAudioSessionRecordPermissionUndetermined) {
        [AVAudioSession.sharedInstance requestRecordPermission:^(BOOL granted) {
            if (!granted) {
                if(wself.delegate && [wself.delegate respondsToSelector:@selector(recordAudioGranted:)]){
                    [wself.delegate recordAudioGranted:NO];
                }
            }
        }];
        return;
    }
    if(permission == AVAudioSessionRecordPermissionGranted){
        if(wself.delegate && [wself.delegate respondsToSelector:@selector(recordAudioGranted:)]){
            [wself.delegate recordAudioGranted:YES];
        }
    }
}


//开始录制音频
- (void)startRecord{
    [self startRecordTime:60];
}

//开始录制音频+最长录音时间
- (void)startRecordTime:(NSTimeInterval)time{
    
    //保存音频的地址
    NSString *timeStamp = [NSString stringWithFormat:@"%ld",[NSTimer getLocationTimeStamp]];
    NSString *suffix = makeMoreStr([SSDocumentManager getAPPDocumentPath],@"/",timeStamp,@".m4a",nil);
    NSString *path = [SSDocumentManager getAccountDocumentPath:suffix];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatMPEG4AAC],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    

    
    __weak typeof(self)wself = self;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        AVAudioSession *session = [AVAudioSession sharedInstance];
        NSError *error = nil;
        [session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error];
        [session setActive:YES error:&error];
        
        wself.mRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:nil];
        wself.mRecorder.meteringEnabled = YES;
        [wself.mRecorder prepareToRecord];
        [wself.mRecorder record];
        [wself.mRecorder updateMeters];
   });
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(recordAudio:didBeganWithError:)]){
        [self.delegate recordAudio:path didBeganWithError:nil];
    }
    
    _mTimer  = [NSTimer scheduledTimerWithTimeInterval:0.5 repeats:YES block:^(NSTimer * _Nonnull timer) {
        
        [wself.mRecorder updateMeters];
        NSTimeInterval interval = wself.mRecorder.currentTime;
        if(wself.delegate && [wself.delegate respondsToSelector:@selector(recordAudioProgress:)]){
            [wself.delegate recordAudioProgress:interval];
        }
    }];
}

//停止录音
-(void)stopRecord{

    if(_mTimer){
        [_mTimer invalidate];
        _mTimer = nil;
    }
    if([_mRecorder isRecording]){
        [_mRecorder stop];
    }
    
    NSString *path = _mRecorder.url.path;
    if(_delegate && [_delegate respondsToSelector:@selector(recordAudio:didCompletedWithError:)]){
        [_delegate recordAudio:path didCompletedWithError:nil];
    }
}

//取消录音
-(void)cancelRecord{
    
    if(_mTimer){
        [_mTimer invalidate];
        _mTimer = nil;
    }
    if([_mRecorder isRecording]){
        [_mRecorder stop];
    }
    NSString *path = _mRecorder.url.path;
    if([[NSFileManager defaultManager] fileExistsAtPath:path]){
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(recordAudioDidCancelled)]){
        [_delegate recordAudioDidCancelled];
    }
}

//获取录音峰值分贝
- (float)recordSoundPeakPower{
    return [_mRecorder peakPowerForChannel:0];
}

//获取录音平均分贝
- (float)recordSoundAveragePower{
    return [_mRecorder averagePowerForChannel:0];
}

@end
