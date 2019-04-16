//
//  SSChoiceView.m
//  hxsc
//
//  Created by soldoros on 2017/7/25.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "SSChoiceView.h"

@implementation SSChoiceView

-(instancetype)initWith:(NSString *)title message:(NSString *)message choiceBlock:(SSChoiceBlock)choiceBlock{
    if(self = [super init]){
        self.bounds = makeRect(0, 0, SCREEN_Width-30, (SCREEN_Width-30)*0.5);
        self.centerX = SCREEN_Width*0.5;
        self.centerY = SCREEN_Height*0.5;
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 6;
        
        _choiceBlock = choiceBlock;
        
        _title = title;
        _messsage = message;
        _DefaultColor = makeColorHex(@"#e4e4e4");
        _selecedColor = TitleColor2;
        _cancelBtn = @"取消";
        _selecedBtn = @"确定";
        
        if(_title==nil){
            _title = @"友情提示";
        }
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, self.width-60, self.height*0.25);
        _mTitleLab.top = 0;
        _mTitleLab.centerX = self.width*0.5;
        _mTitleLab.font = makeFont(18);
        _mTitleLab.textAlignment = NSTextAlignmentCenter;
        _mTitleLab.text = _title;
        [self addSubview:_mTitleLab];
        
        UIView *line = [[UIView alloc]init];
        line.bounds = makeRect(0, 0, self.width-60, 0.5);
        line.centerX = self.width*0.5;
        line.top = _mTitleLab.bottom;
        line.backgroundColor = CellLineColor;
        [self addSubview:line];
        
        
        CGFloat height = self.height *0.75 *0.5;
        
        _mMsgLab = [UILabel new];
        _mMsgLab.bounds = makeRect(0, 0, self.width-60, height);
        _mMsgLab.top = line.bottom;
        _mMsgLab.centerX = self.width*0.5;
        _mMsgLab.font = makeFont(14);
        _mMsgLab.numberOfLines = 2;
        _mMsgLab.textAlignment = NSTextAlignmentCenter;
        _mMsgLab.text = _messsage;
        [self addSubview:_mMsgLab];

        
        
        
        CGFloat width = 110;
        CGFloat space = (self.width-2*width)/3;
        
        
        _mLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mLeftBtn.bounds = makeRect(0, 0, width, 40);
        _mLeftBtn.left = space;
        _mLeftBtn.centerY = self.height-height*0.5;
        _mLeftBtn.backgroundColor = _DefaultColor;
        [_mLeftBtn setTitle:_cancelBtn forState:UIControlStateNormal];
        [_mLeftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_mLeftBtn];
        _mLeftBtn.tag = 10;
        _mLeftBtn.clipsToBounds = YES;
        _mLeftBtn.layer.cornerRadius = 4;
        _mLeftBtn.titleLabel.font = makeFont(15);
        [_mLeftBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        _mRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mRightBtn.bounds = makeRect(0, 0, width, 40);
        _mRightBtn.left = _mLeftBtn.right+space;
        _mRightBtn.centerY = self.height-height*0.5;
        _mRightBtn.backgroundColor = _selecedColor;
        [_mRightBtn setTitle:_selecedBtn forState:UIControlStateNormal];
        [_mRightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:_mRightBtn];
        _mRightBtn.tag = 11;
        _mRightBtn.clipsToBounds = YES;
        _mRightBtn.layer.cornerRadius = 4;
        _mRightBtn.titleLabel.font = makeFont(15);
        [_mRightBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

-(void)setTitle:(NSString *)title{
    _title = title;
    _mTitleLab.text = _title;
}

-(void)setCancelBtn:(NSString *)cancelBtn{
    _cancelBtn = cancelBtn;
    [_mLeftBtn setTitle:_cancelBtn forState:UIControlStateNormal];
}

-(void)setSelecedBtn:(NSString *)selecedBtn{
    _selecedBtn = selecedBtn;
    [_mRightBtn setTitle:_selecedBtn forState:UIControlStateNormal];
}




//取消10  确认11
-(void)buttonPressed:(UIButton *)sender{
    if(!_choiceBlock){
        _choiceBlock(sender.tag);
    }
}








@end
