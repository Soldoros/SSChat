//
//  SSChatAudioIndicator.m
//  SSChat
//
//  Created by soldoros on 2019/5/27.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSChatAudioIndicator.h"

#define IndicatorWidth   150
#define IndicatorHeight  100

@implementation SSChatAudioIndicator

- (instancetype)init {
    self = [super init];
    if(self) {
        self.bounds = CGRectMake(0, 0, IndicatorWidth, IndicatorHeight);
        self.centerX = SCREEN_Width * 0.5;
        self.centerY = SCREEN_Height * 0.5;
        [[AppDelegate sharedAppDelegate].window addSubview:self];
        
        _backgrounView = [[UIImageView alloc] init];
        _backgrounView.frame = self.bounds;
        _backgrounView.image = [UIImage imageNamed:@"showtime"];
        [self addSubview:_backgrounView];
      
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.font = [UIFont boldSystemFontOfSize:32];
        _timeLabel.textColor = [UIColor whiteColor];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_timeLabel];
        
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.font = [UIFont systemFontOfSize:14];
        _tipLabel.textColor = [UIColor whiteColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
        
        self.status = AudioIndicatorStart;
    }
    return self;
}

-(void)setStatus:(AudioIndicatorStatus)status{
    if(status == AudioIndicatorStart) {
        [self setRecordTime:0];
        _tipLabel.text = @"上滑 取消发送";
    }else if(status == AudioIndicatorRecording) {
        _tipLabel.text = @"上滑 取消发送";
    }else if(status == AudioIndicatorExit){
        _tipLabel.text = @"松开 取消发送";
    }else{
        _tipLabel.text = @"";
    }
}

- (void)setRecordTime:(NSTimeInterval)recordTime {
    NSInteger minutes = (NSInteger)recordTime / 60;
    NSInteger seconds = (NSInteger)recordTime % 60;
    _timeLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minutes, seconds];
}

- (void)layoutSubviews {
    
    [_timeLabel sizeToFit];
    _timeLabel.centerX = self.width * 0.5;
    _timeLabel.top = 15;
    
    [_tipLabel sizeToFit];
    _tipLabel.centerX = self.width * 0.5;
    _tipLabel.bottom = self.height - 15;
}


@end
