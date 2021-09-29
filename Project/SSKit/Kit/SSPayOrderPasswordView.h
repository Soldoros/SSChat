//
//  SSPayOrderPasswordView.h
//  htcm
//
//  Created by soldoros on 2018/12/27.
//  Copyright © 2018 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSInputTextField.h"

/**
 支付密码弹框
 */
#define SSPayOrderPasswordViewH   45
#define SSPayOrderPasswordViewHeight   245

@protocol SSPayOrderPasswordViewDelegate <NSObject>

-(void)SSPayOrderPasswordViewInputOver:(NSString *)mima;
-(void)SSPayOrderPasswordViewBtnClick:(UIButton *)sender;
-(void)SSPayOrderPasswordViewEndEdit;

@end

@interface SSPayOrderPasswordView : UIView<SSInputTextFieldDelegate>

@property(nonatomic,assign)id<SSPayOrderPasswordViewDelegate>delegate;

//提示标题
@property(nonatomic,strong)UILabel *titleLab;

//分割线
@property(nonatomic,strong)UIView *line;

//价格
@property(nonatomic,strong)UILabel *mPayTitle;
@property(nonatomic,strong)UILabel *mPriceLab;

//忘记密码 返回
@property(nonatomic,strong)UIButton *button;
@property(nonatomic,strong)UIButton *backButton;

//输入验证码
@property(nonatomic,strong)SSInputTextField *inputText;


//支付数据
@property(nonatomic,strong)NSString *priceString;

@end


