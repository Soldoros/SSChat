//
//  ContactViews.h
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactData.h"

@protocol ContactViewsDelegate <NSObject>

//好友申请列表的按钮点击代理
-(void)ContactFriendRequestsCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender;

@end

#define ContactListCellId  @"ContactListCellId"
#define ContactListCellH   60

//通讯录列表
@interface ContactListCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath  *indexPath;
@property(nonatomic,strong)NIMUser *user;

//通讯录数据
@property(nonatomic,strong)NSDictionary *dataDic;
//搜索好友的数据
@property(nonatomic,strong)NSString *friendString;

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;

//红色数字提示
@property(nonatomic,strong)UILabel *mRedLab;


@end



//好友申请列表
#define ContactFriendRequestsCellId  @"ContactFriendRequestsCellId"
#define ContactFriendRequestsCellH   150

@interface ContactFriendRequestsCell : UITableViewCell

@property(nonatomic,assign)id<ContactViewsDelegate>delegate;

@property(nonatomic,strong)NSIndexPath  *indexPath;
@property(nonatomic,strong)NIMSystemNotification *notification;

//时间 背景图
@property(nonatomic,strong)UILabel     *mTimeLab;
@property(nonatomic,strong)UIView      *mBackView;
//头像 用户名 提示 线条
@property(nonatomic,strong)UIImageView *mLeftImgView; 
@property(nonatomic,strong)UILabel     *mTitleLab;
@property(nonatomic,strong)UILabel     *mMessageLab;
@property(nonatomic,strong)UIView      *mLine1;
@property(nonatomic,strong)UIView      *mLine2;
//拒绝 同意
@property(nonatomic,strong)UIButton    *mButton1;
@property(nonatomic,strong)UIButton    *mButton2;
//处理后的提示
@property(nonatomic,strong)UILabel     *mBottomLab;

@end
