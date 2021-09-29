//
//  SSPickerController.h
//  htcm
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseVirtualController.h"



/**
 时间选择器
 */

#define SSPickerViewW   SCREEN_Width-100
#define SSPickerViewH   320

@protocol SSPickerViewDelegate <NSObject>

-(void)SSPickerViewBtnDidSelectRow:(NSInteger)row inComponent:(NSInteger)component sender:(UIButton *)sender;

@end


@interface SSPickerView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,assign)id<SSPickerViewDelegate>delegate;

//标题
@property(nonatomic,strong)UILabel *mTitleLab;
//取消
@property(nonatomic,strong)UIButton *mBackBtn;
//确认
@property(nonatomic,strong)UIButton *mOKBtn;

//时间选择器
@property (nonatomic, strong)UIPickerView *mPickerView;
@property (nonatomic, strong)NSMutableArray *datas;
@property(nonatomic,strong)NSString *title;

//选中的分组和行
@property (nonatomic, assign)NSInteger component;
@property (nonatomic, assign)NSInteger row;

@end









/**
 滚动选择弹窗控制器
 */

typedef void (^PickerBlock)(NSString *string);

@interface SSPickerController : UIViewController<SSPickerViewDelegate>

@property(nonatomic,copy)PickerBlock pickerBlock;

@property(nonatomic,strong)UIView *backView;
@property(nonatomic,strong)SSPickerView *pickerView;
@property(nonatomic,strong)NSMutableArray *datas;
@property(nonatomic,strong)NSString *titleString;

-(void)setSSPickerViewAnimation;


@end







