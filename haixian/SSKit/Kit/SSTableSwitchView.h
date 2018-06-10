//
//  SSTableSwitchView.h
//  htcm
//
//  Created by soldoros on 2018/4/20.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import <UIKit/UIKit.h>

@protocol SSTableSwitchViewDelegate <NSObject>

-(void)SSTableSwitchViewBtnClick:(UIButton *)sender;

@end

@interface SSTableSwitchView : UIView

@property(nonatomic,assign)id<SSTableSwitchViewDelegate>delegate;


//按钮数组
@property(nonatomic,strong)NSArray *buttonArr;
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


@end









