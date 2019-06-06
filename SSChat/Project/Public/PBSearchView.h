//
//  PBSearchView.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBData.h"


@protocol PBSearchViewsDelegate <NSObject>

//表单的搜索头按钮点击回调
-(void)PBSearchTableHeaderBtnClick:(UIButton *)sender;

-(void)PBSearchClassTypeViewCellBtnClick:(NSDictionary *)dic keyString:(NSString *)keyString;

-(void)PBSearchCell2BtnClick:(NSIndexPath*)indexPath;

//搜索结果回调
-(void)PBSearchHeaderBtnClick:(UIButton *)sender currentBtn:(UIButton *)currentBtn state:(SearchResultState)state;

//搜索界面点击回调
-(void)PBSearchCellClick:(NSIndexPath*)indexPath result:(NSString *)result;

//好友申请列表的按钮点击代理
-(void)PBSearchFriendCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender;

@end


//表单搜索框
#define PBSearchTableHeaderH  55

@interface PBSearchTableHeader : UIView<UISearchBarDelegate>

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder;

@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;

@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UISearchBar *mSearchBar;

@end



/**
 UICollectionReusableView
 */
@interface PBSearchReusableView : UICollectionReusableView

@property(nonatomic,assign)NSInteger section;
@property(nonatomic,strong)UILabel *mLab;

@end



/**
 UICollectionViewCell
 */
#define PBSearchCellId     @"PBSearchCellId"
#define PBSearchCellH      45

@interface PBSearchCell : UICollectionViewCell

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)NSString *searchString;

@end


/**
 UICollectionViewCell
 */
#define PBSearchCell2Id    @"PBSearchCell2Id"
#define PBSearchCell2H     45


@interface PBSearchCell2 : UICollectionViewCell

@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)UIView  *mLine;

@property(nonatomic,strong)UIButton  *mDeleteBtn;

@end





/**
 UICollectionView
 */

@interface PBSearchView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate>

@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;

//搜索类型 套餐 医生 科室 症状 .....
@property(nonatomic,assign)PBSearchAllType searchType;

@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;

@end




/**
 搜索结果 header
 */
@interface PBSearchHeader : UIView

@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;
@property(nonatomic,assign)SearchResultState searchState;

//分类 类型 销量  价格
@property(nonatomic,strong)UIButton *mButton1;
@property(nonatomic,strong)UIButton *mButton2;
@property(nonatomic,strong)UIButton *mButton3;
@property(nonatomic,strong)UIButton *mButton4;

//设置分类按钮的名称
@property(nonatomic,strong)NSString *keyString;
-(void)setbuttonDic:(NSDictionary *)dict;


@end



/**
 UICollectionView
 */

@interface PBSearchClassTypeView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;
@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)NSString *keyString;

@end



/**
 UICollectionViewCell
 */
@interface PBSearchClassTypeCell : UICollectionViewCell


@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)NSString *keyString;
@property(nonatomic,strong)NSDictionary *searchDic;

@end




#define PBSearchFriendCellId  @"PBSearchFriendCellId"
#define PBSearchFriendCellH   60

//搜索好友cell
@interface PBSearchFriendCell : UITableViewCell

@property(nonatomic,assign)id<PBSearchViewsDelegate>delegate;
@property(nonatomic,strong)NSIndexPath  *indexPath;
//已经发送添加的好友 准备添加的好友
@property(nonatomic,strong)NSArray  *invitedUsers;

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;

@property(nonatomic,strong)NIMUser  *user;

@end

