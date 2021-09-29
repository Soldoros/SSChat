//
//  SSPayOrderPasswordView.m
//  htcm
//
//  Created by soldoros on 2018/12/27.
//  Copyright © 2018 soldoros. All rights reserved.
//

#import "SSPayOrderPasswordView.h"

@implementation SSPayOrderPasswordView


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
        
        
        
        
        _titleLab = [UILabel new];
        _titleLab.bounds = makeRect(0, 0,self.width-80, 58);
        _titleLab.font = makeFont(18);
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLab];
        _titleLab.text = @"请输入卡密码";
        [_titleLab sizeToFit];
        _titleLab.centerX = self.width * 0.5;
        _titleLab.top = 20;
        
        
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.bounds = makeRect(0, 0, 20, 20);
        _backButton.left = 15;
        _backButton.centerY = _titleLab.centerY;
        [self addSubview:_backButton];
        _backButton.tag = 11;
        [_backButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_backButton setBackgroundImage:[UIImage imageNamed:@"shouyeguanbi"] forState:UIControlStateNormal];
        
        
        _line = [UIView new];
        _line.bounds = makeRect(0, 0, self.width, 0.5);
        _line.left = 0;
        _line.top = 58;
        _line.backgroundColor = CellLineColor;
        [self addSubview:_line];
        
        
        
        _mPayTitle = [UILabel new];
        _mPayTitle.bounds = makeRect(0, 0,self.width-80, 58);
        _mPayTitle.font = makeFont(16);
        _mPayTitle.textColor = [UIColor blackColor];
        _mPayTitle.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mPayTitle];
        _mPayTitle.text = @"支付金额";
        [_mPayTitle sizeToFit];
        _mPayTitle.centerX = self.width * 0.5;
        _mPayTitle.top = _line.bottom + 20;
        
        
        _mPriceLab = [UILabel new];
        _mPriceLab.bounds = makeRect(0, 0,self.width-80, 58);
        _mPriceLab.font = makeFont(24);
        _mPriceLab.textColor = [UIColor blackColor];
        _mPriceLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_mPriceLab];
        
        
        _inputText = [[SSInputTextField alloc]initWithFrame:makeRect(20, SSPayOrderPasswordViewHeight-95, self.width-40, 45) number:6];
        _inputText.delegate = self;
        _inputText.showStyle = 2;
        _inputText.isEditInput = YES;
        _inputText.isSecurity = YES;
        _inputText.centerX = self.width*0.5;
        [self addSubview:_inputText];
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.bounds = makeRect(0, 0, 100, 35);
        _button.centerX = self.width*0.5;
        _button.top = _inputText.bottom + 5;
        [_button setTitleColor:TitleColor forState:UIControlStateNormal];
        _button.titleLabel.font = makeFont(14);
        [_button setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [self addSubview:_button];
        _button.tag = 10;
        [_button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        

        
    }
    return self;
}


//忘记密码10  返回11
-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSPayOrderPasswordViewBtnClick:)]){
        [_delegate SSPayOrderPasswordViewBtnClick:sender];
    }
}


-(void)setPriceString:(NSString *)priceString{
    _priceString = priceString;
    
    _mPriceLab.text = makeString(@"￥", _priceString);
    [_mPriceLab sizeToFit];
    _mPriceLab.centerX = self.width * 0.5;
    _mPriceLab.top = _mPayTitle.bottom + 10;
}


-(void)SSInputTextFieldString:(NSString *)string{
    NSInteger length = string.length;
    if(length>=6){
        
        if(_delegate && [_delegate respondsToSelector:@selector(SSPayOrderPasswordViewInputOver:)]){
            [_delegate SSPayOrderPasswordViewInputOver:[string substringToIndex:6]];
        }
        
    }
}

-(void)SSInputTextFieldEndEdit:(NSString *)string{
    if(_delegate && [_delegate respondsToSelector:@selector(SSPayOrderPasswordViewEndEdit)]){
        [_delegate SSPayOrderPasswordViewEndEdit];
    }
}



@end
