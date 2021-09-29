//
//  SSActionTableView.h
//  htcm
//
//  Created by soldoros on 2018/4/28.
//  Copyright © 2018年 soldoros. All rights reserved.
//


//弹窗多选列表
#import <UIKit/UIKit.h>



/**
 弹窗单选表单cell
 */

#define SSActionCellH    45
#define SSActionCellId   @"SSActionCellId"
#define SSActionTableW   SCREEN_Width-50


@protocol SSActionCellDelegate <NSObject>

-(void)SSActionCellBtnClick:(UIButton *)sender;

@end

@interface SSActionCell : UITableViewCell

@property(nonatomic,assign)id<SSActionCellDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UIButton *mRightBtn;
//选中状态
@property(nonatomic,assign)BOOL btnSelected;

//数据类型 优惠券1
@property(nonatomic,assign)NSInteger dataStyle;

@end






/**
 弹窗单选表单
 */
@protocol SSActionTableViewDelegate <NSObject>

-(void)SSActionTableViewBtnClick:(NSInteger)index;

@end

@interface SSActionTableView : UIView<UITableViewDelegate,UITableViewDataSource,SSActionCellDelegate>

@property(nonatomic,assign)id<SSActionTableViewDelegate>delegate;

//标题
@property(nonatomic,strong)UILabel *mTitleLab;
//取消
@property(nonatomic,strong)UIButton *mBackBtn;
//确认
@property(nonatomic,strong)UIButton *mOKBtn;


@property(nonatomic,strong)UITableView *mTableView;
@property(nonatomic,strong)NSArray *datas;

//数据类型 优惠券1  退款原因2  取消订单原因3
@property(nonatomic,assign)NSInteger dataStyle;


@end
