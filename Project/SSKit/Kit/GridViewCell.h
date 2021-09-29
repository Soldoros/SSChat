//
//  GridViewCell.h
//  SamplePhotosDemo
//
//  Created by iTruda on 2018/6/18.
//  Copyright © 2018年 iTruda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridViewCell : UICollectionViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) NSString *representedAssetIdentifier;
@property (nonatomic, strong) UIImage *thumbnailImage;
@property (nonatomic, strong) UIImage *livePhotoBadgeImage;

@property (nonatomic, strong) UIImageView *mVideoImg;
@property (nonatomic, strong) UIImageView *mVideoIcon;

@property (nonatomic, strong) UIButton  *mChoiceBtn;

//图片1  视频2
@property (nonatomic, assign) NSInteger type;

//选中1 未选中0
@property (nonatomic, assign) NSInteger choice;

@end
