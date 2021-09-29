//
//  AccountSettingPasswordController.m
//  QuFound
//
//  Created by soldoros on 2020/5/14.
//  Copyright © 2020 soldoros. All rights reserved.
//

//设置登录密码
#import "AccountSettingPasswordController.h"
#import "AccountData.h"


@interface AccountSettingPasswordController (){
    UIView *backView[2];
    UITextField *mTextField[2];
}

@property(nonatomic,strong) UIButton *loginBtn;

@property(nonatomic,strong) UILabel *mTitleLab1;
@property(nonatomic,strong) UILabel *mTitleLab2;


@end

@implementation AccountSettingPasswordController

-(instancetype)init{
    if(self = [super init]){
        self.user = [NSUserDefaults standardUserDefaults];
        _type = 1;
        _code = @"";
        _phone = @"";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;
    
    _mTitleLab1 = [UILabel new];
    [self.view addSubview:_mTitleLab1];
    _mTitleLab1.bounds = makeRect(0, 0, 200, 20);
    _mTitleLab1.font = makeBlodFont(24);
    _mTitleLab1.textColor = makeColorHex(@"#1B1919");
    _mTitleLab1.text = @"设置登录密码";
    if(_type == 2){
        _mTitleLab1.text = @"修改登录密码";
    }
    if(_type == 3){
        _mTitleLab1.text = @"找回登录密码";
    }
    [_mTitleLab1 sizeToFit];
    _mTitleLab1.left = 32;
    _mTitleLab1.top = SafeAreaTop_Height + 42;
    
    
    _mTitleLab2 = [UILabel new];
    [self.view addSubview:_mTitleLab2];
    _mTitleLab2.bounds = makeRect(0, 0, SCREEN_Width - 64, 20);
    _mTitleLab2.font = makeFont(15);
    _mTitleLab2.textColor = makeColorHex(@"#BBBBBB");
    _mTitleLab2.numberOfLines = 2;
    _mTitleLab2.textAlignment = NSTextAlignmentLeft;
    NSString *string = @"为账户安全，密码长度为6～16位数，且不可为单一字母和数字";
    setLabHeight(_mTitleLab2, string, 4);
    [_mTitleLab2 sizeToFit];
    _mTitleLab2.left = 32;
    _mTitleLab2.top = _mTitleLab1.bottom + 6;
    
    
    NSArray *textArr = @[@"请输入密码",@"请再次输入密码"];
    for(int i=0;i<2;++i){
        
        backView[i] = [[UIView alloc]init];
        backView[i].bounds = makeRect(0, 0, SCREEN_Width - 64, 45);
        backView[i].left = 32;
        backView[i].top = SafeAreaTop_Height + 142 + i*53;
        backView[i].backgroundColor = makeColorHex(@"#F6F6F6");
        [self.view addSubview:backView[i]];
        backView[i].clipsToBounds = YES;
        backView[i].layer.cornerRadius = 4;
     
        
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
        mTextField[i].secureTextEntry = YES;
        
        
    }
    
    
    
    
    //登陆经纪人端
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.bounds = makeRect(0, 0, SCREEN_Width - 64, 45);
    _loginBtn.centerX = self.view.centerX;
    _loginBtn.top = backView[1].bottom+48;
    _loginBtn.tag = 100;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = _loginBtn.height/2;
    _loginBtn.backgroundColor = TitleColor;
    [_loginBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    if(_code.length>0){
        [_loginBtn setTitle:@"设置密码" forState:UIControlStateNormal];
    }
    
}

//这里只对长度做检查
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 0){
        return YES;
    }
    
    if (textField == mTextField[0] && range.location < 16){
        return YES;
    }
    
    if(textField == mTextField[1] && range.location < 16){
        return YES;
    }
    
    else{
        return NO;
    }
}


//选择区号10  注册50  忘记密码51
//下一步100
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag == 10){
        
    }
    
    if(sender.tag==50){
       
        
    }
    
    if (sender.tag==51){
       [self showTime:@"忘记密码"];
    }
    
    if(sender.tag == 100){
        
        NSString *passWorld1   = mTextField[0].text;
        NSString *passWorld2  = mTextField[1].text;
        if([passWorld1 isEqualToString:@""]){
            [self showTime:@"请输入密码"];
            return;
        }
        if([passWorld2 isEqualToString:@""]){
            [self showTime:@"请再次输入密码"];
            return;
        }
        if(![passWorld1 isEqualToString:passWorld2]){
            [self showTime:@"请两次输入密码不一致"];
            return;
        }
        
        //注册设置密码
        if(_code.length == 0){
            [self setPasswordNet:sender];
        }
        //修改
        else if(_type == 2){
            [self setPasswordNet2:sender];
        }
        //忘记密码
        else{
            [self setPasswordNet3:sender];
        }
    }
}

-(void)setPasswordNet:(UIButton *)sender{
    
    
    NSDictionary *dic = @{@"password":mTextField[0].text};
    
    
    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestPostHeader parameters:dic method:URLSMSLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
         [sender closeActivityByBtn:@"下一步"];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 1){
                [self showTime:dict[@"msg"]];
            }
            else{
                
            }
        }
    }];
}


//修改密码
-(void)setPasswordNet2:(UIButton *)sender{
    
    
    NSDictionary *dic = @{@"password":mTextField[0].text,
                          @"code":_code
    };
    
    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestPostHeader parameters:dic method:URLSMSLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
         [sender closeActivityByBtn:@"设置密码"];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 1){
                [self showTime:dict[@"msg"]];
            }
            else{
                
                [self showTime:@"密码设置成功"];
                [self performSelector:@selector(jump) afterDelay:1];
            }
        }
    }];
}


//忘记密码
-(void)setPasswordNet3:(UIButton *)sender{
    
    
    NSDictionary *dic = @{@"password":mTextField[0].text,
                          @"code":_code,
                          @"phone":_phone
    };
    
    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestPost parameters:dic method:URLSMSLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
         [sender closeActivityByBtn:@"设置密码"];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 1){
                [self showTime:dict[@"msg"]];
            }
            else{
                
                [self showTime:@"密码设置成功"];
                [self performSelector:@selector(jump2) afterDelay:1];
            }
        }
    }];
}


-(void)jump{
    [self.navigationController popToViewController:self.navigationController.viewControllers[1] animated:YES];
}

-(void)jump2{
    [self.navigationController popToRootViewControllerAnimated:YES];
}



@end
