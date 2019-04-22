//
//  SSChatImageCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatImageCell.h"

@implementation SSChatImageCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mImgView = [UIImageView new];
    self.mImgView.layer.cornerRadius = 5;
    self.mImgView.layer.masksToBounds  = YES;
    self.mImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.mImgView.backgroundColor = [UIColor whiteColor];
    [self.mBackImgButton addSubview:self.mImgView];
    
}


//发送方可以用本地路径展示大图
//接收方先下载缩略图 点击展开用大图
-(void)setLayout:(SSChatMessagelLayout *)layout{
    [super setLayout:layout];
    
    UIImage *image = [UIImage imageNamed:layout.message.backImgString];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    //普通图片
    if(layout.message.messageType == SSChatMessageTypeImage){
        self.mImgView.frame = self.mBackImgButton.bounds;
        self.mImgView.contentMode = self.layout.message.contentMode;
        
        UIImage *image = [UIImage imageWithContentsOfFile:self.layout.message.imageBody.localPath];
        if(image){
            self.mImgView.image = image;
        }else{
            NSURL *url = [NSURL URLWithString:self.layout.message.imageBody.thumbnailRemotePath];
            [self.mImgView setImageWithURL:url placeholder:[UIImage imageFromColor:BackGroundColor] options:YYWebImageOptionProgressive completion:nil];
        }
    }
    
    //gif图片
    else{
        self.mImgView.frame = self.mBackImgButton.bounds;
        self.mImgView.contentMode = self.layout.message.contentMode;
        self.mImgView.animationImages = self.layout.message.imageArr;
        self.mImgView.animationDuration = self.layout.message.imageArr.count * 0.1;
        [self.mImgView startAnimating];
    }
    
    //给图片设置一个描边 描边跟背景按钮的气泡图片一样
    UIImageView *btnImgView = [[UIImageView alloc]initWithImage:image];
    btnImgView.frame = CGRectInset(self.mImgView.frame, 0.0f, 0.0f);
    self.mImgView.layer.mask = btnImgView.layer;
    
}


//点击展开图片
-(void)buttonPressed:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:layout:)]){
        [self.delegate SSChatImageVideoCellClick:self.indexPath layout:self.layout];
    }
}

@end
