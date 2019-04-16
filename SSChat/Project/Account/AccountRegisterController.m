//
//  AccountRegisterController.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "AccountRegisterController.h"
#import "MineScanningController.h"

@interface AccountRegisterController ()<UITextFieldDelegate>{
    UITextField *mTextField[3];
}

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
    
    
    NSArray *textArr = @[@"请输入手机号...",@"请输入密码...",@"请确认密码..."];
    for(int i=0;i<textArr.count;++i){
        
        UIView *backView = [[UIView alloc]init];
        backView.bounds = makeRect(0, 0, SCREEN_Width-65, 40);
        backView.centerX = SCREEN_Width * 0.5;
        backView.top = mTitleLab.bottom+35+i*(60);
        backView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView];
        
        
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
        
        UIView *line = [[UIView alloc]init];
        line.bounds = makeRect(0, 0, mTextField[0].width, 0.5);
        line.left = mTextField[0].left;
        line.bottom = backView.height;
        line.backgroundColor = CellLineColor;
        [backView addSubview:line];
        
    }
    
    
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.bounds = makeRect(0, 0, 280, 45);
    loginBtn.centerX = self.view.centerX;
    loginBtn.top = 380;
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
    
    if(textField.tag == 11 && range.location < 16){
        return YES;
    }
    
    if(textField.tag == 12 && range.location < 16){
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


//注册
-(void)buttonPressed:(UIButton *)sender{
    
    if(mTextField[0].text.length == 0){
        [self showTime:@"请输入手机号"];
    }else if (mTextField[1].text.length == 0){
        [self showTime:@"请输入密码"];
    }else if (mTextField[2].text.length == 0){
        [self showTime:@"请确认密码"];
    }else if (![NSString shoujihao:mTextField[0].text]){
        [self showTime:@"请输入合法手机号"];
    }else if (![mTextField[1].text isEqualToString:mTextField[2].text]){
        [self showTime:@"两次输入密码不一致"];
    }
    else{
        [self registerNetworking:sender];
    }
}

-(void)registerNetworking:(UIButton *)sender{
    
    NSString *userName = mTextField[0].text;
    NSString *passWord = mTextField[1].text;
    
    [sender addActivityOnBtn];
    [[EMClient sharedClient] registerWithUsername:userName password:passWord completion:^(NSString *aUsername, EMError *aError) {
        [sender closeActivityByBtn:@"注册"];
        
        if (!aError) {
            [self showTime:@"注册成功"];
            [self performSelector:@selector(jumpTopRootController) withObject:nil afterDelay:1];
            return ;
        }
        
        NSString *errorDes = @"注册失败，请重试";
        switch (aError.code) {
            case EMErrorServerNotReachable:
                errorDes = @"无法连接服务器";
                break;
            case EMErrorNetworkUnavailable:
                errorDes = @"网络未连接";
                break;
            case EMErrorUserAlreadyExist:
                errorDes = @"该账号已注册";
                break;
            case EMErrorExceedServiceLimit:
                errorDes = @"请求过于频繁，请稍后再试";
                break;
            default:
                break;
        }
        [self showTime:errorDes];
    }];
}


-(void)jumpTopRootController{
     [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
