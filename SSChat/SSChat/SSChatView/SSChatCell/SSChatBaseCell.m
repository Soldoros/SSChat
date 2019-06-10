//
//  SSChatBaseCell.m
//  SSChatView
//
//  Created by soldoros on 2018/10/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatBaseCell.h"

@implementation SSChatBaseCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        // Remove touch delay for iOS 7
        for (UIView *view in self.subviews) {
            if([view isKindOfClass:[UIScrollView class]]) {
                ((UIScrollView *)view).delaysContentTouches = NO;
                break;
            }
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = SSChatCellColor;
        self.contentView.backgroundColor = SSChatCellColor;
        [self initSSChatCellUserInterface];
    }
    return self;
}


-(void)initSSChatCellUserInterface{
    
    // 2、创建头像
    _mHeaderImgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _mHeaderImgBtn.backgroundColor =  [UIColor brownColor];
    _mHeaderImgBtn.tag = 10;
    _mHeaderImgBtn.userInteractionEnabled = YES;
    [self.contentView addSubview:_mHeaderImgBtn];
    _mHeaderImgBtn.clipsToBounds = YES;
    [_mHeaderImgBtn setImage:[UIImage imageNamed:@"user_avatar_blue"] forState:UIControlStateNormal];
    [_mHeaderImgBtn addTarget:self action:@selector(headerButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    _mFriendLab = [UILabel new];
    _mFriendLab.bounds = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:_mFriendLab];
    _mFriendLab.textAlignment = NSTextAlignmentCenter;
    _mFriendLab.font = [UIFont systemFontOfSize:12];
    _mFriendLab.textColor = [UIColor grayColor];

    //创建时间
    _mMessageTimeLab = [UILabel new];
    _mMessageTimeLab.bounds = CGRectMake(0, 0, SSChatTimeWidth, SSChatTimeHeight);
    _mMessageTimeLab.top = SSChatTimeTop;
    _mMessageTimeLab.centerX = SCREEN_Width*0.5;
    [self.contentView addSubview:_mMessageTimeLab];
    _mMessageTimeLab.textAlignment = NSTextAlignmentCenter;
    _mMessageTimeLab.font = [UIFont systemFontOfSize:SSChatTimeFont];
    _mMessageTimeLab.textColor = [UIColor whiteColor];
    _mMessageTimeLab.backgroundColor = makeColorRgb(220, 220, 220);
    _mMessageTimeLab.clipsToBounds = YES;
    _mMessageTimeLab.layer.cornerRadius = 3;
    
    
    //背景按钮
    _mBackImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mBackImgButton.backgroundColor =  [SSChatCellColor colorWithAlphaComponent:0.4];
    _mBackImgButton.tag = 50;
    [self.contentView addSubview:_mBackImgButton];
    [_mBackImgButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    

    _mReadLab = [UILabel new];
    _mReadLab.bounds = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:_mReadLab];
    _mReadLab.textAlignment = NSTextAlignmentCenter;
    _mReadLab.font = [UIFont systemFontOfSize:12];
    _mReadLab.textColor = TitleColor;
    
}


-(BOOL)canBecomeFirstResponder{
    return YES;
}


-(void)setLayout:(SSChatMessagelLayout *)layout{
    _layout = layout;
    
    _mMessageTimeLab.hidden = !layout.chatMessage.showTime;
    _mMessageTimeLab.text = layout.chatMessage.messageTime;
    _mMessageTimeLab.frame = layout.timeLabRect;
    
    self.mHeaderImgBtn.frame = layout.headerImgRect;
    self.mHeaderImgBtn.layer.cornerRadius = self.mHeaderImgBtn.height*0.5;
    
    [self.mHeaderImgBtn setBackgroundImage:[UIImage imageNamed:@"touxaing2"] forState:UIControlStateNormal];
    
    if(_layout.chatMessage.messageFrom == SSChatMessageFromOther){
        [self.mHeaderImgBtn setBackgroundImage:[UIImage imageNamed:@"touxiang1"] forState:UIControlStateNormal];
    }
    NSString *uid = self.layout.chatMessage.message.from;
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:uid];
    NSString *avatarUrl = user.userInfo.avatarUrl;
    if(avatarUrl == nil)avatarUrl = @"";
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        [self.mHeaderImgBtn setImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal options:YYWebImageOptionProgressive];
    }];
   
}

//头像10
-(void)headerButtonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatHeaderImgCellClick:indexPath:)]){
        [_delegate SSChatHeaderImgCellClick:self.layout indexPath:self.indexPath];
    }
}

//消息按钮50
-(void)buttonPressed:(UIButton *)sender{
   
}

//群组消息显示名字
-(void)setNameWithTeam{
    
    if(_layout.chatMessage.message.session.sessionType == NIMSessionTypeTeam){
        if(_layout.chatMessage.messageFrom == SSChatMessageFromOther){
            _mFriendLab.hidden = NO;
            NSString *userId = _layout.chatMessage.message.session.sessionId;
            NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:userId];
            _mFriendLab.text = [PBData getUserNameWithUser:user];
            [_mFriendLab sizeToFit];
            _mFriendLab.bottom = _mBackImgButton.top - 5;
            _mFriendLab.left = _mHeaderImgBtn.right + 17;
        }else{
            _mFriendLab.hidden = YES;
        }
    }else{
        _mFriendLab.hidden = YES;
    }
}

//设置已读未读
-(void)setMessageReadStatus{
    
    if(_layout.chatMessage.messageFrom != SSChatMessageFromMe){
        
        _mReadLab.hidden = YES;
    }else{
        
        if(_layout.chatMessage.message.session.sessionType == NIMSessionTypeP2P){
            
            if(_layout.chatMessage.message.isRemoteRead){
                _mReadLab.text = @"已读";
                _mReadLab.textColor = [UIColor lightGrayColor];
            } else{
                _mReadLab.text = @"未读";
                _mReadLab.textColor = TitleColor;
            }
            _mReadLab.hidden = NO;
            [_mReadLab sizeToFit];
            _mReadLab.top = _mBackImgButton.bottom + 10;
            _mReadLab.right = _mBackImgButton.right - SSChatAirLRS;
        }
        
        else{
            
            __weak typeof(SSChatBaseCell *) weakSelf = self;
            [[NIMSDK sharedSDK].chatManager queryMessageReceiptDetail:_layout.chatMessage.message completion:^(NSError * _Nullable error, NIMTeamMessageReceiptDetail * _Nullable detail) {
                
                NSInteger count = detail.unreadUserIds.count;
                if(count == 0){
                    weakSelf.mReadLab.text = @"全部已读";
                    weakSelf.mReadLab.textColor = [UIColor lightGrayColor];
                }else{
                    weakSelf.mReadLab.text = makeMoreStr(makeStrWithInt(count),@"人未读",nil);
                    weakSelf.mReadLab.textColor = TitleColor;
                }
                weakSelf.mReadLab.hidden = NO;
                [weakSelf.mReadLab sizeToFit];
                weakSelf.mReadLab.top = weakSelf.mBackImgButton.bottom + 10;
                weakSelf.mReadLab.right = weakSelf.mBackImgButton.right - SSChatAirLRS;
            }];
         }
    }
}


@end
