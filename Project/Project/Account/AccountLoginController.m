//
//  AccountLoginController.m
//  SSChat
//
//  Created by soldoros on 2020/3/3.
//  Copyright © 2020 soldoros. All rights reserved.
//


//登录界面
#import "AccountLoginController.h"
#import "AccountRegisterController.h"
#import "SSSMSView.h"
#import "AccountData.h"
#import "AccountSettingPasswordController.h"
#import "AccountCodeController.h"
#import "SSAddImage.h"
#import "AccountMoblieLoginController.h"
#import "PBWebController.h"



@interface AccountLoginController (){
    UIButton *mButton[3];
}

@property(nonatomic,strong)SSAppleLogin *appleLogin;
@property(nonatomic,strong)UIImageView *mLogo;
@property(nonatomic,strong)UILabel *mLabel1;
@property(nonatomic,strong)UILabel *mLabel2;
@property(nonatomic,strong)YYLabel *serviceLabel;

@property(nonatomic,strong)UIButton *mButton1;
@property(nonatomic,strong)UIButton *mButton2;
@property(nonatomic,strong)UIButton *mButton3;


@end

@implementation AccountLoginController

-(instancetype)init{
    if(self = [super init]){
        self.user = [NSUserDefaults standardUserDefaults];
        _appleLogin = [SSAppleLogin new];
    }
    return self;
}

-(void)navgationButtonPressed:(UIButton *)sender{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

-(void)regsiterNoti{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wxLoginOver:) name:NotiWXLoginOver object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self regsiterNoti];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navLine.hidden = YES;

    
    //300 * 238  login_logo
    _mLogo = [UIImageView new];
    [self.view addSubview:_mLogo];
    _mLogo.bounds = makeRect(0, 0, 150,  150);
    _mLogo.centerX = SCREEN_Width * 0.5;
    _mLogo.top = SafeAreaTop_Height + 30;
    _mLogo.image = [UIImage imageNamed:@"fuwan_logo"];
    
    
    _mLabel1 = [UILabel new];
    _mLabel1.bounds = makeRect(0, 0, 200, 20);
    [self.view addSubview:_mLabel1];
    _mLabel1.font = makeBlodFont(19);
    _mLabel1.textColor = makeColorHex(@"#333333");
    _mLabel1.text = @"开启潮流生活";
    [_mLabel1 sizeToFit];
    _mLabel1.centerX = SCREEN_Width * 0.5;
    _mLabel1.top = _mLogo.bottom + 15;
    
    
    //微信登录
    _mButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton1.bounds = makeRect(0, 0, SCREEN_Width - 110, 45);
    _mButton1.centerX = self.view.centerX;
    _mButton1.top = _mLabel1.bottom + 60;
    _mButton1.tag = 10;
    _mButton1.clipsToBounds = YES;
    _mButton1.layer.cornerRadius = _mButton1.height/2;
    _mButton1.backgroundColor = makeColorHex(@"#333333");
    [_mButton1 setTitle:@"微信登录" forState:UIControlStateNormal];
    [_mButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _mButton1.titleLabel.font = makeBlodFont(18);
    [_mButton1 setImage:[UIImage imageNamed:@"login_weixin"] forState:UIControlStateNormal];
    _mButton1.imageEdgeInsets = UIEdgeInsetsMake(0, -50, 0, 0);
    [self.view addSubview:_mButton1];
    [_mButton1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UILabel *mLab = [UILabel new];
    mLab.bounds = makeRect(0, 0, 200, 20);
    [self.view addSubview:mLab];
    mLab.font = makeFont(11);
    mLab.textColor = makeColorHex(@"#AAAAAA");
    mLab.text = @"其他方式登录";
    [mLab sizeToFit];
    mLab.centerX = SCREEN_Width * 0.5;
    mLab.top = _mButton1.bottom + 80;
    
    UIView *mLine1 = [UIView new];
    [self.view addSubview:mLine1];
    mLine1.bounds = makeRect(0, 0, 60, 1);
    mLine1.backgroundColor = makeColorHex(@"#AAAAAA");
    mLine1.centerY = mLab.centerY;
    mLine1.right = mLab.left - 18;
    
    UIView *mLine2 = [UIView new];
    [self.view addSubview:mLine2];
    mLine2.bounds = makeRect(0, 0, 60, 1);
    mLine2.backgroundColor = makeColorHex(@"#AAAAAA");
    mLine2.centerY = mLab.centerY;
    mLine2.left = mLab.right + 18;
    
    
    
    //手机号登录
    _mButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton2.bounds = makeRect(0, 0, 55, 60);
    _mButton2.right = self.view.width*0.5 - 30;
    _mButton2.top = mLab.bottom + 25;
    _mButton2.tag = 11;
    [_mButton2 setImage:[UIImage imageNamed:@"login_shouji"] forState:UIControlStateNormal];
    [_mButton2 setTitle:@"手机登录" forState:UIControlStateNormal];
    [_mButton2 setTitleColor:makeColorHex(@"#666666") forState:UIControlStateNormal];
    _mButton2.titleLabel.font = makeFont(12);
    [_mButton2 setBtnCenterHeight:0 distTance:5];
    [self.view addSubview:_mButton2];
    [_mButton2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
 
    
    
    //苹果id登录
    _mButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton3.bounds = makeRect(0, 0, 55, 60);
    _mButton3.left = self.view.width*0.5 + 30;
    _mButton3.top = mLab.bottom + 25;
    _mButton3.tag = 12;
    [_mButton3 setImage:[UIImage imageNamed:@"login_app"] forState:UIControlStateNormal];
    [_mButton3 setTitle:@"苹果登录" forState:UIControlStateNormal];
    [_mButton3 setTitleColor:makeColorHex(@"#666666") forState:UIControlStateNormal];
    _mButton3.titleLabel.font = makeFont(12);
    [_mButton3 setBtnCenterHeight:0 distTance:0];
    [self.view addSubview:_mButton3];
    [_mButton3 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    NSString *tagStr1 = @"";
   NSString *tagStr2 = @"《福app用户协议》";
    NSString *tagStr3 = @"《福app隐私政策》";
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:@"《福app用户协议》《福app隐私政策》"];
    [text2 setColor:[UIColor colorWithHexString:@"#333333"] range:NSMakeRange(0, text2.length)];
    [text2 setFont:[UIFont systemFontOfSize:12] range:NSMakeRange(0, text2.length)];
    [text2 setLineSpacing:15];
    
    [text2 setTextHighlightRange:NSMakeRange(0, tagStr2.length) color:[UIColor blackColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        [self xieyiNetworking];
        
    }];
    
    [text2 setTextHighlightRange:NSMakeRange(tagStr2.length+tagStr1.length, tagStr3.length) color:[UIColor blackColor] backgroundColor:[UIColor clearColor] tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
        
        //隐私协议
        PBWebController *vc = [PBWebController new];
        vc.webTitle = @"隐私协议";
        vc.urlString = @"https://www.fusneaker.com/fuapp_privacy.html";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    
    _serviceLabel = [YYLabel new];
    _serviceLabel.numberOfLines =0;
    _serviceLabel.userInteractionEnabled = YES;
    _serviceLabel.bounds = CGRectMake(0,0, SCREEN_Width-100,80);
    [self.view addSubview:_serviceLabel];
    _serviceLabel.attributedText = text2;
    [_serviceLabel sizeToFit];
    _serviceLabel.backgroundColor = [UIColor whiteColor];
    _serviceLabel.bottom = SCREEN_Height - SafeAreaBottom_Height - 20;
    _serviceLabel.left = 70;
    _serviceLabel.textAlignment = NSTextAlignmentCenter;
    
    
    _mLabel2 = [UILabel new];
    _mLabel2.bounds = makeRect(0, 0, 200, 20);
    [self.view addSubview:_mLabel2];
    _mLabel2.font = makeFont(12);
    _mLabel2.textColor = makeColorHex(@"#999999");
    _mLabel2.text = @"登陆即表示您已阅读并同意";
    [_mLabel2 sizeToFit];
    _mLabel2.left = _serviceLabel.left+2;
    _mLabel2.bottom = _serviceLabel.top - 5;
}
//
////这里只对长度做检查
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//    if ([string length] == 0){
//        return YES;
//    }
//
//    if (textField == mTextField[0] && range.location < 32){
//        return YES;
//    }
//
//    if(textField == mTextField[1] && range.location < 32){
//        return YES;
//    }
//
//    else{
//        return NO;
//    }
//}

//微信登录10  手机号登录11  苹果登录12
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender.tag == 10){
        [self sendNotifCation:NotiWXLogin];
    }
    if(sender.tag == 11){
        AccountMoblieLoginController *vc = [AccountMoblieLoginController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if(sender.tag == 12){
        
        [_appleLogin appleLoginBlock:^(NSDictionary *dic) {
            cout(dic);
            if([dic[@"code"]integerValue] != 1){
                [self showTime:dic[@"msg"]];
            }else{
                NSString *userId = dic[@"id"];
                NSString *token = dic[@"token"];
                NSString *auth_code = dic[@"auth_code"];
                
                NSDictionary *dic = @{@"action":@"2",
                                      @"auth_code":auth_code,
                                      @"id_token":token,
                                      @"user_id":userId
                };
                [self LoginNetworking:dic];
            }
        }];
    }
}

//微信登录
-(void)wxLoginOver:(NSNotification *)noti{
    NSString *code = noti.object;
    
    NSDictionary *dic = @{@"action":@"1",
                          @"code":code
    };
    [self LoginNetworking:dic];
}

//action微信登录1   苹果登录2
-(void)LoginNetworking:(NSDictionary *)dic{
    
    cout(dic);
    [self addSysIndicatorView];
    [SSAFRequest RequestNetWorking:SSRequestGet parameters:dic method:URLappLogin requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [self deleteSysIndicatorView];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 0){
                [self showTime:dict[@"msg"]];
            }
            else{
                
                [self.navigationController dismissViewControllerAnimated:YES completion:^{
                    [SSRootAccount setUserToken:dict];
                    if(dict[@"phone"]==nil){
                        [SSRootAccount setUserPhone:dict[@"mid"]];
                    }else{
                        [SSRootAccount setUserPhone:dict[@"phone"]];
                    }
                    [SSRootAccount setUserLogin:@"1"];
                    [self sendNotifCation:NotiLoginStatusChange data:@(YES)];
                }];
            }
        }
    }];
}


//登录后的数据持久化
-(void)loginJump:(NSDictionary *)dic{

    
    [self sendNotifCation:NotiLoginStatusChange data:@(YES)];
}



//获取协议
-(void)xieyiNetworking{
    
    [self addSysIndicatorView];
    [SSAFRequest RequestNetWorking:SSRequestGet parameters:@{} method:URRule requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [self deleteSysIndicatorView];
         
        if(error){
            [self showTime:error.domain];
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"] integerValue] != 0){
                [self showTime:dict[@"msg"]];
            }
            else{
                
                //用户协议
                PBWebController *vc = [PBWebController new];
                vc.webTitle = @"用户协议";
                vc.htmlString = dict[@"data"][@"content"];
                [self.navigationController pushViewController:vc animated:YES];
                
                [AccountData shareInfoNetWorking];
            }
        }
    }];
}


@end
