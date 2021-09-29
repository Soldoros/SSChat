//
//  AccountMoblieBindingController.m
//  FuWan
//
//  Created by soldoros on 2021/9/1.
//

//绑定手机号
#import "AccountMoblieBindingController.h"
#import "SSSMSView.h"
#import "AccountView.h"
#import "AccountSettingPasswordController.h"
#import "AccountData.h"

@interface AccountMoblieBindingController ()

@property(nonatomic,strong)UILabel *mLabel;

@property(nonatomic,strong) UIButton *loginBtn;
@property(nonatomic, strong)SSSMSView *smsView;
@property(nonatomic,strong)YYLabel *serviceLabel;



@end

@implementation AccountMoblieBindingController

-(instancetype)init{
    if(self = [super init]){
        self.user = [NSUserDefaults standardUserDefaults];

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"绑定手机"];
    self.view.backgroundColor = [UIColor whiteColor];
        
    _mLabel = [UILabel new];
    [self.view addSubview:_mLabel];
    _mLabel.textColor = makeColorHex(@"#000000");
    _mLabel.font = makeBlodFont(18);
    _mLabel.text = @"绑定手机号";
    [_mLabel sizeToFit];
    _mLabel.left = 55;
    _mLabel.top = SafeAreaTop_Height + 100;
    
    
    NSArray *textArr = @[@"请输入手机号",@"请输入验证码"];
    for(int i=0;i<2;++i){
        
        UIView *mView1 = [[UIView alloc]init];
        mView1.bounds = makeRect(0, 0, SCREEN_Width - 110, 60);
        mView1.centerX = SCREEN_Width * 0.5;
        mView1.top = _mLabel.bottom + 13 + i*60;
        [self.view addSubview:mView1];
        mView1.backgroundColor = [UIColor whiteColor];
        
        
        UITextField *mTextField = [[UITextField alloc]init];
        mTextField.bounds = makeRect(0, 0, 180, 50);
        mTextField.left = 0;
        mTextField.top = 10;
        mTextField.tag = 50+i;
        mTextField.attributedPlaceholder = [NSString placehodString:textArr[i] color:makeColorHex(@"#999999")];
        mTextField.textColor = makeColorHex(@"#333333");
        mTextField.textAlignment = NSTextAlignmentLeft;
        [mView1 addSubview:mTextField];
        mTextField.font = makeFont(15);
        mTextField.delegate = self;
        mTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
        mTextField.secureTextEntry = NO;
        mTextField.userInteractionEnabled = YES;
        mTextField.keyboardType = UIKeyboardTypeNumberPad;
        
        if(i == 0){
            mTextField.left = 60;
        
            UIButton *_codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _codeButton.frame = makeRect(0, 10, 50, 50);
            [mView1 addSubview:_codeButton];
            [_codeButton setTitle:@"+86" forState:UIControlStateNormal];
            [_codeButton setTitleColor:makeColorHex(@"#333333") forState:UIControlStateNormal];
            _codeButton.titleLabel.font = makeFont(15);
            _codeButton.tag = 20;
            [_codeButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            
            UIView *mLine0 = [UIView new];
            [mView1 addSubview:mLine0];
            mLine0.bounds = makeRect(0, 0, 0.5, 20);
            mLine0.backgroundColor = makeColorHex(@"#C4C4C4");
            mLine0.left = 50;
            mLine0.centerY = mTextField.centerY;
        }
        
        if(i == 1){
            
            _smsView = [[SSSMSView alloc]initWithFrame:makeRect(0, 0, 88, 24)];
            _smsView.mGetPassBtn.titleLabel.font = makeFont(15);
            _smsView.centerY = mTextField.centerY;
            _smsView.right = mView1.width;
            _smsView.buttonColor = makeColorHex(@"#666666");
            _smsView.mGetPassBtn.titleLabel.font = makeFont(12);
            [_smsView.mGetPassBtn setTitleColor:makeColorHex(@"#FFFFFF") forState:UIControlStateNormal];
            _smsView.backgroundColor = [UIColor blackColor];
            _smsView.clipsToBounds = YES;
            _smsView.layer.cornerRadius = 3;
            [mView1 addSubview:_smsView];
            
            UITextField *mTextF = [self.view viewWithTag:50];
            [_smsView confirmPEBlock:^BOOL{
                
                if(mTextF.text.length == 0){
                    [self showTime:@"请输入手机号"];
                    return NO;
                }
                else if(![NSString shoujihao:mTextF.text]){
                    [self showTime:@"请输入正确的手机号"];
                    return  NO;
                }
                else{
                    return YES;
                }
            } sendBlock:^{
                    [self sendSMS];
            }];
            
        }
        
        
        UIView *mLine = [UIView new];
        [mView1 addSubview:mLine];
        mLine.bounds = makeRect(0, 0, mView1.width, 0.5);
        mLine.backgroundColor = makeColorHex(@"#C4C4C4");
        mLine.centerX = mView1.width * 0.5;
        mLine.bottom = mView1.height;
        
    }
    
    
    
    
    //登陆经纪人端
    _loginBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    _loginBtn.bounds = makeRect(0, 0, SCREEN_Width - 110, 45);
    _loginBtn.centerX = self.view.centerX;
    _loginBtn.top = SafeAreaTop_Height + 360;
    _loginBtn.tag = 100;
    _loginBtn.clipsToBounds = YES;
    _loginBtn.layer.cornerRadius = 6;
    [_loginBtn setBackgroundImage:[UIImage imageNamed:@"changeBtn"]  forState:UIControlStateNormal];
    [_loginBtn setTitle:@"确定" forState:UIControlStateNormal];
    [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_loginBtn];
    
    
    
}


//这里只对长度做检查
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string length] == 0){
        return YES;
    }
    
    if (textField.tag == 50 && range.location < 11){
        return YES;
    }
    
    if(textField.tag == 51 && range.location < 6){
        return YES;
    }
    
    else{
        return NO;
    }
}

//发送短信验证码
-(void)sendSMS{
    UITextField *mTextF = [self.view viewWithTag:50];
    NSDictionary *header = @{@"APP-Phone":mTextF.text};
           
    cout(header);
    [SSAFRequest RequestNetWorking:SSRequestGet parameters:@{} method:URLSMSLogin requestHeader:header result:^(id object, NSError *error, NSURLSessionDataTask *task) {
            
           if(error){
               [self showTime:error.domain];
           }else{
               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);
               
               if([dict[@"code"] integerValue] != 0){
                   [self showTime:dict[@"msg"]];
               }
               else{
                   [self showTime:@"短信发送成功"];
               }
           }
       }];
}


//登陆100  选择区号20
-(void)buttonPressed:(UIButton *)sender{
  
    UITextField *mTextF1 = [self.view viewWithTag:50];
    UITextField *mTextF2 = [self.view viewWithTag:51];


    if([mTextF1.text length] == 0){
        [self showTime:@"请输入手机号"];
        return;
    }
    if([NSString shoujihao:mTextF1.text] == NO){
        [self showTime:@"请输入合法手机号"];
        return;
    }
    if([mTextF2.text length] == 0){
        [self showTime:@"请输入验证码"];
        return;
    }

    [self loginNetWorking:sender];
}


-(void)loginNetWorking:(UIButton *)sender{
    
    UITextField *mTextF1 = [self.view viewWithTag:50];
    UITextField *mTextF2 = [self.view viewWithTag:51];
    
    NSDictionary *dic = @{@"phone":mTextF1.text,
                          @"code":mTextF2.text};

    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestGetHeader parameters:dic method:URLGetWxBindPhone requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [sender closeActivityByBtn:@"确定"];
           if(error){
               [self showTime:error.domain];
           }else{
               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);
               
               if([dict[@"code"] integerValue] != 0){
                   [self showTime:dict[@"msg"]];
               }
               else{
                   
                   [self showTime:@"绑定成功"];
                   [self performSelector:@selector(jump) afterDelay:1];
                   
                  
               }
           }
       }];
}


-(void)jump{
    UITextField *mTextF1 = [self.view viewWithTag:50];
    [SSRootAccount setUserPhone:mTextF1.text];
    [self sendNotifCation:NotiMineChange];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
