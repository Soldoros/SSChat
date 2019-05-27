//
//  SSAttributeView.h
//  htcm
//
//  Created by soldoros on 2018/6/13.
//  Copyright © 2018年 soldoros. All rights reserved.
//



//属性选择器  选择器的按钮从 （0，0）开始布局 
#import <UIKit/UIKit.h>


#define SSAttBtnFont            12          //按钮字体大小
#define SSAttBtnHeight          25          //按钮高度
#define SSAttBtnSpaceTB         15          //按钮之间的上下间距
#define SSAttBtnSpaceLR         15          //按钮之间的左右间距
#define SSAttBtnSpaceInsideLR   10          //按钮内部的左右间距
#define SSAttNormalColor    [UIColor grayColor]  //按钮文字默认颜色
#define SSAttSelecetColor   TitleColor      //按钮文字选中颜色
#define SSAttBtnImgWidth        5          //按钮有图片时增加的宽度



/**
 给出的选择器是多选还是单选

 - SSAttributeSelectedNoChoice: 不可切换按钮状态 但是可以点击回调
 - SSAttributeSelectedMustRadio: 单选必选
 - SSAttributeSelectedNoMustRadio: 单选非必选
 - SSAttributeSelectedMulti: 多选
 */
typedef NS_ENUM(NSInteger,SSAttributeSelectedType) {
    SSAttributeSelectedNoChoice=1,
    SSAttributeSelectedMustRadio,
    SSAttributeSelectedNoMustRadio,
    SSAttributeSelectedMulti,
};


/**
 属性选择器勾选后的回调代码块

 @param type 返回选择器的选择类型（多选 单选）
 @param object 返回选择的对象
 */
typedef void (^SSAttributeBlock)(SSAttributeSelectedType type , id object);

@interface SSAttributeView : UIView


//属性选择器的选择方式 多选还是单选
@property(nonatomic,assign)SSAttributeSelectedType attType;
//属性选择器的回调代码块
@property(nonatomic,copy)SSAttributeBlock attBlock;


//当前对象的宽高
@property(nonatomic,assign)CGFloat  attWidth;
@property(nonatomic,assign)CGFloat  attHeight;
//当前对象总高度
@property(nonatomic,assign)CGFloat  totalHeight;


//传入的默认参数 选中的参数  全部按钮数组 选中的按钮数组
@property(nonatomic,strong)NSArray         *normalArray;
@property(nonatomic,strong)NSMutableArray  *choiceArray;
@property(nonatomic,strong)NSMutableArray  *normalButtons;
@property(nonatomic,strong)NSMutableArray  *choiceButtons;

//按钮是否设置圆角  设置圆角YES  不设置圆角NO
@property(nonatomic,assign)BOOL    btnCorners;
//按钮字体大小
@property(nonatomic,assign)CGFloat btnFont;

//默认按钮的拉伸保护区域
@property(nonatomic,assign)CGFloat btnNorInsets;
//选中按钮的拉伸保护区域
@property(nonatomic,assign)CGFloat btnSelInsets;

//按钮高度(按钮的高度一般是固定的)
@property(nonatomic,assign)CGFloat btnHeight;

//按钮上下间距
@property(nonatomic,assign)CGFloat btnSpaceTB;
//按钮左右间距
@property(nonatomic,assign)CGFloat btnSpaceLR;
//按钮字体距离按钮边缘左右间距
@property(nonatomic,assign)CGFloat btnSpaceInsideLR;


//按钮默认文字颜色  选中的文字颜色
@property(nonatomic,strong)UIColor *normalColor;
@property(nonatomic,strong)UIColor *selecetColor;
//按钮有图片的时候额外增加的宽度
@property(nonatomic,assign)CGFloat btnImgWidth;

//按钮默认背景图  选中的背景图
@property(nonatomic,strong)NSString *btnNorBackImg;
@property(nonatomic,strong)NSString *btnSelBackImg;
//按钮默认图片  选中的图片
@property(nonatomic,strong)NSString *btnNormalImg;
@property(nonatomic,strong)NSString *btnSelectedImg;


//是否有键值对
@property(nonatomic,strong)NSString *key;



/**
 传入数组和选中的数组

 @param normalArr 默认内容
 @param choiceArr 选中的内容
 @param attType 属性选择器模式(单选 多选)
 @param attBlaock 选中后的回调代码块
 */
-(void)setNormal:(NSArray *)normalArr ChoiceArr:(NSArray *)choiceArr attType:(SSAttributeSelectedType)attType attBlock:(SSAttributeBlock)attBlaock;


/**
 初始化当前对象

 @param frame 当前对象的frame
 @param norBackImg 按钮默认背景图片
 @param selBackImg 按钮选中的背景图片
 @param normalImg 按钮默认的图片
 @param selectedImg 按钮选中的图片
 @param btnHeight 按钮高度
 @return 返回当前对象
 */
-(instancetype)initWithFrame:(CGRect)frame norBackImg:(NSString *)norBackImg selBackImg:(NSString *)selBackImg normalImg:(NSString *)normalImg selectedImg:(NSString *)selectedImg btnHeight:(CGFloat)btnHeight;







@end
