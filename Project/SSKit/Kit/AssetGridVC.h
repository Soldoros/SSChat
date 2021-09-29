//
//  AssetGridVC.h
//  SamplePhotosDemo
//
//  Created by iTruda on 2018/6/18.
//  Copyright © 2018年 iTruda. All rights reserved.
//

#import "BaseCollectionViewController.h"
#import <Photos/Photos.h>

//媒体播放返回
typedef void(^SSMediaMadeImageBlock)(NSString *path);

//相册返回
typedef void(^SSImageEditBlock)(NSArray *imageArr);

//摄像头
typedef void(^SSMedilBtnBlock)(void);


@interface AssetGridVC : BaseCollectionViewController

//全部1 图片2  视频3
@property(nonatomic,assign)NSInteger type;

@property(nonatomic,copy)SSMediaMadeImageBlock videoBlock;
@property(nonatomic,copy)SSImageEditBlock imageBlock;

@property(nonatomic,copy)SSMedilBtnBlock camrerBlock;

//最大选择值
@property(nonatomic,assign)NSInteger maxNumer;

//全部 图片 视频 当前
@property (nonatomic, strong) PHFetchResult<PHAsset *> *alls;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *imgs;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *videos;
@property (nonatomic, strong) PHFetchResult<PHAsset *> *currents;

@property (nonatomic, strong) PHAssetCollection *assetCollection;

//视频时长 秒
@property(nonatomic,strong)NSString *videoTime;

//只选图片或者视频1   混合选择2
@property(nonatomic,assign)NSInteger choiceStatus;
//未选0   图片1  视频2   
@property(nonatomic,strong)NSString *choiceType;

@end
