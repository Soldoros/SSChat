//
//  SSChatVoiceCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatVoiceCell.h"

#define NotiCloseAllMedia  @"NotiCloseAllMedia"

@implementation SSChatVoiceCell

-(void)dealloc{
    [[NIMSDK sharedSDK].mediaManager removeDelegate:self];
}

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    _retryCount = 3;
    
    _voiceBackView = [[UIView alloc]init];
    [self.mBackImgButton addSubview:self.voiceBackView];
    _voiceBackView.userInteractionEnabled = YES;
    _voiceBackView.backgroundColor = [UIColor clearColor];
    
    _mTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _mTimeLab.textAlignment = NSTextAlignmentCenter;
    _mTimeLab.font = [UIFont systemFontOfSize:SSChatVoiceTimeFont];
    _mTimeLab.userInteractionEnabled = YES;
    _mTimeLab.backgroundColor = [UIColor clearColor];

    
    _mVoiceImg = [[UIImageView alloc]initWithFrame:CGRectMake(80, 5, 20, 20)];
    _mVoiceImg.userInteractionEnabled = YES;
    _mVoiceImg.animationDuration = 1;
    _mVoiceImg.animationRepeatCount = 0;
    _mVoiceImg.backgroundColor = [UIColor clearColor];
    
    [_voiceBackView addSubview:_mVoiceImg];
    [_voiceBackView addSubview:_mTimeLab];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(audioPlayerDidFinishPlay) name:NotiCloseAllMedia object:nil];
    
    [[NIMSDK sharedSDK].mediaManager setNeedProximityMonitor:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sensorStateChange:) name:UIDeviceProximityStateDidChangeNotification object:nil];
}

//红外线感应监听
-(void)sensorStateChange:(NSNotificationCenter *)notification{
    if ([UIDevice currentDevice].proximityState == YES) { NSLog(@"靠近了设备屏幕,屏幕会自动锁住");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceReceiver];
    }
    else {
        NSLog(@"远离了设备屏幕,屏幕会自动解锁");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
        [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceSpeaker];
    }
}

//关闭所有媒体
-(void)audioPlayerDidFinishPlay{
    [[NIMSDK sharedSDK].mediaManager setNeedProximityMonitor:NO];
    [[NIMSDK sharedSDK].mediaManager stopPlay];
    [_mVoiceImg stopAnimating];
}


-(void)setLayout:(SSChatMessagelLayout *)layout{
    [super setLayout:layout];
    
    [[NIMSDK sharedSDK].mediaManager addDelegate:self];
    
    UIImage *image = [UIImage imageNamed:layout.chatMessage.backImgString];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    _mVoiceImg.image = layout.chatMessage.voiceImg;
    _mVoiceImg.animationImages = layout.chatMessage.voiceImgs;
    _mVoiceImg.frame = layout.voiceImgRect;
    
    NSString *time = makeStrWithInt(layout.chatMessage.audioObject.duration/1000);
    _mTimeLab.text = makeString(time, @"\"");
    _mTimeLab.frame = layout.voiceTimeLabRect;
    
    [self setMessageReadStatus];
    [self setNameWithTeam];
}

//播放音频 暂停音频
-(void)buttonPressed:(UIButton *)sender{
    if ([self.layout.chatMessage.message attachmentDownloadState]== NIMMessageAttachmentDownloadStateFailed
        || [self.layout.chatMessage.message attachmentDownloadState] == NIMMessageAttachmentDownloadStateNeedDownload) {
        [[[NIMSDK sharedSDK] chatManager] fetchMessageAttachment:self.layout.chatMessage.message error:nil];
        return;
    }
    
    if ([self.layout.chatMessage.message attachmentDownloadState] == NIMMessageAttachmentDownloadStateDownloaded) {
    
        if (![[NIMSDK sharedSDK].mediaManager isPlaying]) {
            
            [[NIMSDK sharedSDK].mediaManager setNeedProximityMonitor:NO];
            
            [[NIMSDK sharedSDK].mediaManager switchAudioOutputDevice:NIMAudioOutputDeviceSpeaker];
            self.pendingAudioMessages = [self findRemainAudioMessages:self.layout.chatMessage.message];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:NotiCloseAllMedia object:nil];
            
            [self.mVoiceImg startAnimating];
            self.layout.chatMessage.message.isPlayed = YES;
            [[NIMSDK sharedSDK].mediaManager play:self.layout.chatMessage.audioObject.path];
            
        } else {
            self.pendingAudioMessages = nil;
            [[NIMSDK sharedSDK].mediaManager stopPlay];
        }
    }
}


#pragma -mark  NIMMediaManagerDelegate
-(void)playAudio:(NSString *)filePath didBeganWithError:(NSError *)error{
    //播放失败的话连续尝试播放3次
    if(error){
        if (_retryCount > 0){
            _retryCount--;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [[NIMSDK sharedSDK].mediaManager play:filePath];
            });
        }else{
            _retryCount = 3;
        }
    }else{
        _retryCount = 3;
        
    }
}

-(void)playAudio:(NSString *)filePath didCompletedWithError:(NSError *)error{
    [self.mVoiceImg stopAnimating];
}

//音频数组 如果这条音频消息被播放过了 或者这条消息是属于自己的消息，则不进行轮播
- (NSMutableArray *)findRemainAudioMessages:(NIMMessage *)message
{
    if (message.isPlayed || [message.from isEqualToString:[NIMSDK sharedSDK].loginManager.currentAccount]) {
        return nil;
    }
    NSMutableArray *messages = [[NSMutableArray alloc] init];
    return messages;
}

@end
