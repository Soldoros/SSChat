//
//  SSChoiceView.h
//  hxsc
//
//  Created by soldoros on 2017/7/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 点击按钮回调代码块

 @param index 按钮的tag值  取消10  确认11
 */
typedef void (^SSChoiceBlock)(NSInteger index);



@interface SSChoiceView : UIView


-(instancetype)initWith:(NSString *)title message:(NSString *)message choiceBlock:(SSChoiceBlock)choiceBlock;

@property(nonatomic,copy)SSChoiceBlock choiceBlock;

//标题 消息
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *messsage;

//左右按钮的文字提示
@property(nonatomic,strong)NSString *cancelBtn;
@property(nonatomic,strong)NSString *selecedBtn;
//按钮颜色
@property(nonatomic,strong)UIColor *selecedColor;
@property(nonatomic,strong)UIColor *DefaultColor;


//标题 消息 左右按钮
@property(nonatomic,strong)UILabel  *mTitleLab;
@property(nonatomic,strong)UILabel  *mMsgLab;
@property(nonatomic,strong)UIButton *mLeftBtn;
@property(nonatomic,strong)UIButton *mRightBtn;






@end
