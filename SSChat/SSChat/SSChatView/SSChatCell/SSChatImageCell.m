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
    [self.mBackImgButton addSubview:self.mImgView];
    
}


//发送方可以用本地路径展示大图
//接收方先下载缩略图 点击展开用大图
-(void)setLayout:(SSChatMessagelLayout *)layout{
    [super setLayout:layout];
    
    UIImage *image = [[UIImage imageNamed:layout.chatMessage.backImgString] imageWithColor:CellLineColor];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    
    //普通图片
    if(layout.chatMessage.messageType == SSChatMessageTypeImage){
        self.mImgView.frame = self.mBackImgButton.bounds;
        self.mImgView.contentMode = self.layout.chatMessage.contentMode;
        
        UIImage *image = [UIImage imageWithContentsOfFile:self.layout.chatMessage.imageObject.thumbPath];
        if(image){
            self.mImgView.image = image;
        }else{
            cout(@"222");
            [[NIMSDK sharedSDK].resourceManager download:self.layout.chatMessage.imageObject.thumbUrl filepath:self.layout.chatMessage.imageObject.thumbPath progress:nil completion:^(NSError *error) {
                if (!error) {
                    UIImage *image = [UIImage imageWithContentsOfFile:self.layout.chatMessage.imageObject.thumbPath];
                    self.mImgView.image = image;
                }
            }];
        }
    }
    
    //gif图片
    else{
        self.mImgView.frame = self.mBackImgButton.bounds;
        self.mImgView.contentMode = self.layout.chatMessage.contentMode;
        self.mImgView.animationImages = self.layout.chatMessage.imageArr;
        self.mImgView.animationDuration = self.layout.chatMessage.imageArr.count * 0.1;
        [self.mImgView startAnimating];
    }
    
    //给图片设置一个描边 描边跟背景按钮的气泡图片一样
    UIImageView *btnImgView = [[UIImageView alloc]initWithImage:image];
    btnImgView.frame = CGRectInset(self.mImgView.frame, 0.0f, 0.0f);
    self.mImgView.layer.mask = btnImgView.layer;
    
    
    [self setMessageReadStatus];
    [self setNameWithTeam];
}


//点击展开图片
-(void)buttonPressed:(UIButton *)sender{
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatImageVideoCellClick:layout:)]){
        [self.delegate SSChatImageVideoCellClick:self.indexPath layout:self.layout];
    }
}

@end
