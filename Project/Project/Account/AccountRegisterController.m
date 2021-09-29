//
//  AccountRegisterController.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//


#import "AccountRegisterController.h"
#import "SSSMSView.h"
#import "AccountData.h"
#import "AccountSettingPasswordController.h"


@interface AccountRegisterController (){
    UIView *backView[4];
    UITextField *mTextField[4];
}

@property(nonatomic,strong)UIButton *codeButton;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic, strong)SSSMSView *smsView;
@property(nonatomic,strong)YYLabel *serviceLabel;

//三方登录模块
@property(nonatomic,strong)UIView *mBottomView;
@property(nonatomic,strong)UIView *mLine1;
@property(nonatomic,strong)UIView *mLine2;
@property(nonatomic,strong)UILabel *mLabel;
@property(nonatomic,strong)UIButton *mButton1;
@property(nonatomic,strong)UIButton *mButton2;
@property(nonatomic,strong)UIButton *mButton3;

//加盟入驻
@property(nonatomic,strong)YYLabel *serviceLabel2;

@end

@implementation AccountRegisterController

-(instancetype)init{
    if(self = [super init]){
        self.user = [NSUserDefaults standardUserDefaults];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"注册"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;
    
    
    NSArray *textArr = @[@"请选择电话区域",@"请输入注册的手机号",@"短信动态码",@"请输入邀请码"];
    for(int i=0;i<4;++i){
        
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
        if(i == 1 || i == 2){
            mTextField[i].keyboardType = UIKeyboardTypeNumberPad;
        }
         
        if(i==0){
            
            mTextField[0].text = @"+86";
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
    _loginBtn.top = backView[3].bottom+42;
    _loginBtn.tag = 100;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = _loginBtn.height/2;
    _loginBtn.backgroundColor = TitleColor;
    [_loginBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    
    NSString *tagStr2 = @"立即登录";
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:@"已有账户，立即登录"];
    [text2 setColor:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, text2.length)];
    [text2 setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, text2.length)];
    [text2 setLineSpacing:5];
    [text2 setTextHighlightRange:NSMakeRange(text2.length-tagStr2.length, tagStr2.length) color:makeColorHex(@"#30A5DD") backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    _serviceLabel = [YYLabel new];
    _serviceLabel.numberOfLines =0;
    _serviceLabel.userInteractionEnabled = YES;
    _serviceLabel.bounds = CGRectMake(0,0, SCREEN_Width-24,80);
    [self.view addSubview:_serviceLabel];
    _serviceLabel.attributedText = text2;
    [_serviceLabel sizeToFit];
    _serviceLabel.backgroundColor = [UIColor whiteColor];
    _serviceLabel.top = _loginBtn.bottom + 32;
    _serviceLabel.centerX = SCREEN_Width * 0.5;
    _serviceLabel.textAlignment = NSTextAlignmentCenter;
    
    
    NSString *bottomText1 = @"《趣找房用户协议》";
    NSMutableAttributedString *bottomText = [[NSMutableAttributedString alloc] initWithString:@"注册登录即表示已阅读并同意了《趣找房用户协议》"];
    [bottomText setColor:[UIColor colorWithHexString:@"#666666"] range:NSMakeRange(0, bottomText.length)];
    [bottomText setFont:[UIFont systemFontOfSize:13] range:NSMakeRange(0, bottomText.length)];
    [bottomText setTextHighlightRange:NSMakeRange(0, bottomText1.length) color:makeColorHex(@"#666666") backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self showTime:@"用户协议"];
    }];
    _serviceLabel2 = [YYLabel new];
    _serviceLabel2.userInteractionEnabled = YES;
    _serviceLabel2.bounds = CGRectMake(0,0, SCREEN_Width-24,80);
    [self.view addSubview:_serviceLabel2];
    _serviceLabel2.attributedText = bottomText;
    [_serviceLabel2 sizeToFit];
    _serviceLabel2.backgroundColor = [UIColor whiteColor];
    _serviceLabel2.bottom = SCREEN_Height - SafeAreaBottom_Height - 22;
    _serviceLabel2.centerX = SCREEN_Width * 0.5;
    _serviceLabel2.textAlignment = NSTextAlignmentCenter;
    
    
//    _mBottomView = [UIView new];
//    [self.view addSubview:_mBottomView];
//    _mBottomView.bounds = makeRect(0, 0, SCREEN_Width, 100);
//    _mBottomView.backgroundColor = [UIColor whiteColor];
//    _mBottomView.left = 0;
//    _mBottomView.bottom = SCREEN_Height - SafeAreaBottom_Height - 100;
//
//
//    _mLabel = [UILabel new];
//    _mLabel.bounds = makeRect(0, 0, 200, 20);
//    [_mBottomView addSubview:_mLabel];
//    _mLabel.font = makeFont(13);
//    _mLabel.textColor = makeColorHex(@"#666666");
//    _mLabel.text = @"第三方登录";
//    [_mLabel sizeToFit];
//    _mLabel.centerX = _mBottomView.width * 0.5;
//    _mLabel.top = 0;
//
//    _mLine1 = [UIView new];
//    _mLine1.bounds = makeRect(0, 0, 115, 1);
//    _mLine1.backgroundColor = makeColorHex(@"#F5F5F5");
//    _mLine1.centerY = _mLabel.centerY;
//    _mLine1.right = _mLabel.left - 15;
//    [_mBottomView addSubview:_mLine1];
//
//    _mLine2 = [UIView new];
//    _mLine2.bounds = makeRect(0, 0, 115, 1);
//    _mLine2.backgroundColor = makeColorHex(@"#F5F5F5");
//    _mLine2.centerY = _mLabel.centerY;
//    _mLine2.left = _mLabel.right + 15;
//    [_mBottomView addSubview:_mLine2];
//
//
//    _mButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
//    _mButton1.bounds = makeRect(0, 0, 40, 40);
//    _mButton1.left = 64;
//    _mButton1.bottom = _mBottomView.height;
//    _mButton1.tag = 101;
//    _mButton1.clipsToBounds = YES;
//    _mButton1.layer.cornerRadius = _mButton1.height/2;
//    _mButton1.backgroundColor = makeColorHex(@"#30A5DD");
//    [_mButton1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [_mBottomView addSubview:_mButton1];
//
//
//    _mButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
//    _mButton2.bounds = makeRect(0, 0, 40, 40);
//    _mButton2.centerX = SCREEN_Width * 0.5;
//    _mButton2.bottom = _mBottomView.height;
//    _mButton2.tag = 102;
//    _mButton2.clipsToBounds = YES;
//    _mButton2.layer.cornerRadius = _mButton2.height/2;
//    _mButton2.backgroundColor = makeColorHex(@"#00C785");
//    [_mButton2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [_mBottomView addSubview:_mButton2];
//
//
//    _mButton3 = [UIButton buttonWithType:UIButtonTypeSystem];
//    _mButton3.bounds = makeRect(0, 0, 40, 40);
//    _mButton3.right = SCREEN_Width - 64;
//    _mButton3.bottom = _mBottomView.height;
//    _mButton3.tag = 103;
//    _mButton3.clipsToBounds = YES;
//    _mButton3.layer.cornerRadius = _mButton3.height/2;
//    _mButton3.backgroundColor = makeColorHex(@"#EA5D5C");
//    [_mButton3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [_mBottomView addSubview:_mButton3];
    
    
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
    if(textField == mTextField[3] && range.location < 16){
        return YES;
    }
    
    else{
        return NO;
    }
}

//发送短信验证码
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

//选择区号10  注册50  忘记密码51
//注册并下一步100+
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag == 10){

    }
    
    if(sender.tag==50){
        AccountRegisterController *vc = [AccountRegisterController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (sender.tag==51){
       [self showTime:@"忘记密码"];
    }
    
    if(sender.tag == 100){
        [self registerNetworking:sender];
        
    }
    
    if(sender.tag == 101){
        [self showTime:@"QQ登录"];
    }
    
    if(sender.tag == 102){
        [self showTime:@"微信登录"];
    }
    if(sender.tag == 103){
        [self showTime:@"微博登录"];
    }
}


//注册
-(void)registerNetworking:(UIButton *)sender{
    

    
    NSString *phoneNum   = mTextField[1].text;
    NSString *passWorld  = mTextField[2].text;
    if([phoneNum isEqualToString:@""]){
        [self showTime:@"请输入账号!"];
    }else if([passWorld isEqualToString:@""]){
        [self showTime:@"请输入验证码!"];
    }else{
        
        NSString *pu = @"1517bfd3f74107331bb";
        
        NSDictionary *dic = @{@"phone":mTextField[1].text,
                              @"code":mTextField[2].text,
                              @"spread_code":mTextField[3].text,
                              @"jpush_registration_id":@"1517bfd3f74107331bb"
        };
        
        cout(dic);
        [sender addActivityOnBtn];
        [SSAFRequest RequestNetWorking:SSRequestPost parameters:dic method:URLSMSLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
             [sender closeActivityByBtn:@"注册"];
             
            if(error){
                [self showTime:error.domain];
            }else{
                NSDictionary *dict = makeDicWithJsonStr(object);
                cout(dict);
                
                if([dict[@"code"] integerValue] != 1){
                    [self showTime:dict[@"msg"]];
                }
                else{
                    
                    [self loginJump:dict];
                    
                }
            }
        }];
        
        
//        SSAccountModel *model = [SSAccountModel new];
//        model.account = @"13540033103";
//        model.password = @"qqqq1111";
//        [SSAccountManager shareManager].model = model;
//
//       //经纪人端
//        if(sender.tag == 100){
//            [SSConfigManager shareManager].tabType = TabBarQuAgent;
//            [self sendNotifCation:NotiLoginStatusChange data:@(YES)];
//        }
//        //开发商端
//        else{
//            [SSConfigManager shareManager].tabType = TabBarQuDeveloper;
//            [self sendNotifCation:NotiLoginStatusChange data:@(YES)];
//        }
    }
}

//登录后的数据持久化
-(void)loginJump:(NSDictionary *)dic{
    
    [SSRootAccount setUserInfo:dic];
    
    AccountSettingPasswordController *vc = [AccountSettingPasswordController new];
    [self.navigationController pushViewController:vc animated:YES];
}




@end
