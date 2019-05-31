//
//  AccountLoginController.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//


//登录界面
#import "AccountLoginController.h"
#import "AccountRegisterController.h"
#import "AccountForgotPasswordController.h"
#import "SSAccountManager.h"


@interface AccountLoginController (){
    UIView *backView[2];
    UITextField *mTextField[2];
}

@property(nonatomic,strong)UIImageView *logoImg;
@property(nonatomic,strong)NSUserDefaults *user;

@end

@implementation AccountLoginController

-(instancetype)init{
    if(self = [super init]){
        _user = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.tabBarController.tabBar.translucent = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgationNil];
    
    
    _logoImg = [[UIImageView alloc]init];
    _logoImg.bounds = makeRect(0, 0, 120*SCREEN_Width/375, 110*SCREEN_Height/667);
    _logoImg.centerX = self.view.centerX;
    _logoImg.top =  45*SCREEN_Height/667;
    _logoImg.image = makeImage(@"shangjia_home_icon");
    [self.view addSubview:_logoImg];
    
    
    NSInteger size = SCREEN_Width==320?80:(SCREEN_Width==375?90:100);
    UILabel *tl = [[UILabel alloc]init];
    tl.bounds = makeRect(0, 0, SCREEN_Width, 110*SCREEN_Height/667);
    tl.centerX = self.view.centerX;
    tl.top =  70*SCREEN_Height/667;
    tl.textColor = TitleColor;
    [self.view addSubview:tl];
    tl.text = @"Hello";
    tl.font = [UIFont fontWithName:@"Snell Roundhand" size:size];
    tl.textAlignment = NSTextAlignmentCenter;
    
    
    NSArray *textArr = @[@"请输入账号...",@"请输入密码..."];
    NSArray *imgArr = @[@"gerenxingxi_one",@"mima_one"];
    for(int i=0;i<2;++i){
        
        backView[i] = [[UIView alloc]init];
        backView[i].bounds = makeRect(0, 0, SCREEN_Width, 40);
        backView[i].left = 0;
        backView[i].top = _logoImg.bottom+35+i*(60);
        backView[i].backgroundColor = [UIColor whiteColor];
        [self.view addSubview:backView[i]];
        
        
        UIImageView *icon = [[UIImageView alloc]init];
        icon.bounds = makeRect(0, 0, 30, 30);
        icon.left = 45*SCREEN_Width/375;
        icon.top = 7;
        icon.image = makeImage(imgArr[i]);
        [backView[i] addSubview:icon];
        
        
        mTextField[i] = [[UITextField alloc]init];
        mTextField[i].bounds = makeRect(0, 0, 230*SCREEN_Width/375, backView[i].height);
        mTextField[i].left = icon.right+15;
        mTextField[i].top = 0;
        mTextField[i].placeholder = textArr[i];
        mTextField[i].textColor = [UIColor blackColor];
        mTextField[i].textAlignment = NSTextAlignmentLeft;
        [backView[i] addSubview:mTextField[i]];
        mTextField[i].font = makeFont(16);
        mTextField[i].delegate = self;
        mTextField[i].clearButtonMode = UITextFieldViewModeWhileEditing;
        if(i==0){
            mTextField[i].keyboardType = UIKeyboardTypeNumberPad;
        }else{
            mTextField[i].secureTextEntry = YES;
        }
        
        UIView *line = [[UIView alloc]init];
        line.bounds = makeRect(0, 0, 230*SCREEN_Width/375, 0.5);
        line.left = 90*SCREEN_Width/375;
        line.top = 39;
        line.backgroundColor = CellLineColor;
        [backView[i] addSubview:line];
        
    }
    
    
    //登陆
    UIButton *loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    loginBtn.bounds = makeRect(0, 0, 280, 45);
    loginBtn.centerX = self.view.centerX;
    loginBtn.top = backView[1].bottom+50;
    loginBtn.tag = 100;
    loginBtn.clipsToBounds = YES;
    loginBtn.layer.cornerRadius = loginBtn.height/2;
    loginBtn.backgroundColor = TitleColor;
    [loginBtn setTitle:@"登陆" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    
    //注册
    UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    registerBtn.frame = loginBtn.frame;
    registerBtn.top = loginBtn.bottom + 15;
    registerBtn.tag = 50;
    registerBtn.clipsToBounds = YES;
    registerBtn.layer.cornerRadius = loginBtn.height/2;
    registerBtn.backgroundColor = [UIColor whiteColor];
    registerBtn.layer.borderWidth = 1;
    registerBtn.layer.borderColor = TitleColor.CGColor;
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [registerBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
    
    //忘记密码
    UIButton *forgetBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    forgetBtn.bounds = makeRect(0, 0, 120, 35);
    forgetBtn.centerX = self.view.centerX;
    forgetBtn.top = registerBtn.bottom + 10;
    forgetBtn.tag = 51;
    [forgetBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    [forgetBtn setTitleColor:TitleColor forState:UIControlStateNormal];
    [forgetBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:forgetBtn];
    
    
}


//注册50  忘记密码51   登陆100
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag==50){
        AccountRegisterController *vc = [AccountRegisterController new];
        [self.navigationController pushViewController:vc animated:YES]; 
    }else if (sender.tag==51){
        AccountForgotPasswordController *vc = [AccountForgotPasswordController new];
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [self loginNetworking:sender];
    }
}


//登陆
-(void)loginNetworking:(UIButton *)sender{
    
    NSString *phoneNum   = mTextField[0].text;
    NSString *passWorld  = mTextField[1].text;
    if([phoneNum isEqualToString:@""]){
        [self showTime:@"请输入账号!"];
    }else if([passWorld isEqualToString:@""]){
        [self showTime:@"请输入密码!"];
    }else{
        NSString *token = [passWorld md5String];
        [self loginIM:sender phoneNum:phoneNum token:token];
    }
}


-(void)loginIM:(UIButton *)sender phoneNum:(NSString *)phoneNum token:(NSString *)token{
    
    cout(token);
    
    [sender addActivityOnBtn];
    [[NIMSDK sharedSDK].loginManager login:phoneNum token:token  completion:^(NSError * _Nullable error) {
        [sender closeActivityByBtn:@"登录"];
        if(error){
            cout(error.description);
            [self showTime:error.description];
        }else{
            cout(@"登录成功");
            SSAccountModel *model = [SSAccountModel new];
            model.account = phoneNum;
            model.password = token;
            [SSAccountManager shareSSAccountManager].accountModel = model;
            [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@YES];
        }
    }];
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
    
    else{
        return NO;
    }
}



@end
