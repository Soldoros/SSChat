//
//  SSChatBaseCell.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.


#import <UIKit/UIKit.h>
#import "SSChatModelLayout.h"


@protocol SSChatBaseCellDelegate <NSObject>

//点击头像
-(void)SSChatBaseCellImgBtnClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath;

//cell点击内容
-(void)SSChatBaseCellBtnClick:(NSIndexPath*)indexPath index:(NSInteger)index messageType:(SSChatMessageType)messageType;

//撤销消息重新编辑
-(void)SSChatBaseCellLabClick:(NSIndexPath*)indexPath index:(NSInteger)index yout:(SSChatModelLayout *)yout;

@end

@interface SSChatBaseCell : UITableViewCell

//头像
@property(nonatomic, strong) UIButton *mHeaderImgBtn;
//时间
@property(nonatomic, strong) UILabel  *mMsgTimeLab;



@property(nonatomic,assign)id<SSChatBaseCellDelegate>delegate;

@property(nonatomic, strong) SSChatModelLayout     *layout;
@property(nonatomic, strong) UIMenuController *menu;

-(void)initSSChatCellUserInterface;

@end
