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


//默认注册功能 通过手机号获取验证码
-(instancetype)initWithFrame:(CGRect)frame{
    return [self initWithFrame:frame type:SMSGetCodeTypePhone style:SMSGetCodeRegister];
}

//默认是手机号获取验证码
-(instancetype)initWithFrame:(CGRect)frame style:(SMSViewGetCodeStyle)style{
    return [self initWithFrame:frame type:SMSGetCodeTypePhone style:style];
}

//默认注册功能
-(instancetype)initWithFrame:(CGRect)frame type:(SMSViewGetCodeType)type{
    return [self initWithFrame:frame type:type style:SMSGetCodeRegister];
}

//开放式注册
-(instancetype)initWithFrame:(CGRect)frame type:(SMSViewGetCodeType)type style:(SMSViewGetCodeStyle)style{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _time = TIMER;
        _type = type;
        _style = style;
        
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

//获取手机号
-(void)getPEStringWithBlock:(SSStringBlock)stringBlock smsBlock:(SSSMSBlock)smsBlock{
    _stringBlock = stringBlock;
    _smsBlock = smsBlock;
}


//开始获取验证码
-(void)buttonPressed:(UIButton *)sender{
    
    _peString = _stringBlock();
    
    if(_type == SMSGetCodeTypePhone){
        if([_peString isEqualToString:@""]){
            [(BaseVirtualController *)[self getViewController] showTime:@"请输入手机号!"];
        }
        else if(![NSString shoujihao:_peString]){
            [(BaseVirtualController *)[self getViewController] showTime:@"请输入正确的手机号!"];
        }
        else{
            [self smsBeginTimer];
            [self getCodeNetWorking];
        }
    }
    else{
        
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
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self selector:@selector(addTimer) userInfo:nil repeats:YES];
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



//获取短信验证码
-(void)getCodeNetWorking{
    
    
}



@end
