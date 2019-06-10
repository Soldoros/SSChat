//
//  SSChatVideoCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/15.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatVideoCell.h"


@implementation SSChatVideoCell


-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
   
    
    self.mImgView = [UIImageView new];
    self.mImgView.layer.cornerRadius = 5;
    self.mImgView.layer.masksToBounds  = YES;
    self.mImgView.contentMode = UIViewContentModeScaleAspectFit;
    self.mImgView.backgroundColor = [UIColor whiteColor];
    [self.mBackImgButton addSubview:self.mImgView];
    self.mImgView.userInteractionEnabled = YES;
    
    
    self.mVideoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mImgView addSubview:self.mVideoBtn];
    self.mVideoBtn.backgroundColor = [UIColor blackColor];
    self.mVideoBtn.alpha = 0.25;
    [self.mVideoBtn addTarget:self action:@selector(videoButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.mVideoImg = [UIImageView new];
    self.mVideoImg.bounds = CGRectMake(0, 0, 35, 35);
    [self.mImgView addSubview:self.mVideoImg];
    self.mVideoImg.image = [UIImage imageNamed:@"icon_bofang"];
    self.mVideoImg.userInteractionEnabled = NO;

}


-(void)setLayout:(SSChatMessagelLayout *)layout{
    
    [super setLayout:layout];
    
    UIImage *image = [UIImage imageNamed:layout.chatMessage.backImgString];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    
    UIImage *videoImage = [UIImage imageWithContentsOfFile:self.layout.chatMessage.videoObject.coverPath];
    if(videoImage){
        self.mImgView.image = videoImage;
    }else{
        NSURL *url = [NSURL URLWithString:self.layout.chatMessage.videoObject.coverUrl];
        [self.mImgView setImageWithURL:url placeholder:[UIImage imageFromColor:CellLineColor] options:YYWebImageOptionProgressive completion:nil];
    }
    
    self.mImgView.frame = self.mBackImgButton.bounds;
    //给地图设置一个描边 描边跟背景按钮的气泡图片一样
    UIImageView *btnImgView = [[UIImageView alloc]initWithImage:image];
    btnImgView.frame = CGRectInset(self.mImgView.frame, 0.0f, 0.0f);
    self.mImgView.layer.mask = btnImgView.layer;

    self.mVideoBtn.frame = self.mImgView.bounds;
    self.mVideoImg.centerY = self.mImgView.height*0.5;
    self.mVideoImg.centerX = self.mImgView.width*0.5;

    [self setMessageReadStatus];
    [self setNameWithTeam];
}


-(void)videoButtonPressed:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:layout:)]){
        [self.delegate SSChatImageVideoCellClick:self.indexPath layout:self.layout]; 
    }
}




@end
