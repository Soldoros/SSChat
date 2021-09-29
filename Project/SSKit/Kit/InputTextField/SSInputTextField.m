//
//  SSInputTextField.m
//  haixian
//
//  Created by soldoros on 2017/8/23.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSInputTextField.h"

@interface SSInputTextField ()<SSReTextFieldDelegate,UITextFieldDelegate>{
    SSReTextField *textF[100];
    UIView *textLine[100];
    UIView *backView[100];
    NSInteger start;
    UIButton *button;
}

@end

@implementation SSInputTextField

//禁止复制粘帖
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if(menuController){
        menuController.menuVisible = NO;
    }
    return NO;
}


-(instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        _number = number;
        start = 0;
        _showStyle = 1;
        _isEditInput = YES;
        _isSecurity = NO;
        
        for(int i=0;i<_number;++i){
            
            CGFloat with = self.width/_number;
            
            backView[i] = [UIView new];
            backView[i].frame = makeRect(i*with, 0, self.width/_number, self.height);
            if(i>0)backView[i].left = i*(with-0.5);
            backView[i].backgroundColor = [UIColor whiteColor];
            [self addSubview:backView[i]];
            
            
            textF[i] = [[SSReTextField alloc]init];
            textF[i].frame = backView[i].bounds;
            textF[i].textAlignment = NSTextAlignmentCenter;
            textF[i].tintColor = makeColorHex(@"#999999");
            textF[i].textColor = [UIColor blackColor];
            textF[i].font = makeFont(25);
            textF[i].delegate = self;
            textF[i].backgroundColor = [UIColor clearColor];
            textF[i].keyboardType = UIKeyboardTypeNumberPad;

            [backView[i] addSubview:textF[i]];
            textF[i].tag = 10+i;
            textF[i].ssdelegate = self;
            textF[i].keyboardType = UIKeyboardTypeNumberPad;
            [textF[i] addTarget:self action:@selector(textBtnClick:) forControlEvents:UIControlEventEditingChanged];
            
            
            textLine[i] = [UIView new];
            textLine[i].width = with-20;
            textLine[i].height = 2;
            textLine[i].bottom = backView[i].bottom;
            textLine[i].centerX = backView[i].width*0.5;
            [backView[i] addSubview:textLine[i]];
            textLine[i].backgroundColor = [UIColor blackColor];
            
        }
        
        
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = self.bounds;
        button.backgroundColor = [UIColor clearColor];
        [self addSubview:button];
        [button addTarget:self action:@selector(buttonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

-(void)setIsSecurity:(BOOL)isSecurity{
    _isSecurity = isSecurity;
    for(int i=0;i<_number;++i){
        textF[i].secureTextEntry = _isSecurity;
    }
}

//不同的输入框风格，这里只有两种 验证码和密码
-(void)setShowStyle:(NSInteger)showStyle{
    _showStyle = showStyle;
    if(_showStyle == 1){
        for(int i=0;i<_number;++i){
            textF[i].layer.borderColor = [UIColor lightGrayColor].CGColor;
            textF[i].layer.borderWidth = 0;
            textLine[i].hidden = NO;
        }
    }
    if(_showStyle==2){
        for(int i=0;i<_number;++i){
            textF[i].layer.borderColor = [UIColor lightGrayColor].CGColor;
            textF[i].layer.borderWidth = 0.5;
            textLine[i].hidden = YES;
            backView[i].backgroundColor = BackGroundColor;
        }
    }
}

-(void)setIsEditInput:(BOOL)isEditInput{
    _isEditInput = isEditInput;
    if(_isEditInput){
        [textF[0] becomeFirstResponder];
    }
}

//点击操作
-(void)buttonPressed{
    
    if(start<_number-1){
        [textF[start] becomeFirstResponder];
    }
    
    else if (start==_number-1){
        [textF[start] becomeFirstResponder];
        if(textF[start].text.length==0){
            textF[start].tintColor = makeColorHex(@"#999999");
        }else{
            textF[start].tintColor = [UIColor clearColor];
        }
    }
}


//输入操作
-(void)textBtnClick:(UITextField *)textField{
    if(start<_number-1){
        start=start+1;
        [textF[start] becomeFirstResponder];
    }
    else if(start==_number-1){
        if(textF[_number-1].text.length==1){
            start = _number-1;
            [textF[_number-1] endEditing:YES];
        }else{
            return;
        }
    }
    [self returnTextFieldString];
}

//删除操作
-(void)TextKeyBordDelete{
    
    if(start==0){
        start=0;
    }
    else if (start<_number-1){
        start = start-1;
        textF[start].text = @"";
        [textF[start] becomeFirstResponder];
    }
    else if (start==_number-1){
        if([textF[_number-1].tintColor isEqual:[UIColor clearColor]]){
            textF[_number-1].text = @"";
            start = _number-1;
            [textF[_number-1] becomeFirstResponder];
            textF[_number-1].tintColor = makeColorHex(@"#999999");
        }else{
            start = start-1;
            textF[start].text = @"";
            [textF[start] becomeFirstResponder];
        }
    }
    [self returnTextFieldString];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}

//获取号码
-(NSString *)getTextCode{
    NSString *string = @"";
    for(int i=0;i<_number;++i){
        string = makeString(string, textF[i].text);
    }
    cout(string);
    return string;
}


//回调
-(void)returnTextFieldString{
    NSString *string = [self getTextCode];
    if(_delegate && [_delegate respondsToSelector:@selector(SSInputTextFieldString:)]){
        [_delegate SSInputTextFieldString:string];
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField{
    cout(@(textField.tag));
}


//清空
-(void)cleanAllTextF{
    for(int i=0;i<_number;++i){
        textF[i].text = @"";
    }
    start = 0;
    [textF[0] becomeFirstResponder];
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    NSString *string = [self getTextCode];
    if(_delegate && [_delegate respondsToSelector:@selector(SSInputTextFieldEndEdit:)]){
        [_delegate SSInputTextFieldEndEdit:string];
    }
}


@end
