//
//  SSChoiceView.h
//  hxsc
//
//  Created by soldoros on 2017/7/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSChoiceViewDelegate <NSObject>

-(void)SSChoiceViewBtnClick:(NSInteger)index;

@end

@interface SSChoiceView : UIView

@property(nonatomic,assign)id<SSChoiceViewDelegate>delegate;

-(instancetype)initWith:(NSString *)title message:(NSString *)message;

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
