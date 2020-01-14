//
//  SSImageGroupView.h
//  SSChatView
//
//  Created by soldoros on 2018/10/17.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSVideoView.h"




/**
 图片视图的cell
 */

@protocol SSImageGroupCellDelegate <NSObject>

//点击图片
-(void)SSImageGroupCellImageClick:(NSInteger)index gesture:(UITapGestureRecognizer *)gesture;

@end

@interface SSImageGroupCell : UIScrollView<UIScrollViewDelegate>

@property(nonatomic,assign)id<SSImageGroupCellDelegate>imageCelldelegate;

//初始化cell
-(instancetype)initWithItem:(SSImageGroupItem *)item;
//设置frame
@property(nonatomic,assign)CGRect imageCellFrame;
//展示单位
@property(nonatomic,strong)SSImageGroupItem *item;
//展示图
@property(nonatomic,strong)UIImageView   *mImageView;


@end







/**
 图片展示视图
 */
typedef void (^SSImageDismissBlock)(void);

@interface SSImageGroupView : UIView<UIScrollViewDelegate,SSImageGroupCellDelegate,SSVideoViewDelegate>

-(instancetype)initWithGroupItems:(NSArray *)groupItems currentIndex:(NSInteger)currentIndex;

@property(nonatomic,assign)CGFloat           height;
@property(nonatomic,assign)CGFloat           width;

//展示图数组
@property(nonatomic,strong)NSArray           *groupItems;
//当前展示的视图
@property(nonatomic,assign)NSInteger         currentIndex;
@property(nonatomic,assign)SSImageGroupItem  *currentItem;
@property(nonatomic,strong)UIImageView       *fromImgView;
//分页控制器
@property(nonatomic,assign)NSInteger         currentPage;
@property(nonatomic,strong)UIPageControl     *mPageController;
//第一张展示图
@property(nonatomic,strong)UIImageView       *fristImgView;

//半透明背景图
@property(nonatomic,strong)UIView            *backView;
//图片数组滚动视图
@property(nonatomic,strong)UIScrollView      *mScrollView;
//关闭当前视图
@property(nonatomic,copy)SSImageDismissBlock dismissBlock;

//屏幕是否正在旋转 旋转过程中滚动视图不能进行位移
@property(nonatomic,assign)BOOL              deviceTransform;
//屏幕在一定情况下不需要处理旋转操作
@property(nonatomic,assign)UIDeviceOrientation  deviceOrientation;



@end



