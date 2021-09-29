//
//  SSVideoView.h
//  SSChatView
//
//  Created by soldoros on 2018/10/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "UIView+SSAdd.h"
#import <AVFoundation/AVFoundation.h>
#import "SSImageGroupData.h"



/**
 当前视频界面的播放状态和控件需要展示的状态

 - SSVideoLayerValue1: 未播放静止（播放按钮）
 - SSVideoLayerValue2: 未播放静止+点击了空白处（所有控件）
 - SSVideoLayerValue3: 播放中
 - SSVideoLayerValue4: 播放中+点击了空白处（所有控件）
 - SSVideoLayerValue5: 播放暂停中（所有控件）
 - SSVideoLayerValue6: 播放暂停+点击空白处
 - SSVideoLayerValue7: 播放完毕 （播放按钮）
 - SSVideoLayerValue8: 播放完毕+点击空白处（所有控件）
 */
typedef NS_ENUM(NSInteger, SSVideoLayerStatus) {
    SSVideoLayerValue1 = 1,
    SSVideoLayerValue2,
    SSVideoLayerValue3,
    SSVideoLayerValue4,
    SSVideoLayerValue5,
    SSVideoLayerValue6,
    SSVideoLayerValue7,
    SSVideoLayerValue8,
};


/**
 视频的图层 100%透明  可以展示帧图片  展示所有控件 添加点击事件
 */
@protocol SSVideoImageLayerDelegate <NSObject>

//点击图片
//-(void)SSVideoImageLayerGesture:(UITapGestureRecognizer *)gesture;

//点击按钮
-(void)SSVideoImageLayerButtonClick:(UIButton *)sender item:(SSImageGroupItem *)item;

//拖动进度条
-(void)SSVideoImageLayerSliderEventValueChanged:(UISlider *)slider item:(SSImageGroupItem *)item;

@end






@interface SSVideoImageLayer : UIImageView

-(instancetype)initWithItem:(SSImageGroupItem *)item;
//视频信息

@property(nonatomic,assign)id<SSVideoImageLayerDelegate>delegate;

//根据屏幕旋转刷新控件的位置
-(void)setNewFrameWithDeviceoRientation;

//控件的显示和隐藏
-(void)hiddenAllControl;
-(void)showAllControl;
@property(nonatomic,assign)BOOL allHidden;


//展示单位
@property(nonatomic,strong)SSImageGroupItem *item;
//播放状态
@property(nonatomic,assign)SSVideoLayerStatus status;


//左上角返回按钮
@property(nonatomic,strong)UIButton *mBackButton;
//视频中间播放暂停按钮
@property(nonatomic,strong)UIButton *playCenterButton;
//左下角播放暂停按钮
@property(nonatomic,strong)UIButton *playLeftButton;



@end



/**
 短视频播放
 */
@protocol SSVideoViewDelegate <NSObject>

//点击返回控件
-(void)SSVideoViewImageButtonClick:(UIButton *)sender item:(SSImageGroupItem *)item;

@end



@interface SSVideoView : UIView<SSVideoImageLayerDelegate>


@property(nonatomic,strong)UIView *mPlayView;

-(instancetype)initWithItem:(SSImageGroupItem *)item;

@property(nonatomic,assign)id<SSVideoViewDelegate>videoViewDelegate;

//当前是视图展示状态
@property(nonatomic,assign)SSImageShowType showType;

//播放状态
@property(nonatomic,assign)SSVideoLayerStatus status;

//设置frame
@property(nonatomic,assign)CGRect videoViewFrame;
//展示单位
@property(nonatomic,strong)SSImageGroupItem *item;
//展示图层
@property(nonatomic,strong)SSVideoImageLayer   *mVideoImagelayer;

//最新的视频
@property(nonatomic,strong)AVPlayer      *player;
@property(nonatomic,strong)AVPlayerLayer *playerLayer;


@end



