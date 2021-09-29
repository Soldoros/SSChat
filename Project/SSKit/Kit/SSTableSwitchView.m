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
    CGFloat btnWidth,btnHeight;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.buttonArr = @[];
        self.btnFont = makeFont(16);
        self.btnDefaultColor = [UIColor grayColor];
        self.btnSelectedColor = makeColorRgb(208, 167, 108);
        self.lineColor = makeColorRgb(208, 167, 108);
        btnWidth = self.width/3;
        btnHeight = self.height;
        self.buttons = [NSMutableArray new];
        _autoWidth = NO;
        
        _mBottomLine = [UIView new];
        _mBottomLine.bounds = makeRect(0, 0, self.width, 1);
        _mBottomLine.bottom = self.height;
        _mBottomLine.left = 0;
        _mBottomLine.backgroundColor = makeColorHex(@"F0F0F0");
        [self addSubview:_mBottomLine];
        
        _line = [UIView new];
        _line.backgroundColor = _lineColor;
        [self addSubview:_line];
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
    
    if(_buttonArr.count>0)return;
    _buttonArr = buttonArr;
    
//    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    btnWidth = self.width/_buttonArr.count;
    
    CGFloat wd = 0;
    CGFloat lef = 0;
    for(int i=0;i<_buttonArr.count;++i){
        button[i] = [self setButton:i left:lef];
        if(i==0){
            button[i].selected = YES;
            _currentBtn = button[i];
            _currentBtn.titleLabel.font = _btnFont;
        }
        [_buttons addObject:button[i]];
        
        lef = button[i].right;
        wd = button[i].right;
    }
    
    if(_autoWidth == YES){
        self.width = wd+15;
    }
    
    
    if(_currentBtn){
        
        CGRect rec = [NSString getRectWith:_currentBtn.titleLabel.text width:200 font:_btnFont spacing:0 Row:0];
        CGFloat btnW = rec.size.width;
        
        _line.bounds = makeRect(0, 0, btnW, 2);
        _line.centerX = _currentBtn.centerX;
        _line.bottom = btnHeight;
    }
}

-(UIButton *)setButton:(NSInteger)index left:(CGFloat)left{
    
    CGRect rec = [NSString getRectWith:_buttonArr[index] width:200 font:_btnFont spacing:0 Row:0];
    CGFloat btnW = rec.size.width;
    CGFloat lf = left+12;
    if(_autoWidth == NO){
        btnW = btnWidth;
        lf = left;
    }
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = makeRect(lf, 0, btnW , btnHeight);
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

-(void)setBtnDefaultColor:(UIColor *)btnDefaultColor{
    _btnDefaultColor = btnDefaultColor;
    for(UIButton *btn in self.buttons){
        [btn setTitleColor:btnDefaultColor forState:UIControlStateNormal];
    }
}
      
-(void)setBtnSelectedColor:(UIColor *)btnSelectedColor{
    _btnSelectedColor = btnSelectedColor;
    for(UIButton *btn in self.buttons){
        [btn setTitleColor:_btnSelectedColor forState:UIControlStateSelected];
    }
}
         

//按钮点击回调10+
-(void)buttonPressed:(UIButton *)sender{
    
    if(sender==_currentBtn)return;
    else{
        [self setIndexTableScrollSwitchView:sender];
        
    }
}


-(void)setIndexTableScrollSwitchView:(UIButton *)sender{
    
    if(sender==_currentBtn)return;
    
    else{
        
        if(self.handle){
            self.handle(nil, sender);
        }
        
        __block __weak SSTableSwitchView *weakSelf = self;
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.currentBtn.selected = NO;
            weakSelf.currentBtn.titleLabel.font = weakSelf.btnFont;
            
            weakSelf.currentBtn = sender;
            weakSelf.currentBtn.selected = YES;
            weakSelf.currentBtn.titleLabel.font = weakSelf.btnFont;
            
            
            NSString *string = weakSelf.currentBtn.titleLabel.text;
            CGRect rect = [NSObject getRectWith:string width:200 font:weakSelf.currentBtn.titleLabel.font spacing:0 Row:0];
            weakSelf.line.width = rect.size.width;
            weakSelf.line.centerX = weakSelf.currentBtn.centerX;
            
            
        } completion:^(BOOL finished) {
            
            
        }];
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
        
        itemWidth = self.width/6.5;
        
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
        [_mScrollView addSubview:_mSitchView];
        _mSitchView.mBottomLine.hidden = YES;
        
        __weak typeof(self) wself = self;
        _mSitchView.handle = ^(NSDictionary *dic, UIButton *sender) {
            [wself SSTableSwitchViewBtnClick:sender];
        };
        
        
        //        _mBottomLine = [UIView new];
        //        _mBottomLine.bounds = makeRect(0, 0, self.width, 0.5);
        //        _mBottomLine.top = self.height;
        //        _mBottomLine.left = 0;
        //        _mBottomLine.backgroundColor = makeColorHex(@"E6E6E6");
        //        [self addSubview:_mBottomLine];
        
    }
    return self;
}

-(void)setArray:(NSArray *)array{
    _array = array;
    
//    CGFloat width  = array.count *  itemWidth;
//    if(width<self.width)width = self.width;
    
    
    
    NSMutableArray *arr = [NSMutableArray new];
    for(int i=0;i<array.count;++i){
        [arr addObject:array[i][@"categoryName"]];
    }
    
    _mSitchView.buttonArr = arr;
    
    _mScrollView.contentSize=CGSizeMake(_mSitchView.width,_mScrollView.height);
    
}


-(void)SSTableSwitchViewBtnClick:(UIButton *)sender{
    
    NSInteger index = sender.tag-11;
    if(index<0)index=0;
    
    CGPoint point = CGPointMake(index*itemWidth, 0);
    if(point.x>_mScrollView.contentSize.width-_mScrollView.width){
        point.x = _mScrollView.contentSize.width-_mScrollView.width;
    }
    [_mScrollView setContentOffset:point animated:YES];
    
    
    __weak typeof(self) wself = self;
    if(wself.handle){
        wself.handle(_array[sender.tag-10], sender);
    }
}


-(void)setIndexTableScrollSwitchView:(UIButton *)sender{
    [_mSitchView setIndexTableScrollSwitchView:sender];
    [self SSTableSwitchViewBtnClick:sender];
}

@end




