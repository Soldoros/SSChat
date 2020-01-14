//
//  SSChatVoiceCell.h
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"
#import "UUAVAudioPlayer.h"

@interface SSChatVoiceCell : SSChatBaseCell<UUAVAudioPlayerDelegate>

@property (nonatomic, strong) UIView *voiceBackView;
@property (nonatomic, strong) UILabel *mTimeLab;
@property (nonatomic, strong) UIImageView *mVoiceImg;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

//是否在播放
@property (nonatomic, assign)BOOL contentVoiceIsPlaying;

//音频路径 音频文件 播放控制
@property(nonatomic, strong)NSString *voiceURL;
@property(nonatomic, strong)NSData *songData;
@property(nonatomic, strong)UUAVAudioPlayer *audio;

@end


