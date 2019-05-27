//
//  MineQrCodeController.m
//  SSChat
//
//  Created by soldoros on 2019/4/15.
//  Copyright © 2019 soldoros. All rights reserved.
//

//我的二维码
#import "MineQrCodeController.h"

@interface MineQrCodeController ()

//头像
@property(nonatomic,strong)UIImageView *mHeaderImgView;
//编号
@property(nonatomic,strong)UILabel *mCodeLab;
//条形码按钮
@property(nonatomic,strong)UIImageView *mCodeImgView;

//友情提示
@property(nonatomic,strong)UILabel *mMessageLab;

@end

@implementation MineQrCodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"我的二维码"];
    
    _mHeaderImgView = [UIImageView new];
    _mHeaderImgView.bounds = makeRect(0, 0, 60, 60);
    _mHeaderImgView.centerX = SCREEN_Width * 0.5;
    _mHeaderImgView.top = SafeAreaTop_Height + 50;
    [self.view addSubview:_mHeaderImgView];
    _mHeaderImgView.image = makeImage(@"user_avatar_gray");
    
    
    _mCodeLab = [UILabel new];
    _mCodeLab.bounds = makeRect(0, 0, SCREEN_Width, 20);
    [self.view addSubview:_mCodeLab];
    _mCodeLab.textAlignment = NSTextAlignmentCenter;
    _mCodeLab.font = makeBlodFont(22);
    _mCodeLab.textColor = [UIColor blackColor];
    _mCodeLab.text = _userName;
    [_mCodeLab sizeToFit];
    _mCodeLab.top = _mHeaderImgView.bottom + 15;
    _mCodeLab.centerX = SCREEN_Width * 0.5;
    
    
    
    CGFloat size = SCREEN_Width * 0.7;
    UIImage *image = [UIImage qrCodeImageWithContent:_userName codeImageSize:size logo:nil logoFrame:CGRectZero red:0 green:0 blue:0];
    
    _mCodeImgView = [UIImageView new];
    _mCodeImgView.bounds = makeRect(0, 0, size, size);
    _mCodeImgView.centerX = SCREEN_Width * 0.5;
    _mCodeImgView.top =_mCodeLab.bottom + 40;
    [self.view addSubview:_mCodeImgView];
    _mCodeImgView.image = image;
    
    
    _mMessageLab = [UILabel new];
    _mMessageLab.bounds = makeRect(0, 0, size, 20);
    [self.view addSubview:_mMessageLab];
    _mMessageLab.textAlignment = NSTextAlignmentLeft;
    _mMessageLab.font = makeFont(12);
    _mMessageLab.textColor = [UIColor grayColor];
    _mMessageLab.text = @"Hello 扫描上面的二维码图案加我";
    [_mMessageLab sizeToFit];
    _mMessageLab.top = _mCodeImgView.bottom + 20;
    _mMessageLab.centerX = SCREEN_Width * 0.5;
    

    
}

@end
