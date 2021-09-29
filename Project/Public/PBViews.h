//
//  PBViews.h
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PBDatas.h"
#import "SDCycleScrollView.h"

@protocol PBViewsDelegate <NSObject>

//搜索历史的cell点击回调
-(void)PBSearchCellClick:(NSIndexPath*)indexPath result:(NSString *)result;

//cell按钮点击回调
-(void)PBCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender;



//banner图片点击回调
-(void)BannerImageClick:(NSInteger)index object:(id)object;

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

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,assign)id<PBViewsDelegate>delegate;

@property(nonatomic,strong)UILabel *mLab;
@property(nonatomic,strong)UIView  *mLine;

@property(nonatomic,strong)UIButton  *mDeleteBtn;

@end





/**
 UICollectionView
 */

@interface PBSearchView : UIView<UICollectionViewDelegate,UICollectionViewDataSource,UIScrollViewDelegate,PBViewsDelegate>

@property(nonatomic,assign)id<PBViewsDelegate>delegate;



@property(nonatomic,assign)PBSearchAllType searchType;

@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSArray *datas;

@end





//banner 1044*286
#define PBBannerH    SCREEN_Width * 286/1044

@interface PBBanner : UIView<SDCycleScrollViewDelegate>

@property(nonatomic,assign)id<PBViewsDelegate>delegate;

@property(nonatomic,strong) UIView *mColorView;

@property(nonatomic,strong) SDCycleScrollView *cycleScrollView;
//banner数据
@property(nonatomic,strong)NSArray *banners;


@end




//支付顶部视图
#define PBPayTopViewH     150

@interface PBPayTopView: UIView

@property(nonatomic,assign)id<PBViewsDelegate>delegate;

//价格 描述 支付
@property(nonatomic,strong)UILabel *mPriceLab;
@property(nonatomic,strong)UILabel *mDetailLab;

@property(nonatomic,strong)NSTimer *timer;
@property(nonatomic,assign)NSInteger time;


@property(nonatomic,strong)NSDictionary *dataDic;

@end




//支付界面cell
#define PBPayCellH     55
#define PBPayCellId      @"PBPayCellId"

@interface PBPayCell: UITableViewCell

@property(nonatomic,assign)id<PBViewsDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;

//价格 描述 支付
@property(nonatomic,strong)UIImageView *mBackImgView;
@property(nonatomic,strong)UIImageView *mIcon;

@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UIImageView *mRightIcon;

@property(nonatomic,assign)NSInteger count;
@property(nonatomic,strong)NSDictionary *dataDic;

@end



//搜索商品列表
#define PBGoodsCellH       128
#define PBGoodsCellId      @"PBGoodsCellId"

@interface PBGoodsCell: UITableViewCell

@property(nonatomic,assign)id<PBViewsDelegate>delegate;
@property(nonatomic,strong)NSIndexPath *indexPath;


@property(nonatomic,strong)UIImageView *mIcon;

@property(nonatomic,strong)UILabel *mTitleLab1;
@property(nonatomic,strong)UILabel *mTitleLab2;
@property(nonatomic,strong)UILabel *mTitleLab3;
@property(nonatomic,strong)UILabel *mTitleLab4;
@property(nonatomic,strong)UILabel *mTitleLab5;
@property(nonatomic,strong)UIButton *mButton;

@property(nonatomic,strong)NSDictionary *dataDic;

@end

