//
//  SSInputMoreView.h
//  Project
//
//  Created by soldoros on 2021/9/9.
//

//多媒体键盘更多弹窗
#import <UIKit/UIKit.h>
@class SSInputMoreView;
@class SSInputMoreViewCell;



//更多弹窗
#define SSInputMoreViewH         (2 * SSInputMoreCellH + 30)

@protocol SSInputMoreViewDelegate <NSObject>

- (void)inputMoreView:(SSInputMoreView *)moreView didSelect:(NSDictionary *)dic;

@end

@interface SSInputMoreView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, weak)id<SSInputMoreViewDelegate> delegate;

//分割线
@property (nonatomic, strong)UIView *mLine;
//列表布局
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
//列表
@property (nonatomic,strong)UICollectionView *mCollectionView;
//分页控件
@property (nonatomic,strong)UIPageControl *mPageControl;

//数据
@property (nonatomic,strong)NSMutableArray *datas;
@property (nonatomic,strong)NSMutableDictionary *mItemIndexs;
@property (nonatomic,assign)NSInteger mItemCount;
@property (nonatomic,assign)NSInteger mSectionCount;


@end


//更多视图的cell
#define SSInputMoreCellId  @"SSInputMoreCellId"
#define SSInputMoreCellW   SCREEN_Width/4
#define SSInputMoreCellH   100


@interface SSInputMoreCell : UICollectionViewCell

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong)UIImageView *mImgView;
@property (nonatomic, strong)UILabel *mLabel;

@property (nonatomic, strong)NSDictionary *dataDic;

@end
