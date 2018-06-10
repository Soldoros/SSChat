//
//  SSShareView.h
//  htcm
//
//  Created by soldoros on 2018/4/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//


//封装一个分享弹窗
#import <UIKit/UIKit.h>


/**
 分享视图的cell
 */
#define SSShareViewCellId    @"SSShareViewCellId"


@interface SSShareViewCell : UICollectionViewCell

//图标
@property(nonatomic,strong)UIImageView *mImgView;
//标题
@property(nonatomic,strong)UILabel *mTitleLab;

@end



/**
 分享视图封装
 */
#define SSShareViewH    SCREEN_Width * 0.5+105

@protocol SSShareViewDelegate <NSObject>

-(void)SSShareViewBtnClick:(NSInteger)index;

@end

@interface SSShareView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,assign)id<SSShareViewDelegate>delegate;

@property(nonatomic,strong)UICollectionView *mCollectionView;
@property(nonatomic,strong)NSMutableArray *datas;
//底部按钮
@property(nonatomic,strong)UIButton *mBottomBtn;
//顶部文字
@property(nonatomic,strong)UILabel *mTitleLab;
//顶部线条
@property(nonatomic,strong)UIView *mLine1,*mLine2;

@end








