//
//  SSChatAudioIndicator.h
//  SSChat
//
//  Created by soldoros on 2019/5/27.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 录音指示器状态

 - AudioIndicatorStart: 开始录音
 - AudioIndicatorRecording: 正在录音
 - AudioIndicatorExit: 准备取消录音
 - AudioIndicatorCancel: 录音结束
 */
typedef NS_ENUM(NSInteger, AudioIndicatorStatus) {
    AudioIndicatorStart,
    AudioIndicatorRecording,
    AudioIndicatorExit,
    AudioIndicatorCancel
};


@interface SSChatAudioIndicator : UIView

@property(nonatomic, assign)AudioIndicatorStatus status;
@property (nonatomic, assign) NSTimeInterval recordTime;

@property (nonatomic, strong) UIImageView *backgrounView;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *tipLabel;

@end



