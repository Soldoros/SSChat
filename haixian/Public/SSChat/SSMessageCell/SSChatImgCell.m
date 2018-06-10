//
//  SSChatImgCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatImgCell.h"

@implementation SSChatImgCell

-(void)initSSChatCellUserInterface{
    
    [super initSSChatCellUserInterface];
    
    self.mImgBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    self.mImgBtn.userInteractionEnabled = YES;
    self.mImgBtn.tag = 10;
    [self.contentView addSubview:self.mImgBtn];
    [_mImgBtn addTarget:self action:@selector(buttonPressedIn:) forControlEvents:UIControlEventTouchUpInside];
    [_mImgBtn addTarget:self action:@selector(buttonPressedDown:) forControlEvents:UIControlEventTouchDown];

    
    
    _mImgView = [UIImageView new];
    _mImgView.userInteractionEnabled = YES;
    _mImgView.layer.cornerRadius = 5;
    _mImgView.layer.masksToBounds  = YES;
    _mImgView.contentMode = UIViewContentModeScaleAspectFill;
    _mImgView.backgroundColor = [UIColor whiteColor];
    [_mImgBtn addSubview:_mImgView];
    _mImgView.userInteractionEnabled = YES;
    
}


-(void)setLayout:(SSChatModelLayout *)layout{
    
    [super setLayout:layout];
    
    self.mImgBtn.frame = layout.btnRect;
    [self.mImgBtn setBackgroundImage:layout.btnImage forState:UIControlStateNormal];
    [self.mImgBtn setBackgroundImage:layout.btnImage forState:UIControlStateHighlighted];

    _mImgView.frame = _mImgBtn.bounds;
    [_mImgView sd_setImageWithURL:[NSURL  URLWithString:layout.model.imageUrl] placeholderImage:nil];
    [self makeMaskView:_mImgView withImage:layout.btnImage];
    
}


- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}

//点击图片回调
-(void)buttonPressedIn:(UIButton *)sender{
   
    
}

//长按图片回调
-(void)buttonPressedDown:(UIButton *)sender{
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(SSChatBaseCellBtnClick:index:messageType:)]){
        [self.delegate SSChatBaseCellBtnClick:self.indexPath index:sender.tag messageType:SSChatMessageTypeImage];
    }
}


@end
