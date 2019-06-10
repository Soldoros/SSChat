//
//  SSChatFileCell.m
//  SSChat
//
//  Created by soldoros on 2019/5/28.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSChatFileCell.h"

@implementation SSChatFileCell

-(void)initSSChatCellUserInterface{
    [super initSSChatCellUserInterface];
    
    self.mBackImgView = [UIImageView new];
    self.mBackImgView.image = [UIImage imageFromColor:[UIColor whiteColor]];
    [self.mBackImgButton addSubview:self.mBackImgView];
    
    _mFileImgView = [UIImageView new];
    _mFileImgView.image = [UIImage imageNamed:@"icon_file"];
    [self.mBackImgButton addSubview:_mFileImgView];
    _mFileImgView.userInteractionEnabled = YES;
    
    _mTitleLab = [UILabel new];
    [self.mBackImgButton addSubview:_mTitleLab];
    _mTitleLab.font = [UIFont systemFontOfSize:16];
    _mTitleLab.textColor = [UIColor blackColor];
    _mTitleLab.userInteractionEnabled = YES;
    
    _mSizeLab = [UILabel new];
    [self.mBackImgButton addSubview:_mSizeLab];
    _mSizeLab.font = [UIFont systemFontOfSize:14];
    _mSizeLab.textColor = [UIColor lightGrayColor];
    _mSizeLab.userInteractionEnabled = YES;
    
    _mFileButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.mBackImgButton addSubview:_mFileButton];
    [_mFileButton addTarget:self action:@selector(fileButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setLayout:(SSChatMessagelLayout *)layout{
    [super setLayout:layout];
    
    UIImage *image = [UIImage imageNamed:layout.chatMessage.backImgString];
    image = [image resizableImageWithCapInsets:layout.imageInsets resizingMode:UIImageResizingModeStretch];
    self.mBackImgButton.frame = layout.backImgButtonRect;
    [self.mBackImgButton setBackgroundImage:image forState:UIControlStateNormal];
    self.mBackImgView.frame = self.mBackImgButton.bounds;
    self.mBackImgView.contentMode = self.layout.chatMessage.contentMode;
    
    self.mFileImgView.frame = self.layout.fileImgRect;
    
    self.mTitleLab.text = self.layout.chatMessage.fileObject.displayName;
    self.mTitleLab.frame = self.layout.titleLabRect;
    
    self.mSizeLab.text = makeString(@(self.layout.chatMessage.fileObject.fileLength), @"KB");
    self.mSizeLab.frame = self.layout.sizeLabRect;
    
    //给背景视图设置一个描边 描边跟背景按钮的气泡图片一样
    UIImageView *btnImgView = [[UIImageView alloc]initWithImage:image];
    btnImgView.frame = CGRectInset(self.mBackImgView.frame, 0.0f, 0.0f);
    self.mBackImgView.layer.mask = btnImgView.layer;
    
    _mFileButton.frame = self.mBackImgButton.bounds;
    
    [self setMessageReadStatus];
    [self setNameWithTeam];
}


-(void)fileButtonPressed:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatFileCellClick:layout:)]){
        [self.delegate SSChatFileCellClick:self.indexPath layout:self.layout];
    }
}

@end
