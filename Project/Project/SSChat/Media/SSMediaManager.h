//
//  SSMediaManager.h
//  Project
//
//  Created by soldoros on 2021/9/20.
//

//媒体管理
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>


NS_ASSUME_NONNULL_BEGIN


//音频输出设备
typedef NS_ENUM(NSInteger, SSMAudioOutputDevice){
    //听筒
    SSMAudioOutputDeviceReceiver,
    //扬声器
    SSMAudioOutputDeviceSpeaker
};


@protocol SSMediaManagerDelegate <NSObject>

//是否授权录音回调
- (void)recordAudioGranted:(BOOL)granted;

//开始录制音频的回调
- (void)recordAudio:(nullable NSString *)filePath didBeganWithError:(nullable NSError *)error; 

//音频录制进度更新回调
- (void)recordAudioProgress:(NSTimeInterval)currentTime;

//录制音频完成后的回调
- (void)recordAudio:(nullable NSString *)filePath didCompletedWithError:(nullable NSError *)error;

//录音被取消的回调
- (void)recordAudioDidCancelled;

//录音开始被打断回调
- (void)recordAudioInterruptionBegin;

//录音结束被打断回调
- (void)recordAudioInterruptionEnd;

@end

@interface SSMediaManager : NSObject<AVAudioRecorderDelegate>

+(SSMediaManager *_Nullable)shareMediaManager;

@property(nonatomic,assign)id<SSMediaManagerDelegate>delegate;

@property(nonatomic,strong)AVAudioRecorder *mRecorder;
@property(nonatomic,strong)NSTimer *mTimer;

//是否可以访问麦克风
- (void)isRecordGranted;

//开始录制音频 是否成功开始
- (void)startRecord;

//开始录制音频+最长录音时间
- (void)startRecordTime:(NSTimeInterval)time;

//停止录制音频
- (void)stopRecord;

//取消录制音频
- (void)cancelRecord;

//是否正在录音
- (BOOL)isRecording;

//获取录音峰值分贝
- (float)recordSoundPeakPower;

//获取录音平均分贝
- (float)recordSoundAveragePower;

//是否正在播放音频
- (BOOL)isPlaying;


//播放音频文件
- (void)play:(NSString *_Nonnull)filepath;

//停止播放
- (void)stopPlay;

//设置播放音频的起始时间
- (BOOL)seek:(NSTimeInterval)timestamp;

//切换音频输出设备+是否成功
- (BOOL)switchAudioOutputDevice:(SSMAudioOutputDevice)outputDevice;

//在播放声音的时候,如果手机贴近耳朵,是否需要自动切换成听筒播放
- (void)setNeedProximityMonitor:(BOOL)needProximityMonitor;


@end


NS_ASSUME_NONNULL_END
