//
//  AttributeView.h
//  htcm
//
//  Created by soldoros on 2018/4/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>


//字体
#define attFont     12
//左侧边距
#define attLS       0
//右侧边距
#define attRS       0
//上侧边距
#define attTS       0
//下侧边距
#define attBS       0
//左右间距
#define attRowS     15
//上下间距
#define attLineS    15
//按钮高度
#define attBtnH     27
//按钮里面字体左右间距
#define attBtnLRS   10
//按钮线条宽度
#define attBtnBoder   0


/**
 按钮 尺寸自适应
 */

@protocol AttributeViewDelegate <NSObject>

-(void)AttributeViewBtnClick:(UIButton *)sender;

@end
@interface AttributeView : UIView

@property(nonatomic,assign)id<AttributeViewDelegate>deleagte;

//按钮高度
@property(nonatomic,assign)CGFloat buttonHeight;
//按钮上下间距
@property(nonatomic,assign)CGFloat buttonAttLineS;
//按钮左右间距
@property(nonatomic,assign)CGFloat buttonAttRowS;
//按钮字体距离按钮边缘左右间距
@property(nonatomic,assign)CGFloat buttonAttBtnLRS;

//按钮字体大小
@property(nonatomic,assign)CGFloat buttonFont;

//按钮默认背景图  选中的背景图
@property(nonatomic,strong)NSString *normolStr;
@property(nonatomic,strong)NSString *selecetStr;
//按钮默认文字颜色  选中的文字颜色
@property(nonatomic,strong)UIColor *normolColor;
@property(nonatomic,strong)UIColor *selecetColor;

//设置圆角
@property(nonatomic,assign)BOOL yuanjiao;

//数据源
@property(nonatomic,strong)NSString *key;
@property(nonatomic,strong)NSArray *array;
//默认选中
@property(nonatomic,strong)NSString *defaultAtt;


@property(nonatomic,assign)CGFloat attHeight;

@end




