//
//  SSChatVoiceCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatVoiceCell.h"

@implementation SSChatVoiceCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    
    _mVoiceBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.mVoiceBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:_mVoiceBtn];
    [_mVoiceBtn addTarget:self action:@selector(btnContentClick)  forControlEvents:UIControlEventTouchUpInside];
    
    
    _voiceBackView = [[UIView alloc]init];
    [_mVoiceBtn addSubview:self.voiceBackView];
    _voiceBackView.userInteractionEnabled = YES;
    _voiceBackView.backgroundColor = [UIColor clearColor];


    _mTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
    _mTimeLab.textAlignment = NSTextAlignmentCenter;
    _mTimeLab.font = makeFont(SSChatVoiceTimeFont);
    _mTimeLab.userInteractionEnabled = YES;
    _mTimeLab.backgroundColor = [UIColor clearColor];

    
    _mVoiceImg = [[UIImageView alloc]initWithFrame:CGRectMake(80, 5, 20, 20)];
    _mVoiceImg.userInteractionEnabled = YES;
    _mVoiceImg.animationDuration = 1;
    _mVoiceImg.animationRepeatCount = 0;
    _mVoiceImg.backgroundColor = [UIColor clearColor];


    _indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    self.indicator.center=CGPointMake(80, 15);


    [_voiceBackView addSubview:_indicator];
    [_voiceBackView addSubview:_mVoiceImg];
    [_voiceBackView addSubview:_mTimeLab];
    
    
    //整个列表只能有一个语音处于播放状态 通知其他正在播放的语音停止
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UUAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
    
    //红外线感应监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sensorStateChange:)
                                                 name:UIDeviceProximityStateDidChangeNotification
                                               object:nil];
}


-(void)setLayout:(SSChatModelLayout *)layout{
    [super setLayout:layout];
    
    self.mVoiceBtn.frame = layout.btnRect;
    [self.mVoiceBtn setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mVoiceBtn setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];
    
    _mVoiceImg.image = layout.voiceImg;
    _mVoiceImg.animationImages = layout.voiceImgs;
    _mVoiceImg.frame = layout.voiceRect;
    
    _mTimeLab.text = layout.timeString;
    _mTimeLab.frame = layout.timeLabRect;


}

//播放音频 暂停音频
-(void)btnContentClick{
    if(!_contentVoiceIsPlaying){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"VoicePlayHasInterrupt" object:nil];
        _contentVoiceIsPlaying = YES;
        [_mVoiceImg startAnimating];
        _audio = [UUAVAudioPlayer sharedInstance];
        _audio.delegate = self;
        [_audio playSongWithUrl:self.layout.model.remotePath];
    }else{
        [self UUAVAudioPlayerDidFinishPlay];
    }
}

//播放显示开始加载
- (void)UUAVAudioPlayerBeiginLoadVoice{
    dispatch_async(dispatch_get_main_queue(), ^{
       [self.indicator startAnimating];
    });
}

//开启红外线感应
- (void)UUAVAudioPlayerBeiginPlay{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
    [self.indicator stopAnimating];
    
}

//关闭红外线感应
- (void)UUAVAudioPlayerDidFinishPlay{
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    _contentVoiceIsPlaying = NO;
    [_mVoiceImg stopAnimating];
    [[UUAVAudioPlayer sharedInstance]stopSound];
}

//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification{
    if ([[UIDevice currentDevice] proximityState] == YES){
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else{
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}



@end
