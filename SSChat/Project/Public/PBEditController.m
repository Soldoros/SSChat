//
//  PBEditController.m
//  SSChat
//
//  Created by soldoros on 2019/6/5.
//  Copyright © 2019 soldoros. All rights reserved.
//

//编辑回调
#import "PBEditController.h"

@interface PBEditController ()

@property(nonatomic,strong)UITextField *mTextField;
@property(nonatomic,strong)UITextView *mTextView;

@property(nonatomic,strong)UIButton *mButton;

@end

@implementation PBEditController

- (instancetype)initWithType:(PBEditType)type user:(NIMUser *)user
{
    self = [super init];
    if (self) {
        _type = type;
        _user = user;
    }
    return self;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = BackGroundColor;
    self.navLine.hidden = YES;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 0)];
    
    _mTextField = [UITextField new];
    _mTextField.frame = makeRect(0, SafeAreaTop_Height + 20, SCREEN_Width, 55);
    _mTextField.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_mTextField];
    _mTextField.textAlignment = NSTextAlignmentLeft;
    _mTextField.font = [UIFont systemFontOfSize:16];
    _mTextField.textColor = [UIColor blackColor];
    _mTextField.leftViewMode = UITextFieldViewModeAlways;
    _mTextField.leftView = view;
    _mTextField.rightView = view;
    
    
    _mButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.view addSubview:_mButton];
    _mButton.bounds = makeRect(0, 0, SCREEN_Width * 0.6, 40);
    _mButton.centerX = SCREEN_Width * 0.5;
    _mButton.top = _mTextField.bottom + 60;
    _mButton.backgroundColor = TitleColor;
    _mButton.clipsToBounds = YES;
    _mButton.layer.cornerRadius = 3;
    [_mButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_mButton setTitle:@"设置" forState:UIControlStateNormal];
    [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self setAllMessageWithType];
}

-(void)setAllMessageWithType{
    
    switch (_type) {
        case PBEditTypeNikckname:
            [self setNavgaionTitle:@"修改昵称"];
            _mTextField.placeholder = @"请输入昵称";
            break;
        case PBEditTypeNote:
            [self setNavgaionTitle:@"设置备注"];
            _mTextField.placeholder = @"请输入备注";
            break;
        case PBEditTypeSignature:
            [self setNavgaionTitle:@"设置签名"];
            _mTextField.placeholder = @"请输入签名";
            break;
        case PBEditTypeMobile:
            [self setNavgaionTitle:@"修改手机号"];
            _mTextField.placeholder = @"请输入手机号";
            break;
        case PBEditTypeEmail:
            [self setNavgaionTitle:@"修改邮箱"];
            _mTextField.placeholder = @"请输入邮箱";
            break;
        default:
            [self setNavgaionTitle:@"编辑"];
            _mTextField.placeholder = @"请输入...";
            break;
    }
}


-(void)buttonPressed:(UIButton *)sender{
    
    //修改备注
    if(_type == PBEditTypeNote){
        
        _user.alias = _mTextField.text;
        [sender addActivityOnBtn];
        [[NIMSDK sharedSDK].userManager updateUser:_user completion:^(NSError *error) {
            [sender closeActivityByBtn:@"设置"];
            if (!error) {
                [self showTime:@"备注设置成功"];
                if(self.handle){
                    self.handle(nil,self.mTextField.text,self.type);
                }
                [self performSelector:@selector(jumpToController) withObject:nil afterDelay:1];
               
            }else{
                [self showTime:@"备注设置失败"];
            }
        }];
    }
    
}


-(void)jumpToController{
     [self.navigationController popViewControllerAnimated:YES];
}

@end
