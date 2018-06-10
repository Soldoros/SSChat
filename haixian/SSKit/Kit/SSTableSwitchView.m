//
//  SSTableSwitchView.m
//  htcm
//
//  Created by soldoros on 2018/4/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSTableSwitchView.h"

@implementation SSTableSwitchView{
    UIButton *button[100];
    CGFloat width,height;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArr = @[];
        self.btnFont = makeFont(14);
        self.btnDefaultColor = [UIColor grayColor];
        self.btnSelectedColor = TitleColor;
        self.lineColor = TitleColor;
        width = self.width/3;
        height = self.height;
    }
    return self;
}

//设置线条颜色
-(void)setLineColor:(UIColor *)lineColor{
    _lineColor = lineColor;
    _line.backgroundColor = _lineColor;
}

//设置按钮
-(void)setButtonArr:(NSArray *)buttonArr{
    _buttonArr = buttonArr;
    if(_buttonArr.count<=0)return;
    
    width = self.width/_buttonArr.count;
    
    for(int i=0;i<_buttonArr.count;++i){
        button[i] = [self setButton:i];
        if(i==0)_currentBtn = button[i];
    }
    
    _line = [UIView new];
    _line.backgroundColor = _lineColor;
    _line.bounds = makeRect(0, 0, width*0.5, 2);
    _line.centerX = width * 0.5;
    _line.bottom = height;
    [self addSubview:_line];

}

-(UIButton *)setButton:(NSInteger)index{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = makeRect(index*width, 0, width , height);
    [btn setTitle:_buttonArr[index] forState:UIControlStateNormal];
    [btn setTitleColor:_btnDefaultColor forState:UIControlStateNormal];
    [btn setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
    btn.titleLabel.font = _btnFont;
    btn.selected = NO;
    if(index==0)btn.selected = YES;
    btn.tag = 10+index;
    [self addSubview:btn];
    [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}


//按钮点击回调10+
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender==_currentBtn)return;
    else{
        [UIView animateWithDuration:0.3 animations:^{
            _currentBtn.selected = NO;
            _currentBtn = sender;
            _currentBtn.selected = YES;
            _line.centerX = width*(sender.tag-10) + width*0.5;
            
        } completion:^(BOOL finished) {
    
        }];
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSTableSwitchViewBtnClick:)]){
        [_delegate SSTableSwitchViewBtnClick:sender];
    }
}






@end












