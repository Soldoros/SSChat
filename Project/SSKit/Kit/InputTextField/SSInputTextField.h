//
//  SSInputTextField.h
//  haixian
//
//  Created by soldoros on 2017/8/23.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSReTextField.h"


@protocol SSInputTextFieldDelegate <NSObject>

-(void)SSInputTextFieldString:(NSString *)string;

-(void)SSInputTextFieldEndEdit:(NSString *)string;

@end

@interface SSInputTextField : UIView

@property(nonatomic,assign)id<SSInputTextFieldDelegate>delegate;

-(instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number;

//输入明文还是星号
@property(nonatomic,assign)BOOL isSecurity;

//输入数字的个数
@property(nonatomic,assign)NSInteger number;

//显示方框还是线条  线条1  方框2
@property(nonatomic,assign)NSInteger showStyle;

-(NSString *)getTextCode;


//默认点击第一个输入框
@property(nonatomic,assign)BOOL isEditInput;


//清空所有输入框
-(void)cleanAllTextF;


@end
