//
//  AccountCodeController.m
//  QuFound
//
//  Created by soldoros on 2020/7/15.
//  Copyright © 2020 soldoros. All rights reserved.
//

/*
 
 shr20200602@163.com
 Shr12345678
 
 
 
 */

//发送验证码
#import "AccountCodeController.h"
#import "SSSMSView.h"
#import "AccountData.h"
#import "AccountSettingPasswordController.h"


@interface AccountCodeController (){
    UIView *backView[3];
    UITextField *mTextField[3];
}

@property(nonatomic,strong)UILabel *mTitleLab;

@property(nonatomic,strong)UIButton *codeButton;

@property(nonatomic,strong)UIButton *forgetBtn;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic, strong)SSSMSView *smsView;
@property(nonatomic,strong)YYLabel *serviceLabel;


@end

@implementation AccountCodeController

-(instancetype)init{
    if(self = [super init]){
        self.user = [NSUserDefaults standardUserDefaults];
        _type = 1;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"获取验证码"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;
    
    
    NSDictionary *userDic =  [SSRootAccount getUserInfo];
    cout(userDic);
    
    
    NSArray *textArr = @[@"请选择电话区域",@"请输入当前手机号",@"短信验证码"];
    for(int i=0;i<3;++i){
        
        backView[i] = [[UIView alloc]init];
        backView[i].bounds = makeRect(0, 0, SCREEN_Width - 64, 45);
        backView[i].left = 32;
        backView[i].top = SafeAreaTop_Height + 40 + i*53;
        backView[i].backgroundColor = makeColorHex(@"#F6F6F6");
        [self.view addSubview:backView[i]];
        backView[i].clipsToBounds = YES;
        backView[i].layer.cornerRadius = 4;
        if(i==2){
            backView[i].width -= 96;
        }
        
        mTextField[i] = [[UITextField alloc]init];
        mTextField[i].bounds = makeRect(0, 0, backView[i].width - 30, backView[i].height);
        mTextField[i].left = 15;
        mTextField[i].top = 0;
        mTextField[i].attributedPlaceholder = [NSString placehodString:textArr[i] color:makeColorHex(@"#999999")];
        mTextField[i].textColor = makeColorHex(@"#1B1919");
        mTextField[i].textAlignment = NSTextAlignmentLeft;
        [backView[i] addSubview:mTextField[i]];
        mTextField[i].font = makeFont(15);
        mTextField[i].delegate = self;
        mTextField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        mTextField[i].secureTextEntry = NO;
        mTextField[i].userInteractionEnabled = YES;
        mTextField[i].keyboardType = UIKeyboardTypeNumberPad;
        
        if(i==1){
            
            if(_type != 5 && _type!= 6){
                mTextField[i].textColor = makeColorHex(@"#666666");
                mTextField[i].text = userDic[@"user"][@"username"];
                mTextField[i].userInteractionEnabled = NO;
            }
        }
        
        
        if(i==0){
            
            mTextField[i].userInteractionEnabled = NO;
            
            _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _codeButton.frame = backView[i].bounds;
            [backView[i] addSubview:_codeButton];
            _codeButton.tag = 10;
            [_codeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    _smsView = [[SSSMSView alloc]initWithFrame:makeRect(0, 0, 88, 44)];
    _smsView.mGetPassBtn.titleLabel.font = makeFont(15);
    _smsView.centerY = backView[2].centerY;
    _smsView.right = SCREEN_Width - 32;
    _smsView.buttonColor = makeColorHex(@"#666666");
    _smsView.mGetPassBtn.titleLabel.font = makeFont(13);
    [_smsView.mGetPassBtn setTitleColor:makeColorHex(@"#666666") forState:UIControlStateNormal];
    _smsView.backgroundColor = [UIColor whiteColor];
    _smsView.clipsToBounds = YES;
    _smsView.layer.cornerRadius = 5;
    _smsView.layer.borderColor = makeColorHex(@"#DDDDDD").CGColor;
    _smsView.layer.borderWidth = 1;
    [self.view addSubview:_smsView];
    [_smsView confirmPEBlock:^BOOL{
        if(self->mTextField[1].text.length == 0){
            [self showTime:@"请输入手机号"];
            return NO;
        }
        else if(![NSString shoujihao:self->mTextField[1].text]){
            [self showTime:@"请输入正确的手机号"];
            return  NO;
        }
        else{
            return YES;
        }
    } sendBlock:^{
            [self sendSMS];
    }];
    
    
    //登陆经纪人端
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.bounds = makeRect(0, 0, SCREEN_Width - 64, 45);
    _loginBtn.centerX = self.view.centerX;
    _loginBtn.top = backView[2].bottom+60;
    _loginBtn.tag = 100;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = _loginBtn.height/2;
    _loginBtn.backgroundColor = TitleColor;
    [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    
    backView[0].hidden = YES;
    
    
    if(_type == 6){
        [self setNavgaionTitle:@"绑定手机号"];
        [_loginBtn setTitle:@"绑定" forState:UIControlStateNormal];
    }
}


//这里只对长度做检查
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 0){
        return YES;
    }
    
    if (textField == mTextField[0] && range.location < 11){
        return YES;
    }
    
    if(textField == mTextField[1] && range.location < 16){
        return YES;
    }
    if(textField == mTextField[2] && range.location < 6){
        return YES;
    }
    
    else{
        return NO;
    }
}

-(void)sendSMS{
    
    NSDictionary *dic = @{@"phone":mTextField[1].text
        };
        
    cout(dic);
    [SSAFRequest RequestNetWorking:SSRequestPost parameters:dic method:URLSMSLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 1){
                [self showTime:dict[@"msg"]];
            }
            else{
                [self showTime:@"短信发送成功"];
            }
        }
    }];
}

//选择区号10  下一步100
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag == 100){
        
        if(mTextField[2].text.length==0){
            [self showTime:@"请输入验证码"];
            return;
        }
        
        //支付密码
        if(_type == 2 || _type == 3 || _type == 4){
           
            
        }
        //修改登录密码
        else if(_type == 1){
            AccountSettingPasswordController *vc = [AccountSettingPasswordController new];
            vc.type = 2;
            vc.code = mTextField[2].text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        //忘记登录密码
        else if(_type == 5){
            AccountSettingPasswordController *vc = [AccountSettingPasswordController new];
            vc.type = 3;
            vc.code = mTextField[2].text;
            vc.phone = mTextField[1].text;
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        //绑定电话
        else{
            [self bangdingNet:sender];
        }
    }
}


-(void)bangdingNet:(UIButton *)sender{
    
    
    NSDictionary *dic = @{@"password":mTextField[0].text
    };
    
    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestPostHeader parameters:dic method:@"" requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
         [sender closeActivityByBtn:@"绑定"];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 1){
                [self showTime:dict[@"msg"]];
            }
            else{
                
                [self showTime:@"手机号绑定成功"];
                [self performSelector:@selector(jump) afterDelay:1];
            }
        }
    }];
}


-(void)jump{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}




@end
