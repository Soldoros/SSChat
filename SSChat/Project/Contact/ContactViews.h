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

//群详情底部按钮点击代理
-(void)ContactTeamDetBottomCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender;

@end


#define ContactListCellId  @"ContactListCellId"
#define ContactListCellH   60

//通讯录列表
@interface ContactListCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath  *indexPath;

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mRedLab;

//通讯录数据
@property(nonatomic,strong)NIMUser *user;
@property(nonatomic,strong)NSDictionary *dataDic;
//搜索好友的数据
@property(nonatomic,strong)NSString *friendString;
//群组数据
@property(nonatomic,strong)NIMTeam *team;

@end



#define ContactChoiceFriendsCellId  @"ContactChoiceFriendsCellId"
#define ContactChoiceFriendsCellH   50

//通讯录列表
@interface ContactChoiceFriendsCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath  *indexPath;
@property(nonatomic,strong)NIMUser *user;

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;


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




/**
 群组详情的成员cell
 */
#define ContactTeamDetTopCellId  @"ContactTeamDetTopCellId"
#define ContactTeamDetTopCellW   (SCREEN_Width - 20)/5
#define ContactTeamDetTopCellH   (SCREEN_Width - 20)/5 + 10

@interface ContactTeamDetTopCell : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UIImageView *mImgView;
@property(nonatomic,strong)UILabel *mNameLab;

@property(nonatomic,strong)NIMTeamMember *member;

@end


/**
 群组详情的其他cell
 */
#define ContactTeamDetOtherCellId  @"ContactTeamDetOtherCellId"
#define ContactTeamDetOtherCellW   SCREEN_Width
#define ContactTeamDetOtherCellH   50

@interface ContactTeamDetOtherCell : UICollectionViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NIMTeam *team;

@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mDetaillab;
@property(nonatomic,strong)UISwitch *mSwitch;

/**
 设置讨论组数据
 */
-(void)setTeamData:(NIMTeam *)team;

/**
 设置高级群数据
 */
-(void)setSeniorTeamData:(NIMTeam *)team;

@end


/**
 群组详情的功能cell 清空消息 退出群组
 */
#define ContactTeamDetBottomCellId  @"ContactTeamDetBottomCellId"
#define ContactTeamDetBottomCellW   SCREEN_Width
#define ContactTeamDetBottomCellH   50

@interface ContactTeamDetBottomCell : UICollectionViewCell

@property(nonatomic,assign)id<ContactViewsDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NIMTeam *team;
@property(nonatomic,strong)UIButton *mButton;

/**
 设置讨论组数据
 */
-(void)setTeamData:(NIMTeam *)team;

/**
 设置高级群数据
 */
-(void)setSeniorTeamData:(NIMTeam *)team;

@end




/**
 好友详情的其他cell
 */
#define ContactFriendsDetOtherCellId  @"ContactFriendsDetOtherCellId"
#define ContactFriendsDetOtherCellH   50

@interface ContactFriendsDetOtherCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UISwitch *mSwitch;

@property(nonatomic,strong)NIMUser  *user;

@end


/**
 群组详情的功能cell 清空消息 退出群组
 */
#define ContactFriendsDetBottomCellId  @"ContactFriendsDetBottomCellId"
#define ContactFriendsDetBottomCellH   50

@interface ContactFriendsDetBottomCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;

//好友数据
@property(nonatomic,strong)NIMUser *user;

@end
