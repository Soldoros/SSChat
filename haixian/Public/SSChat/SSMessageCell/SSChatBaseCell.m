//
//  SSChatBaseCell.m
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "SSChatBaseCell.h"



@implementation SSChatBaseCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = SSChatCellColor;
        self.contentView.backgroundColor = SSChatCellColor;
        [self initSSChatCellUserInterface];
    }
    return self;
}


-(void)initSSChatCellUserInterface{

    
    // 2、创建头像
    self.mHeaderImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.mHeaderImgBtn.backgroundColor =  [SSChatCellColor colorWithAlphaComponent:0.4];
    self.mHeaderImgBtn.tag = 100;
    self.mHeaderImgBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:self.mHeaderImgBtn];
    self.mHeaderImgBtn.clipsToBounds = YES;
    [self.mHeaderImgBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建时间
    _mMsgTimeLab = [UILabel new];
    _mMsgTimeLab.bounds = makeRect(0, 0, SSChatTimeWidth, SSChatTimeHeight);
    _mMsgTimeLab.top = SSChatTimeTop;
    _mMsgTimeLab.centerX = SCREEN_Width*0.5;
    [self.contentView addSubview:_mMsgTimeLab];
    _mMsgTimeLab.textAlignment = NSTextAlignmentCenter;
    _mMsgTimeLab.font = makeFont(SSChatTimeFont);
    _mMsgTimeLab.textColor = [UIColor whiteColor];
    _mMsgTimeLab.backgroundColor = makeColorRgb(210, 210, 210);
    _mMsgTimeLab.clipsToBounds = YES;
    _mMsgTimeLab.layer.cornerRadius = 3;
    
    [self becomeFirstResponder];
    _menu = [UIMenuController sharedMenuController];
    [_menu setTargetRect:self.mMsgTimeLab.frame inView:self.mMsgTimeLab.superview];
    [_menu setMenuVisible:YES animated:YES];
    [_menu setMenuVisible:NO animated:YES];
}

-(BOOL)canBecomeFirstResponder{
    return YES;
}


-(void)setLayout:(SSChatModelLayout *)layout{
    _layout = layout;
    
    if(layout.model.showTime==YES){
        _mMsgTimeLab.hidden = NO;
        _mMsgTimeLab.text = [NSTimer getChatTimeStr:layout.model.messageTime];
        [_mMsgTimeLab sizeToFit];
        _mMsgTimeLab.width += 20;
        _mMsgTimeLab.height += 6;
        _mMsgTimeLab.top = SSChatTimeTop;
        _mMsgTimeLab.centerX = SCREEN_Width*0.5;
    }else{
        _mMsgTimeLab.hidden = YES;
    }
    
    if(layout.model.messageFrom == SSChatMessageFromMe){
        self.mHeaderImgBtn.frame = layout.headerImgRect;
        [self.mHeaderImgBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxi_liaotian_touxiang2"] forState:UIControlStateNormal];
//        [self.mHeaderImgBtn setBackgroundImageWithURL:[NSURL URLWithString:layout.model.headerImgurl] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"xiaoxi_liaotian_touxiang2"]];
    }
    
    if(layout.model.messageFrom == SSChatMessageFromOther){
        self.mHeaderImgBtn.frame = layout.headerImgRect;
        [self.mHeaderImgBtn setBackgroundImage:[UIImage imageNamed:@"xiaoxi_liaotian_touxiang1"] forState:UIControlStateNormal];
//        [self.mHeaderImgBtn setBackgroundImageWithURL:[NSURL URLWithString:@""] forState:UIControlStateNormal placeholder:layout.model.headerImg];
    }
    self.mHeaderImgBtn.layer.cornerRadius = self.mHeaderImgBtn.height*0.5;
}


//消息按钮
-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatBaseCellImgBtnClick:indexPath:)]){
        [_delegate SSChatBaseCellImgBtnClick:sender.tag indexPath:self.indexPath];
    }
}






@end
