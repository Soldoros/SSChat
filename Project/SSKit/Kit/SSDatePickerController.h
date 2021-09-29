//
//  SSDatePickerController.h
//  htcm
//
//  Created by soldoros on 2018/7/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>




/**
 时间选择器
 */

#define SSDatePickerViewW   SCREEN_Width-30
#define SSDatePickerViewH   320

@protocol SSDatePickerViewDelegate <NSObject>

-(void)SSDatePickerViewBtnClick:(NSInteger)index date:(NSString *)date;

@end



@interface SSDatePickerView : UIView

@property(nonatomic,assign)id<SSDatePickerViewDelegate>delegate;

//是否设置最大最小值
@property(nonatomic,assign)BOOL maxMinSetting;

//标题
@property(nonatomic,strong)UILabel *mTitleLab;
//取消
@property(nonatomic,strong)UIButton *mBackBtn;
//确认
@property(nonatomic,strong)UIButton *mOKBtn;

//时间选择器
@property (nonatomic, strong)UIDatePicker *datePicker;
@property (nonatomic, strong)NSString *timeString;

//格式
@property (nonatomic, strong)NSString *fomart;

@end





/**
 时间选择器的控制器
 */
typedef void (^DatePickerBlock)(NSString *date);

@interface SSDatePickerController : UIViewController

//是否设置最大最小值
@property(nonatomic,assign)BOOL maxMinSetting;


@property(nonatomic,copy)DatePickerBlock datePickerBlock;

@property(nonatomic,strong)SSDatePickerView *datePickerView;
@property(nonatomic,strong)UIView *backView;
-(void)setPickerViewAnimation;

@end







