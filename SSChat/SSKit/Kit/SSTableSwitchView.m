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
        self.btnFont = makeFont(16);
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
    
    //[self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    width = self.width/_buttonArr.count;
    
    for(int i=0;i<_buttonArr.count;++i){
        button[i] = [self setButton:i];
        if(i==0)_currentBtn = button[i];
    }
    
    _mBottomLine = [UIView new];
    _mBottomLine.bounds = makeRect(0, 0, self.width, 1);
    _mBottomLine.bottom = self.height;
    _mBottomLine.left = 0;
    _mBottomLine.backgroundColor = makeColorHex(@"F0F0F0");
    [self addSubview:_mBottomLine];
    
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









//我的收藏头部视图 体检套餐 文章资讯 常见疾病
@implementation SSTableScrollSwitchView{
    CGFloat itemWidth;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        itemWidth = self.width/3.6;
        
        _mScrollView = [UIScrollView new];
        _mScrollView.frame = self.bounds;
        _mScrollView.backgroundColor = [UIColor whiteColor];
        _mScrollView.pagingEnabled = NO;
        _mScrollView.delegate = self;
        [self addSubview:_mScrollView];
        _mScrollView.maximumZoomScale = 2.0;
        _mScrollView.minimumZoomScale = 0.5;
        _mScrollView.canCancelContentTouches = NO;
        _mScrollView.delaysContentTouches = YES;
        _mScrollView.showsVerticalScrollIndicator = FALSE;
        _mScrollView.showsHorizontalScrollIndicator = FALSE;
        
        
        _mSitchView = [[SSTableSwitchView alloc]initWithFrame:_mScrollView.bounds];
        _mSitchView.delegate = self;
        [_mScrollView addSubview:_mSitchView];
        
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
    CGFloat width  = array.count *  itemWidth;
    _mScrollView.contentSize=CGSizeMake(width,_mScrollView.height);
    
    _mSitchView.frame = makeRect(0, 0, _mScrollView.contentSize.width, _mScrollView.contentSize.height);
    
    _mSitchView.buttonArr = array;
    
}


-(void)SSTableSwitchViewBtnClick:(UIButton *)sender{
    
    NSInteger index = sender.tag-11;
    if(index<0)index=0;
    
    [_mScrollView setContentOffset:CGPointMake(index*itemWidth, 0) animated:YES];
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSTableScrollSwitchViewBtnClick:)]){
        [_delegate SSTableScrollSwitchViewBtnClick:sender];
    }
    
}


@end




