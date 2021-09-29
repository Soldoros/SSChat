//
//  PBPayOverController.m
//  LiangCang
//
//  Created by soldoros on 2020/3/21.
//  Copyright © 2020 soldoros. All rights reserved.
//


//支付结果界面
#import "PBPayOverController.h"

@interface PBPayOverController ()

@property(nonatomic,strong)UIButton *mButton1;
@property(nonatomic,strong)UIButton *mButton2;
@property(nonatomic,strong)UIButton *mButton;

@property(nonatomic,strong)UILabel *mLabel1;

@end

@implementation PBPayOverController

-(instancetype)init{
    if(self = [super init]){
        _dataDic = @{};
        _type = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"购买成功"];
    __weak typeof(self)wself = self;
    
    
    UIImageView *mImgView  = [UIImageView new];
    [self.view addSubview:mImgView];
    mImgView.bounds = makeRect(0, 0, SCREEN_Width - 50, (SCREEN_Width - 50) * 235/325);
    mImgView.image = [UIImage imageNamed:@"ChangeSuccess"];
    mImgView.centerX = SCREEN_Width * 0.5;
    mImgView.top= SafeAreaTop_Height + 50;
    
    _mLabel1 = [UILabel new];
    [mImgView addSubview:_mLabel1];
    _mLabel1.textColor = [UIColor blackColor];
    _mLabel1.font = makeFont(12);
    _mLabel1.text = @"您已成功购买 去兑换球鞋吧";
    [_mLabel1 sizeToFit];
    _mLabel1.centerX = mImgView.width * 0.5;
    _mLabel1.bottom = mImgView.height - 60;
    
    
    //合成
    _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton.bounds = makeRect(0, 0, 236, 50);
    _mButton.centerX = SCREEN_Width * 0.5;
    _mButton.top = mImgView.bottom + 40;
    _mButton.layer.cornerRadius = 4;
    _mButton.tag = 10;
    _mButton.backgroundColor = makeColorHex(@"#333333");
    [_mButton setBackgroundImage:[UIImage imageNamed:@"changeBtn"] forState:UIControlStateNormal];
    [_mButton setTitle:@"去合成" forState:UIControlStateNormal];
    [_mButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_mButton];
    [_mButton setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        
        NSString *title = ((UIButton *)sender).titleLabel.text;
        if([title isEqual:@"返回首页"]){
            wself.tabBarController.selectedIndex = 0;
            [wself.navigationController popToRootViewControllerAnimated:YES];
        }
        if([title isEqual:@"去合成"]){
            
        }
        if([title isEqual:@"前往游戏"]){
            wself.tabBarController.selectedIndex = 2;
            [wself.navigationController popToRootViewControllerAnimated:YES];
        }
    }];
    
    
    //拍卖
    _mButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton1.bounds = makeRect(0, 0, 100, 100);
    _mButton1.right = SCREEN_Width * 0.5 - 30;
    _mButton1.bottom = SCREEN_Height - SafeAreaBottom_Height - 100;
    [_mButton1 setImage:[UIImage imageNamed:@"change1"] forState:UIControlStateNormal];
    [self.view addSubview:_mButton1];
    [_mButton1 setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [wself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    
    //商城
    _mButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton2.bounds = makeRect(0, 0, 100, 100);
    _mButton2.left = SCREEN_Width * 0.5 + 30;
    _mButton2.bottom = SCREEN_Height - SafeAreaBottom_Height - 100;
    [_mButton2 setImage:[UIImage imageNamed:@"change2"] forState:UIControlStateNormal];
    [self.view addSubview:_mButton2];
    [_mButton2 setBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        wself.navigationController.tabBarController.selectedIndex = 1;
        [wself.navigationController popToRootViewControllerAnimated:YES];
    }];
    
    //商品购买成功 去订单
    if(_type == 0){
        _mLabel1.text = @"支付成功";
        [_mLabel1 sizeToFit];
        _mLabel1.centerX = mImgView.width * 0.5;
        _mLabel1.bottom = mImgView.height - 60;
        
        [_mButton setTitle:@"查看订单" forState:UIControlStateNormal];
    }
    
    //碎片兑换成功 去合成
    if(_type == 1){
        _mLabel1.text = makeString(_dataDic[@"fragmentName"], @"兑换成功");
        [_mLabel1 sizeToFit];
        _mLabel1.centerX = mImgView.width * 0.5;
        _mLabel1.bottom = mImgView.height - 60;
        
        [_mButton setTitle:@"去合成" forState:UIControlStateNormal];
    }
    //成功购买福袋
    if(_type == 2){
        _mLabel1.text = @"您已付款成功";
        [_mLabel1 sizeToFit];
        _mLabel1.centerX = mImgView.width * 0.5;
        _mLabel1.bottom = mImgView.height - 60;
        [_mButton setTitle:@"返回首页" forState:UIControlStateNormal];
    }
   
    //道具购买成功 去游戏
    if(_type == 3){
        _mLabel1.text = @"道具购买成功";
        [_mLabel1 sizeToFit];
        _mLabel1.centerX = mImgView.width * 0.5;
        _mLabel1.bottom = mImgView.height - 60;
            
        [_mButton setTitle:@"前往游戏" forState:UIControlStateNormal];
    }
    
    
    
}

@end
