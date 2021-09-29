//
//  SSSMSView.m
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSSMSView.h"
#import "BaseViewController.h"
#import "BaseModel.h"

#define buttonTitle  @"获取验证码"

@implementation SSSMSView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _time = TIMER;
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.height*0.5;
        self.layer.borderColor = TitleColor.CGColor;
        self.layer.borderWidth = 0;
        self.userInteractionEnabled = YES;
        
        _mGetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mGetPassBtn.frame = self.bounds;
        _mGetPassBtn.titleLabel.font = makeFont(12);
        [_mGetPassBtn setTitleColor:TitleColor  forState:UIControlStateNormal];
        [_mGetPassBtn setTitle:buttonTitle forState:UIControlStateNormal];
        _mGetPassBtn.backgroundColor = [UIColor clearColor];
        [_mGetPassBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mGetPassBtn];
        
    }
    return self;
}

-(void)setButtonColor:(UIColor *)buttonColor{
    _buttonColor = buttonColor;
    [_mGetPassBtn setTitleColor:_buttonColor forState:UIControlStateNormal];
}

//验证邮箱和手机号 发送验证码
-(void)confirmPEBlock:(SMSConfirmPEBlock)peBlock sendBlock:(SMSConfirmSendBlock)sendBlock{
    _peBlock = peBlock;
    _sendBlock = sendBlock;
}


//开始获取验证码
-(void)buttonPressed:(UIButton *)sender{
    
    _peConfirm = self.peBlock();
    if(_peConfirm == YES){
        [self smsBeginTimer];
        _sendBlock();
    }
}


-(void)smsBeginTimer{
    _mGetPassBtn.backgroundColor = makeColorRgbAlpha(230, 230, 230, 1);
    _mGetPassBtn.layer.borderColor = makeColorRgbAlpha(230, 230, 230, 1).CGColor;
    _mGetPassBtn.layer.borderWidth = 0;
    [_mGetPassBtn setTitleColor:makeColorRgbAlpha(160, 160, 160, 1) forState:UIControlStateNormal];
    _mGetPassBtn.enabled = NO;
    [self startTimer];
}


//时间挑战
- (void)startTimer{
    
    [_mGetPassBtn setTitle:[NSString stringWithFormat:@"重发 %ld",_time] forState:UIControlStateNormal];
    
    [self performSelector:@selector(addTimer) withObject:nil afterDelay:1];
    
    if (!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(addTimer) userInfo:nil repeats:YES];
    }
}

//时间进度
-(void)addTimer{
    if(_time>0){
        [_mGetPassBtn setTitle:[NSString stringWithFormat:@"重发 %ld",_time] forState:UIControlStateNormal];
        _time --;
    }
    else{
        [self chushihua];
    }
}


//时间数字 timer btn 全部归位
-(void)chushihua{
    _time = TIMER;
    [_timer invalidate];
    _timer?_timer = nil:nil;
    _mGetPassBtn.enabled = YES;
    _mGetPassBtn.backgroundColor = [UIColor clearColor];
    [_mGetPassBtn setTitleColor:_buttonColor forState:UIControlStateNormal];
    [_mGetPassBtn setTitle:buttonTitle forState:UIControlStateNormal];
}



@end
