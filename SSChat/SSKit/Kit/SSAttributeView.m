//
//  SSAttributeView.m
//  htcm
//
//  Created by soldoros on 2018/6/13.
//  Copyright © 2018年 soldoros. All rights reserved.
//


//属性选择器
#import "SSAttributeView.h"

@implementation SSAttributeView


//通常把不太频繁变动的量放在初始化方法里面传入
-(instancetype)initWithFrame:(CGRect)frame norBackImg:(NSString *)norBackImg selBackImg:(NSString *)selBackImg normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg btnHeight:(CGFloat)btnHeight{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        _attWidth    = self.frame.size.width;
        _attHeight   = self.frame.size.height;
        _totalHeight = 0.0;
        
        _choiceArray  = [NSMutableArray new];
        _normalButtons = [NSMutableArray new];
        _choiceButtons = [NSMutableArray new];
        
        
        _btnNorBackImg  = norBackImg;
        _btnSelBackImg  = selBackImg;
        
        _btnNormalImg   = normalImg;
        _btnSelectedImg = selectedImg;
        _btnHeight = btnHeight;

        _normalColor    = SSAttNormalColor;
        _selecetColor   = SSAttSelecetColor;
        
        _btnFont          = SSAttBtnFont;
        _btnSpaceTB       = SSAttBtnSpaceTB;
        _btnSpaceLR       = SSAttBtnSpaceLR;
        _btnSpaceInsideLR = SSAttBtnSpaceInsideLR;
        _btnImgWidth      = SSAttBtnImgWidth;

        _btnNorInsets = 0;
        _btnSelInsets = 0;
        
        _key = nil;
      
    }
    return self;
}


-(void)setNormalArray:(NSArray *)normalArray{
    _normalArray = normalArray;
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_normalButtons removeAllObjects];
    
    
    CGFloat btnLeft=0,btnTop=0,btnWidth=0,btnHeight=0;
    CGFloat btnBottom=0,btnRight=0;
    for(int i=0;i<_normalArray.count;++i){
        
        NSString *title;
        if(!_key) title = _normalArray[i];
        else title = _normalArray[i][_key];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = makeRect(btnLeft, btnTop, btnWidth, btnHeight);
        button.tag = 10+i;
        [self addSubview:button];
        button.titleLabel.font = makeFont(_btnFont);
        [button setTitle:title forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [button setTitleColor:_normalColor forState:UIControlStateNormal];
        [button setTitleColor:_selecetColor forState:UIControlStateSelected];
        [self setChoiceButtonSelected:button];
        
        [button.titleLabel sizeToFit];
        button.width  = _btnSpaceInsideLR*2 + button.titleLabel.width + button.imageView.width;
        button.height = _btnHeight;
        
        if(button.width>_attWidth){
            button.width = _attWidth;
        }
        
        btnWidth = button.width;
        btnHeight = button.height;
        
        //背景图拉伸 但是只拉伸矩形区域
        [button setButtonTensileImage:_btnNorBackImg width:_btnNorInsets state:UIControlStateNormal];
        [button setButtonTensileImage:_btnSelBackImg width:_btnNorInsets state:UIControlStateSelected];
        
        //图片以及位移设置
        [button setImage:[UIImage imageNamed:_btnNormalImg] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:_btnSelectedImg] forState:UIControlStateSelected];
        if(_btnNormalImg.length!=0 || _btnSelectedImg.length!=0){
            [button setImageEdgeInsets:UIEdgeInsetsMake(0, -_btnImgWidth, 0, 0)];
            [button setTitleEdgeInsets:UIEdgeInsetsMake(0, _btnImgWidth, 0, 0)];
        }
        
        
        if(i==0){
            btnLeft = 0;
            btnTop  = 0;
            btnRight = button.width;
            btnBottom = button.height;
        }else if(btnRight+_btnSpaceLR+btnWidth>_attWidth){
            btnLeft = 0;
            btnTop  = btnBottom + _btnSpaceTB;
        }else{
            btnLeft = btnRight + _btnSpaceLR;
            btnTop = button.top;
        }
        
        button.top = btnTop;
        button.left = btnLeft;
        btnRight = button.right;
        btnBottom = button.bottom;
        
        
        [_normalButtons addObject:button];
    }
    
    self.totalHeight = btnBottom;
    self.height = self.totalHeight;
    self.left = self.left;
    self.top = self.top;
    
    [self setChoiceButtonsSelected];
}


//设置所有按钮处于选中或未选中状态
-(void)setChoiceButtonsSelected{
    for(UIButton *btn in _normalButtons){
        [self setChoiceButtonSelected:btn];
    }
}


//设置当前按钮是否处于选中状态
-(void)setChoiceButtonSelected:(UIButton *)button{
    __block BOOL selected = NO;
    
    [_choiceArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *title;
        if(!self.key){
            title = (NSString *)obj;
        }else{
            title = obj[self.key];
        }
        
        if([title isEqualToString:button.titleLabel.text]){
            *stop = YES;
            selected = YES;
        }
    }];
    
    button.selected = selected;
}


-(void)setNormal:(NSArray *)normalArr ChoiceArr:(NSArray *)choiceArr attType:(SSAttributeSelectedType)attType attBlock:(SSAttributeBlock)attBlaock{
    _attType = attType;
    _attBlock = attBlaock;
    
    [_choiceArray removeAllObjects];
    [_choiceArray addObjectsFromArray:choiceArr];
    self.normalArray = normalArr;
    
    
}



-(void)buttonPressed:(UIButton *)sender{
    
    NSInteger index = sender.tag - 10;
    
    //不可切换按钮状态
    if(_attType == SSAttributeSelectedNoChoice){
        _attBlock(SSAttributeSelectedNoChoice,sender);
    }
    
    //单选必选
    else if(_attType == SSAttributeSelectedMustRadio){
        if(sender.selected == YES)return;
        else{
            [_choiceArray removeAllObjects];
            [_choiceArray addObject:_normalArray[index]];
            [self setChoiceButtonsSelected];
            _attBlock(SSAttributeSelectedMustRadio,_choiceArray);
        }
    }
    
    //单选非必选
    else if (_attType == SSAttributeSelectedNoMustRadio){
        if(sender.selected == YES){
            [_choiceArray removeObject:_normalArray[index]];
            [self setChoiceButtonsSelected];
        }
        else{
            [_choiceArray removeAllObjects];
            [_choiceArray addObject:_normalArray[index]];
            [self setChoiceButtonsSelected];
        }
        _attBlock(SSAttributeSelectedMustRadio,_choiceArray);
    }
    
    //多选
    else{
        if(sender.selected == YES){
            [_choiceArray removeObject:_normalArray[index]];
            [self setChoiceButtonsSelected];
        }
        else{
            [_choiceArray addObject:_normalArray[index]];
            [self setChoiceButtonsSelected];
        }
        _attBlock(SSAttributeSelectedMulti,_choiceArray);
    }
}






@end
