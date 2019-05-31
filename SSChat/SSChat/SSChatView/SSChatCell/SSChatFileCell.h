//
//  SSChatFileCell.h
//  SSChat
//
//  Created by soldoros on 2019/5/28.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"



@interface SSChatFileCell : SSChatBaseCell


@property(nonatomic,strong) UIImageView *mBackImgView;
@property(nonatomic,strong) UIImageView *mFileImgView;
@property(nonatomic,strong) UILabel     *mTitleLab;
@property(nonatomic,strong) UILabel     *mSizeLab;

@property(nonatomic,strong) UISlider    *mSlider;

@property(nonatomic,strong) UIButton    *mFileButton;

@end


