//
//  AccountRegisterController.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "AccountRegisterController.h"
#import "ServiceRegisterTask.h"
#import "SSSMSView.h"
#import "SSApplicationHelper.h"

@interface AccountRegisterController ()<UITextFieldDelegate>{
    UITextField *mTextField[4];
}

@property(nonatomic, strong)SSSMSView *smsView;

@end

@implementation AccountRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;
    [self setRightOneBtnTitle:@"登录"];
    
    
    UILabel * mTitleLab = [UILabel new];
    mTitleLab.bounds = makeRect(0, 0, 100, 30);
    mTitleLab.textColor = [UIColor blackColor];
    [self.view addSubview:mTitleLab];
    mTitleLab.font = makeFont(24);
    mTitleLab.text = @"新用户注册";
    [mTitleLab sizeToFit];
    mTitleLab.left = 30;
    mTitleLab.top = SafeAreaTop_Height + 30;
    
    
    NSArray *textArr = @[@"请输入手机号...",@"请输入验证码...",@"请输入密码...",@"请确认密码..."];
    for(int i=0;i<textArr.count;++i){
        
        UIView *backView = [[UIView alloc]init];
        backView.bounds = makeRect(0, 0, SCREEN_Width-65, 40);
        backView.centerX = SCREEN_Width * 0.5;
        backView.top = mTitleLab.bottom+35+i*(60);
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        
        
        UIView *line = [[UIView alloc]init];
        line.bounds = makeRect(0, 0, backView.width, 0.5);
        line.left = 0;
        line.bottom = backView.height;
        line.backgroundColor = CellLineColor;
        [backView addSubview:line];
        
        mTextField[i] = [[UITextField alloc]init];
        mTextField[i].bounds = makeRect(0, 0, backView.width, backView.height-1);
        mTextField[i].left = 0;
        mTextField[i].centerY = backView.height * 0.5;
        mTextField[i].placeholder = textArr[i];
        mTextField[i].tag = 10+i;
        mTextField[i].textColor = [UIColor blackColor];
        mTextField[i].textAlignment = NSTextAlignmentLeft;
        [backView addSubview:mTextField[i]];
        mTextField[i].font = makeFont(16);
        mTextField[i].delegate = self;
        mTextField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        if(i==0){
            mTextField[i].keyboardType = UIKeyboardTypeNumberPad;
        }else{
            mTextField[i].secureTextEntry = YES;
        }
        
        
        if(i == 1){
            mTextField[i].width -= 100;
            mTextField[i].left = 0;
            
            _smsView = [[SSSMSView alloc]initWithFrame:makeRect(0, 0, 85, 28)];
            _smsView.right = line.right;
            _smsView.centerY = mTextField[1].centerY;
            [backView addSubview:_smsView];
            [_smsView confirmPEBlock:^BOOL{
                if(self->mTextField[0].text == nil || self->mTextField[0].text.length == 0){
                    [self showTime:@"请输入手机号"];
                    return false;
                }else if(![NSString shoujihao:self->mTextField[0].text]){
                    [self showTime:@"请输入正确的手机号"];
                    return false;
                }else{
                    return true;
                }
            } sendBlock:^{
                [self sendCodeWithSMS];
            }];
        }
    }
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.bounds = makeRect(0, 0, 280, 45);
    loginBtn.centerX = self.view.centerX;
    loginBtn.top = 450;
    loginBtn.tag = 100;
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.height/2;
    loginBtn.backgroundColor = TitleColor;
    [loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    
}


//这里只对长度做检查
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if ([string length] == 0){
        return YES;
    }
    if (textField.tag == 10 && range.location < 11){
        return YES;
    }
    if(textField.tag == 11 && range.location < 10){
        return YES;
    }
    if(textField.tag == 12 && range.location < 16){
        return YES;
    }
    
    if(textField.tag == 13 && range.location < 16){
        return YES;
    }
    
    else{
        return NO;
    }
}

//扫一扫添加好友
-(void)rightBtnClick{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

//发送短信验证码
-(void)sendCodeWithSMS{
    
    [BmobSMS requestSMSCodeInBackgroundWithPhoneNumber:mTextField[0].text andTemplate:BmobSMSTemplate resultBlock:^(int number, NSError *error) {
        if(error){
            [self showTime:error.description];
        }else{
            [self showTime:@"短信发送成功"];
        }
    }];
}


//注册
-(void)buttonPressed:(UIButton *)sender{
    
    if(mTextField[0].text.length == 0){
        [self showTime:@"请输入手机号"];
    }else if (mTextField[1].text.length == 0){
        [self showTime:@"请输入短信验证码"];
    }else if (mTextField[2].text.length == 0){
        [self showTime:@"请输入密码"];
    }else if (mTextField[3].text.length == 0){
        [self showTime:@"请确认密码"];
    }else if (![NSString shoujihao:mTextField[0].text]){
        [self showTime:@"请输入合法手机号"];
    }else if (![mTextField[2].text isEqualToString:mTextField[3].text]){
        [self showTime:@"两次输入密码不一致"];
    }
    else{
        [self verifySMSCode:sender];
    }
}


//验证短信验证码
-(void)verifySMSCode:(UIButton *)sender{
    
    [sender addActivityOnBtn];
    [BmobSMS verifySMSCodeInBackgroundWithPhoneNumber:mTextField[0].text andSMSCode:mTextField[1].text resultBlock:^(BOOL isSuccessful, NSError *error) {
        [sender closeActivityByBtn:@"注册"];
        if(error){
            cout(error);
            [self showTime:error.description];
        }else{
            cout(@"短信验证成功");
            [self registerNetworking:sender];
        }
    }];
}


-(void)registerNetworking:(UIButton *)sender{
    
    NSString *userName = mTextField[0].text;
    NSString *nickName = makeString(@"Hello", [userName substringFromIndex:7]);
    NSString *passWord = mTextField[2].text;
    
    ServiceRegisterUser *user = [ServiceRegisterUser new];
    user.account = userName;
    user.nickname = nickName;
    user.token = [passWord md5String];
    
    [sender addActivityOnBtn];
    [ServiceRegisterTask registerUser:user completion:^(NSError *error, NSString *errorMsg) {
        [sender closeActivityByBtn:@"注册"];
        
        if(!error){
            [self showTime:@"注册成功"];
            [self performSelector:@selector(jumpTopRootController) withObject:nil afterDelay:1];
        }else{
            [self showTime:errorMsg];
        }
    }];
    
}


-(void)jumpTopRootController{
     [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
