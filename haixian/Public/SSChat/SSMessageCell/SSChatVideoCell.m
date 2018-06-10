//
//  SSChatVideoCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatVideoCell.h"

@implementation SSChatVideoCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.mImgBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:self.mImgBtn];
    
    
    _mImgView = [UIImageView new];
    _mImgView.userInteractionEnabled = YES;
    _mImgView.layer.cornerRadius = 5;
    _mImgView.layer.masksToBounds  = YES;
    _mImgView.contentMode = UIViewContentModeScaleAspectFill;
    _mImgView.backgroundColor = [UIColor whiteColor];
    [_mImgBtn addSubview:_mImgView];
    
    
//    UIImage *bofangImg = [[UIImage imageNamed:@"icon_bofang"] imageWithColor:[UIColor whiteColor]];

    self.mVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mVideoBtn.userInteractionEnabled = YES;
    [self.mImgView addSubview:self.mVideoBtn];
    [self.mVideoBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.mVideoBtn.backgroundColor = [UIColor blackColor];
    self.mVideoBtn.alpha = 0.5;
    [self.mVideoBtn setImage:[UIImage imageNamed:@"icon_bofang"] forState:UIControlStateNormal];
    
    
}


-(void)setLayout:(SSChatModelLayout *)layout{
    
    [super setLayout:layout];
    
    self.mImgBtn.frame = layout.btnRect;
    [self.mImgBtn setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mImgBtn setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];
    
    
    NSURL *imgUrl = [NSURL URLWithString:layout.model.thumbnailRemotePath];
    
    _mImgView.frame = _mImgBtn.bounds;
    [_mImgView sd_setImageWithURL:imgUrl placeholderImage:[UIImage imageWithColor:[UIColor clearColor]]];
    [self makeMaskView:_mImgView withImage:layout.btnImage];
    self.mVideoBtn.frame = self.mImgView.bounds;
    
}


- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}


//点击视频回调
-(void)buttonPressed:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellBtnClick:index:messageType:)]){
        [self.delegate SSChatBaseCellBtnClick:self.indexPath index:sender.tag messageType:SSChatMessageTypeVideo];
    }
}



@end
