//
//  AttributeView.m
//  htcm
//
//  Created by soldoros on 2018/4/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import "AttributeView.h"



//按钮视图的自适应
@implementation AttributeView{
    CGFloat width,height;
    NSMutableArray *btnArr;
    UIButton *currentBtn;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        width = self.width;
        height = self.height;
        btnArr = [NSMutableArray new];
        _normolStr = @"anniu_lijiyuyue";
        _selecetStr = @"jiankangziceBtn";
        _normolColor = TitleColor;
        _selecetColor = [UIColor whiteColor];
        _yuanjiao = YES;
        _buttonHeight = attBtnH;
        _buttonAttLineS = attLineS;
        _buttonAttRowS = attRowS;
        _buttonAttBtnLRS = attBtnLRS;
        _buttonFont = attFont;
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [btnArr removeAllObjects];
    
    
    CGFloat attWidth = self.width;
    //计算布局后的最小宽度
    CGFloat minWidth = 0;
    
    CGFloat lineRight = 0.0f;
    CGFloat lineTop   = 0.0f;
    for(int i=0;i<_array.count;++i){
        
        NSString *title = array[i];
        
        CGRect rect = [NSObject getRectWith:title width:width-attLS-attRS font:makeFont(_buttonFont) spacing:0 Row:0];
        CGFloat btnHeight = _buttonHeight;
        CGFloat btnWidth  = rect.size.width + _buttonAttBtnLRS*2;
        if(btnWidth>attWidth-attLS-attRS){
            btnWidth = attWidth-attLS-attRS;
        }
        CGFloat btnLeft,btnTop;
        if(i==0){
            btnLeft = attLS;
            btnTop  = attTS;
        }else if(lineRight+btnWidth+attRowS>(width-attRS)){
            btnLeft = attLS;
            btnTop  = lineTop + (attBtnH + _buttonAttLineS);
        }else{
            btnLeft = lineRight + _buttonAttRowS;
            btnTop = lineTop;
        }
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = makeRect(btnLeft, btnTop, btnWidth, btnHeight);
        btn.tag = 10+i;
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
        btn.titleLabel.font = makeFont(_buttonFont);
        [btn setTitle:title forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:_normolColor forState:UIControlStateNormal];
        [btn setTitleColor:_selecetColor forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageNamed:_normolStr] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:_selecetStr] forState:UIControlStateSelected];
        btn.layer.borderColor = [UIColor blackColor].CGColor;
        btn.layer.borderWidth = attBtnBoder;
        btn.clipsToBounds = YES;
        btn.selected = NO;
        if(_yuanjiao){
            btn.clipsToBounds = YES;
            btn.layer.cornerRadius = btn.height*0.5;
        }
        
        
        lineRight = btn.right;
        lineTop = btn.top;
        if(btn.right>minWidth){
            minWidth = btn.right;
        }
        [btnArr addObject:btn];
    }
    
    currentBtn = btnArr[0];
    currentBtn.selected = YES;
    currentBtn.layer.borderColor = [UIColor redCGColor];
    
    self.attHeight = lineTop + attBtnH + attBS;
    self.height = self.attHeight;
    self.width = minWidth;
    
}

//选中状态的按钮
-(void)setDefaultAtt:(NSString *)defaultAtt{
    _defaultAtt = defaultAtt;
    
    cout(_array);
    cout(defaultAtt);
    for(int i=0;i<_array.count;++i){
        NSString *str = _array[i];
        if([_defaultAtt isEqualToString:str]){
            currentBtn.selected = NO;
            currentBtn = btnArr[i];
            currentBtn.selected = YES;
            break;
        }
    }
    
}

-(void)buttonPressed:(UIButton *)sender{
    
    currentBtn.selected = NO;
    currentBtn = sender;
    currentBtn.selected = YES;
    
    if(_deleagte && [_deleagte respondsToSelector:@selector(AttributeViewBtnClick:)]){
        [_deleagte AttributeViewBtnClick:sender];
    }
}


@end
