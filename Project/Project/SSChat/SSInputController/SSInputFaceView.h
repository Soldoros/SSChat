//
//  SSInputFaceView.h
//  Project
//
//  Created by soldoros on 2021/9/16.
//

#import <UIKit/UIKit.h>
#import "SSInputMenuView.h"
#import "SSFaceConfig.h"
@class SSInputFaceView;
@class SSInputFaceCell;

//视图总高度 列表高度
#define SSInputFaceViewH           (220 + SSInputMenuViewH)
#define SSInputFaceCollectionH     (SSInputFaceViewH - SSInputMenuViewH - 30)


@protocol SSInputFaceViewDelegate <NSObject>

//滑动到指定表情分组后的回调。
- (void)inputFaceView:(SSInputFaceView *)faceView scrollToFaceGroupIndex:(NSInteger)index;

//选择某一具体表情后的回调（索引定位）。
- (void)inputFaceView:(SSInputFaceView *)faceView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;

//点击表情视图中 删除 按钮后的操作回调。
- (void)inputFaceViewDidBtnClick:(SSInputFaceView *)faceView sender:(UIButton *)sender;

@end


@interface SSInputFaceView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SSInputMenuViewDelegate>

//添加代理
@property(nonatomic,weak)id<SSInputFaceViewDelegate> delegate;

//底部菜单栏
@property(nonatomic,strong)SSInputMenuView *mMenuView;

//列表布局
@property (nonatomic,strong)UICollectionViewFlowLayout *layout;
//列表
@property (nonatomic,strong)UICollectionView *mCollectionView;
//分页控件
@property (nonatomic,strong)UIPageControl *mPageControl;

//表情数据
@property(nonatomic,strong)NSMutableArray *datas;

@end



//表情cell
#define SSInputFaceCellId  @"SSInputFaceCellId"
#define SSInputFaceCellW   SCREEN_Width/7.0
#define SSInputFaceCellH   SSInputFaceCollectionH/4.0

@interface SSInputFaceCell : UICollectionViewCell

@property (nonatomic, strong)NSIndexPath *indexPath;

@property (nonatomic, strong)UIButton *mButton;

@property (nonatomic, strong)NSString *faceString;

@end
