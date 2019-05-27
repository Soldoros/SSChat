//
//  SSChatVoiceCell.h
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"

@interface SSChatVoiceCell : SSChatBaseCell<NIMMediaManagerDelegate>

@property (nonatomic, strong) UIView *voiceBackView;
@property (nonatomic, strong) UILabel *mTimeLab;
@property (nonatomic, strong) UIImageView *mVoiceImg;

//轮播音频数组
@property (nonatomic, strong) NSArray *pendingAudioMessages;
//设备陈旧卡顿导致播放失败的时候连续尝试播放
@property (nonatomic, assign) NSInteger retryCount;
@end


