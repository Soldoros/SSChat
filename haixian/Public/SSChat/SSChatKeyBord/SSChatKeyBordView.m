//
//  SSChatKeyBordView.m
//  haixian
//
//  Created by soldoros on 2017/11/14.
//  Copyright © 2017年 soldoros. All rights reserved.



#import "SSChatKeyBordView.h"



//多功能视图 + 表情视图
@implementation SSChatKeyBordView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = SSChatCellColor;
        
        _symbolView = [[SSChatKeyBordSymbolView alloc]initWithFrame:self.bounds];
        _symbolView.delegate = self;
        [self addSubview:_symbolView];

        _functionView = [[SSChatKeyBordFunctionView alloc]initWithFrame:self.bounds];
        _functionView.delegate = self;
        [self addSubview:_functionView];
        
        _mCoverView = [[UIView alloc]initWithFrame:self.bounds];
        _mCoverView.backgroundColor = SSChatCellColor;
        [self addSubview:_mCoverView];
        _mCoverView.hidden = NO;
        
        UIView *topLine = [UIView new];
        topLine.frame = makeRect(0, 0, self.width, 0.5);
        topLine.backgroundColor = CellLineColor;
        [self addSubview:topLine];
        
        _type = KeyBordViewFouctionAdd;
    }
    return self;
}

//表情视图  其他功能视图
-(void)setType:(KeyBordViewFouctionType)type{
    _type = type;
    if(_type == KeyBordViewFouctionSymbol){
        _functionView.hidden = YES;
        _symbolView.hidden = NO;
        _symbolView.top = self.height;
        [UIView animateWithDuration:0.25 animations:^{
            _symbolView.top = 0;
        } completion:nil];
    }else{
        _functionView.hidden = NO;
        _symbolView.hidden = YES;
        _functionView.top = self.height;
        [UIView animateWithDuration:0.25 animations:^{
            _functionView.top = 0;
        } completion:nil];
    }
}


#pragma SSChatKeyBordSymbolViewDelegate 表情切换点击回调100+ 发送200
-(void)SSChatKeyBordSymbolViewBtnClick:(NSInteger)index{
    [self SSChatKeyBordButtonPressed:index];
}

//表情点击回调
-(void)SSChatKeyBordSymbolCellClick:(NSObject *)emojiText{
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordSymbolViewBtnClick:)]){
        [_delegate SSChatKeyBordSymbolViewBtnClick:emojiText];
    }
}

#pragma SSChatKeyBordFunctionDelegate  其他功能按钮点击回调
-(void)SSChatKeyBordFunctionViewBtnClick:(NSInteger)index{
    [self SSChatKeyBordButtonPressed:index];
}

//点击回调 表情点击回调10+ 发送200
-(void)SSChatKeyBordButtonPressed:(NSInteger)index{
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordViewBtnClick:type:)]){
        [_delegate SSChatKeyBordViewBtnClick:index type:_type];
    }
}


@end
