//
//  SSSMSView.m
//  htcm
//
//  Created by soldoros on 2018/6/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSSMSView.h"
#import "BaseController.h"
#import "BaseModel.h"

@implementation SSSMSView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _time = TIMER;
        
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.height*0.5;
        self.layer.borderColor = TitleColor.CGColor;
        self.layer.borderWidth = 1;
        self.userInteractionEnabled = YES;
        
        _mGetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mGetPassBtn.frame = self.bounds;
        _mGetPassBtn.titleLabel.font = makeFont(12);
        [_mGetPassBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mGetPassBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        _mGetPassBtn.backgroundColor = [UIColor clearColor];
        [_mGetPassBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mGetPassBtn];
        
    }
    return self;
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
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mGetPassBtn.enabled = NO;
    [_mGetPassBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
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
    self.layer.borderColor = TitleColor.CGColor;
    _mGetPassBtn.enabled = YES;
    [_mGetPassBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [_mGetPassBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
}



@end
