//
//  SSTableSwitchView.h
//  htcm
//
//  Created by soldoros on 2018/4/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import <UIKit/UIKit.h>



@interface SSTableSwitchView : UIView

@property(nonatomic,copy)SSViewBtnClickBlock handle;

-(void)buttonPressed:(UIButton *)sender;
-(void)setIndexTableScrollSwitchView:(UIButton *)sender;


//按钮数组
@property(nonatomic,strong)NSArray *buttonArr;

@property(nonatomic,strong)NSMutableArray *buttons;
//按钮文字选中颜色 未选中颜色 尺寸
@property(nonatomic,strong)UIColor *btnDefaultColor;
@property(nonatomic,strong)UIColor *btnSelectedColor;
@property(nonatomic,strong)UIFont  *btnFont;
//线条
@property(nonatomic,strong)UIView  *line;
//线条颜色
@property(nonatomic,strong)UIColor *lineColor;
//当前选中的按钮
@property(nonatomic,strong)UIButton *currentBtn;

//底部线条
@property(nonatomic,strong)UIView *mBottomLine;

//自适应宽度还是等分 默认自适应
@property(nonatomic,assign)BOOL autoWidth;


@end





@interface SSTableScrollSwitchView : UIView<UIScrollViewDelegate>

@property(nonatomic,copy)SSViewBtnClickBlock handle;

@property(nonatomic,strong)UIScrollView *mScrollView;
@property(nonatomic,strong)SSTableSwitchView *mSitchView;

@property(nonatomic,strong)NSArray *array;

-(void)buttonPressed:(UIButton *)sender;
-(void)setIndexTableScrollSwitchView:(UIButton *)sender;


@end





