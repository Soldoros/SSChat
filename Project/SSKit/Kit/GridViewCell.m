//
//  GridViewCell.m
//  SamplePhotosDemo
//
//  Created by iTruda on 2018/6/18.
//  Copyright © 2018年 iTruda. All rights reserved.
//

#import "GridViewCell.h"

@interface GridViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *livePhotoBadgeImageView;

@end

@implementation GridViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        //choice_nol
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self.contentView addSubview:_imageView];
        
        _livePhotoBadgeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 28.f, 28.f)];
        [self.contentView addSubview:_livePhotoBadgeImageView];
        
        
        UIImage *img = [UIImage imageFromColor:makeColorRgbAlpha(0, 0, 0, 0.1)];
        
        _mVideoImg = [[UIImageView alloc] initWithFrame:self.bounds];
        _mVideoImg.contentMode = UIViewContentModeScaleAspectFill;
        _mVideoImg.clipsToBounds = YES;
        [self.contentView addSubview:_mVideoImg];
        _mVideoImg.image = img;
        
        _mVideoIcon= [[UIImageView alloc] initWithFrame:makeRect(0, 0, 30, 30)];
        _mVideoIcon.centerX = _mVideoImg.width * 0.5;
        _mVideoIcon.centerY = _mVideoImg.height * 0.5;
        _mVideoIcon.contentMode = UIViewContentModeScaleAspectFill;
        _mVideoIcon.clipsToBounds = YES;
        [_mVideoImg addSubview:_mVideoIcon];
        _mVideoIcon.image = makeImage(@"icon_bofang");
        
        
        _mChoiceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mChoiceBtn.bounds = makeRect(0, 0, 20, 20);
        [self.contentView addSubview:_mChoiceBtn];
        _mChoiceBtn.right = self.width - 5;
        _mChoiceBtn.top = 5;
        [_mChoiceBtn setBackgroundImage:[UIImage imageNamed:@"choice_nol2"] forState:UIControlStateNormal];
        [_mChoiceBtn setBackgroundImage:[UIImage imageNamed:@"choice_sel2"] forState:UIControlStateSelected];
        _mChoiceBtn.selected = NO;
        [_mChoiceBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


- (void)setThumbnailImage:(UIImage *)thumbnailImage
{
    _thumbnailImage = thumbnailImage;
    _imageView.image = thumbnailImage;
}

- (void)setLivePhotoBadgeImage:(UIImage *)livePhotoBadgeImage
{
    _livePhotoBadgeImage = livePhotoBadgeImage;
    _livePhotoBadgeImageView.image = livePhotoBadgeImage;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    _imageView.image = nil;
    _livePhotoBadgeImageView.image = nil;
}

//图片1  视频2
-(void)setType:(NSInteger)type{
    _type = type;
    if(_type == 1){
        _mVideoIcon.hidden = YES;
        _mChoiceBtn.hidden = NO;
    }
    else{
        _mVideoIcon.hidden = NO;
        _mChoiceBtn.hidden = YES;
    }
}

-(void)setChoice:(NSInteger)choice{
    _choice = choice;
    
    
    if(_choice == 0 || _type == 2){
        _mChoiceBtn.selected = NO;
        UIImage *img = [UIImage imageFromColor:makeColorRgbAlpha(0, 0, 0, 0.1)];
        _mVideoImg.image = img;
    }
    
    else{
        _mChoiceBtn.selected = YES;
        UIImage *img2 = [UIImage imageFromColor:makeColorRgbAlpha(255, 255, 255, 0.5)];
        _mVideoImg.image = img2;
    }
}

-(void)buttonPressed:(UIButton *)sender{
    
    
}

@end
