//
//  VerificationCodeV.m
//  BJLT
//
//  Created by chou on 15/8/6.
//  Copyright (c) 2015年 Soldoros. All rights reserved.
//




#import "VerificationCodeV.h"
#import "BaseModel.h"

@interface VerificationCodeV ()
{
    
    
    NSTimer *_timer;
    int  time;
    BOOL startTime;
    NSString *_sendBtnString;
    NSString *phoneString;
    
}

@end

@implementation VerificationCodeV



-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.getCodeStyle = GetCodeWithRegister;
        
        [self initData];
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = self.height*0.5;
        self.layer.borderColor = TitleColor.CGColor;
        self.layer.borderWidth = 1;
        self.userInteractionEnabled = YES;

        _mBtnLab = [[UILabel alloc]initWithFrame:self.bounds];
        _mBtnLab.text = @"获取验证码";
        _mBtnLab.backgroundColor = [UIColor clearColor];
        _mBtnLab.font = makeFont(14);
        _mBtnLab.userInteractionEnabled = YES;
        _mBtnLab.textAlignment = NSTextAlignmentCenter;
        _mBtnLab.textColor = TitleColor;
        [self addSubview:_mBtnLab];
        
        _mGetPassBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mGetPassBtn.frame = makeRect(0, 0, self.width, self.height);
        _mGetPassBtn.backgroundColor = [UIColor clearColor];
        [_mGetPassBtn addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_mGetPassBtn];
        
    }
    return self;
}

-(void)initData{
    _timer = nil;
    startTime = false;
    time = TIMER;
    _sendBtnString =  [self setSend:time];
}


//设置重发时间
-(NSString *)setSend:(int)theTime{
    NSString *str = [NSString stringWithFormat:@"重发 %dS",theTime];
    return str;

}

-(void)btnPressed{
    if(_getCodeStyle == GetCodeWithBangDingEmail ||
       _getCodeStyle == GetCodeWithChangeEmail ||
       _getCodeStyle == GetCodeWithBangChangeEmail){
        [self EmailCode];
    }else{
        [self SIMCode];
    }
}

//通过短信获取
-(void)SIMCode{
    if(_delegate && [_delegate respondsToSelector:@selector(phoneNum)]){
        phoneString = [_delegate phoneNum];
        if(phoneString == nil){
            return;
        }
        
        if([phoneString isEqualToString:@""]){
            [[self getViewController] showTime:@"请输入手机号!"];
        }
        else if(![NSString shoujihao:phoneString]){
            [[self getViewController] showTime:@"请输入正确的手机号!"];
        }
        else{
            [self btnBeginTimer];
            [self getCodeNetWorking];
        }
        
    }
    
}

//通过邮件获取
-(void)EmailCode{
    if(_delegate && [_delegate respondsToSelector:@selector(phoneNum)])
    {
        phoneString = [_delegate phoneNum];
        
        if([phoneString isEqualToString:@""]){
            [[self getViewController] showTime:@"请输入邮箱号!"];
        }
        else if(![NSString youxiang:phoneString]){
            [[self getViewController] showTime:@"请输入合法邮箱!"];
        }
        else if(![SSUserDefault shareCKUserDefault].canNetWorking){
            [[self getViewController] showTime:@"当前网络不可用!"];
        }else{
            [self btnBeginTimer];
            [self getEmailCodeNetWorking];
          
        }
        
    }
}


-(void)btnBeginTimer{
    _mBtnLab.textColor = [UIColor lightGrayColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _mGetPassBtn.enabled = NO;
    [self startTimer];
}


//时间挑战
- (void)startTimer{
    if (!_timer){
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                  target:self selector:@selector(addTimer) userInfo:nil repeats:YES];
    }
}


//时间进度
-(void)addTimer{
    if(time>0){
        _mBtnLab.text = [self setSend:time];
        time -=1;
    }
    else{
        [self chushihua];
    }
}


//时间数字 timer lab btn 全部归位
-(void)chushihua{
    time = TIMER-1;
    
    [_timer invalidate];
    _timer?_timer = nil:nil;
    self.layer.borderColor = TitleColor.CGColor;
    _mBtnLab.textColor = TitleColor;
    _mBtnLab.text = @"获取验证码";
    _mGetPassBtn.enabled = YES;
}



//获取邮箱验证码
-(void)getEmailCodeNetWorking
{
    
    NSInteger num = _getCodeStyle;
    if(num>=100)num-=100;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSDictionary *dic = @{@"email":phoneString,
                          @"device_id":[user valueForKey:USER_Device],
                          @"token":[user valueForKey:USER_Token],
                          @"type":@(num)};
    cout(dic);
    
}





//获取短信验证码
-(void)getCodeNetWorking{
    
    //注册验证码
    if(_getCodeStyle == GetCodeWithRegister)
        [self getCodeNetWorkingUrl:URLRegisterCode];
    //忘记密码验证码
    else if(_getCodeStyle == GetCodeWithFind)
        [self getCodeNetWorkingUrl:URLFindPasswordCode];
    //更换手机号验证旧手机号
    else if(_getCodeStyle == GetCodeWithChangePhone)
        [self getCodeNetWorkingUrl:URLChangePhoneOldCode];
    //更换手机号验证新手机号并更换
    else if(_getCodeStyle == GetCodeWithChangeNewPhone)
        [self getCodeNetWorkingUrl:URLChangeNewPhoneCode];
    //添加家人
    else if(_getCodeStyle == GetCodeWithAddFamliy){
        [self getCodeNetWorkingUrl:URLChangeAddFamilyCode];
    }
    //家人修改手机号
    else if (_getCodeStyle == GetCodeWithFamliyChangePhone){
        [self getCodeNetWorkingUrl:URLChangeFamilyChangePhoneCode];
    }
}


//注册 GetCodeWithRegister
//忘记密码验证码 GetCodeWithFind
//更换手机号验证新手机号并更换 GetCodeWithChangeNewPhone
-(void)getCodeNetWorkingUrl:(NSString *)urlString{
    
    NSDictionary *dic = @{@"mobile":phoneString};
    BaseController *vc = (BaseController *)[self getViewController];
    
    cout(dic);
    [BaseModel BaseRequestNetWorking:BaseNetworkRequestPostHeader controller:vc parameters:dic method:urlString block:^(HtmcNetworkingStatus status, NSString *message, id object) {
        
        if(status!=HtmcNetworkingDefault){
            [vc showTime:message];
        }
        else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            [vc showTime:@"短信发送成功"];
            if(_delegate && [_delegate respondsToSelector:@selector(netResultError:dict:)]){
                [_delegate netResultError:nil dict:dict];
            }
        }
        
    }];
}



@end
