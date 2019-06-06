//
//  ContactViews.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ContactViews.h"

@implementation ContactListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.centerY = ContactListCellH * 0.5;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [self.contentView addSubview:_mLeftImgView];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(16);
        
        _mRedLab = [UILabel new];
        _mRedLab.bounds = makeRect(0, 0, 30, 30);
        _mRedLab.textColor = [UIColor whiteColor];
        [self.contentView addSubview:_mRedLab];
        _mRedLab.font = makeFont(12);
        _mRedLab.backgroundColor = makeColorRgb(239, 70, 65);
        _mRedLab.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

//通讯录列表数据
-(void)setDataDic:(NSDictionary *)dataDic{
    
    _dataDic = dataDic;
    
    _mLeftImgView.image = [UIImage imageNamed:_dataDic[@"image"]];
    
    _mTitleLab.text = _dataDic[@"title"];
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
    
    _mRedLab.hidden = YES;
    
    if(_indexPath.section == 0 && _indexPath.row == 0){
        
        _mRedLab.hidden = NO;
      
        NSInteger count = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
        if(count==0)_mRedLab.hidden = YES;
        else _mRedLab.hidden = NO;
        _mRedLab.text = makeStrWithInt(count);
        [_mRedLab sizeToFit];
        _mRedLab.height += 4;
        _mRedLab.width  += 10;
        if(_mRedLab.width<_mRedLab.height){
            _mRedLab.width = _mRedLab.height;
        }
        _mRedLab.clipsToBounds = YES;
        _mRedLab.layer.cornerRadius = _mRedLab.height * 0.5;
        _mRedLab.right = SCREEN_Width - 20;
        _mRedLab.centerY = ContactListCellH * 0.5;
    }
    
}

//通讯列表数据
-(void)setUser:(NIMUser *)user{
    _user = user;
    
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:user.userInfo.avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        
        [self.mLeftImgView setImageWithURL:[NSURL URLWithString:urlString] placeholder:[UIImage imageNamed:@"user_avatar_blue"] options:YYWebImageOptionIgnoreAnimatedImage completion:nil];
    }];
    
    
    _mTitleLab.text = [PBData getUserNameWithUser:_user];
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
    
    _mRedLab.hidden = YES;
    
    if(_indexPath.section == 0 && _indexPath.row == 0){
        
        _mRedLab.hidden = NO;
        
        NSInteger count = 1;
        if(count==0)_mRedLab.hidden = YES;
        else _mRedLab.hidden = NO;
        _mRedLab.text = makeStrWithInt(count);
        [_mRedLab sizeToFit];
        _mRedLab.height += 4;
        _mRedLab.width  += 10;
        if(_mRedLab.width<_mRedLab.height){
            _mRedLab.width = _mRedLab.height;
        }
        _mRedLab.clipsToBounds = YES;
        _mRedLab.layer.cornerRadius = _mRedLab.height * 0.5;
        _mRedLab.right = SCREEN_Width - 20;
        _mRedLab.centerY = ContactListCellH * 0.5;
    }
}

//群组数据
- (void)setTeam:(NIMTeam *)team{
    
    _mRedLab.hidden = YES;
    
    [_mLeftImgView setImageWithURL:[NSURL URLWithString:team.avatarUrl] placeholder:[UIImage imageNamed:@"group_avatar"]];
    
    _mTitleLab.text = team.teamName;
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
}



@end




//选择联系人cell
@implementation ContactChoiceFriendsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryNone;
        self.tintColor = TitleColor;
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 30, 30);
        _mLeftImgView.left = 10;
        _mLeftImgView.centerY = ContactChoiceFriendsCellH * 0.5;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [self.contentView addSubview:_mLeftImgView];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(14);
        
    }
    return self;
}

-(void)setUser:(NIMUser *)user{
    _user = user;
    
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:user.userInfo.avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        
        [self.mLeftImgView setImageWithURL:[NSURL URLWithString:urlString] placeholder:[UIImage imageNamed:@"user_avatar_blue"] options:YYWebImageOptionIgnoreAnimatedImage completion:nil];
    }];
    
    _mTitleLab.text = [PBData getUserNameWithUser:user];
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
}


@end





//好友申请列表cell

@implementation ContactFriendRequestsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
        
        _mTimeLab = [UILabel new];
        _mTimeLab.frame = makeRect(0, 0, SCREEN_Width, 45);
        _mTimeLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_mTimeLab];
        _mTimeLab.font = makeFont(14);
        _mTimeLab.textColor = [UIColor lightGrayColor];
        
        
        _mBackView = [UIView new];
        _mBackView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_mBackView];
        _mBackView.clipsToBounds = YES;
        _mBackView.layer.cornerRadius = 5;
        _mBackView.frame = makeRect(15, 45, SCREEN_Width-30, ContactFriendRequestsCellH - 45);
        
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.top = 10;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [_mBackView addSubview:_mLeftImgView];
        
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [_mBackView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(14);
        
        _mMessageLab = [UILabel new];
        _mMessageLab.bounds = makeRect(0, 0, 100, 30);
        _mMessageLab.textColor = [UIColor lightGrayColor];
        [_mBackView addSubview:_mMessageLab];
        _mMessageLab.font = makeFont(12);
      
        
        _mLine1 = [UIView new];
        _mLine1.bounds = makeRect(0, 0, _mBackView.width, 1);
        _mLine1.left = 0;
        _mLine1.bottom = _mBackView.height - 45;
        _mLine1.backgroundColor = BackGroundColor;
        [_mBackView addSubview:_mLine1];
        
        
        _mLine2 = [UIView new];
        _mLine2.bounds = makeRect(0, 0, 1, 45);
        _mLine2.centerX = _mBackView.width * 0.5;
        _mLine2.bottom = _mBackView.height;
        _mLine2.backgroundColor = BackGroundColor;
        [_mBackView addSubview:_mLine2];
        
        
        _mButton1 = [UIButton buttonWithType:UIButtonTypeSystem];
        _mButton1.bounds = makeRect(0, 0, _mBackView.width * 0.5, 45);
        _mButton1.left = 0;
        _mButton1.bottom = _mBackView.height;
        _mButton1.tag = 50;
        [_mButton1 setTitle:@"拒绝" forState:UIControlStateNormal];
        [_mButton1 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_mButton1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_mBackView addSubview:_mButton1];
        
        
        _mButton2 = [UIButton buttonWithType:UIButtonTypeSystem];
        _mButton2.bounds = makeRect(0, 0, _mBackView.width * 0.5, 45);
        _mButton2.left = _mBackView.width * 0.5;
        _mButton2.bottom = _mBackView.height;
        _mButton2.tag = 51;
        [_mButton2 setTitle:@"同意" forState:UIControlStateNormal];
        [_mButton2 setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mButton2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_mBackView addSubview:_mButton2];
        
        
        _mBottomLab = [UILabel new];
        _mBottomLab.bounds = makeRect(0, 0, _mBackView.width, 45);
        _mBottomLab.bottom = _mBackView.height;
        _mBottomLab.left = 0;
        _mBottomLab.textColor = [UIColor lightGrayColor];
        [_mBackView addSubview:_mBottomLab];
        _mBottomLab.font = makeFont(16);
        _mBottomLab.backgroundColor = [UIColor clearColor];
        _mBottomLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}


//拒绝50  同意51
-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(ContactFriendRequestsCellBtnClick:sender: )]){
        [_delegate ContactFriendRequestsCellBtnClick:_indexPath sender:sender];
    }
    
}


-(void)setNotification:(NIMSystemNotification *)notification{
    _notification = notification;
    
    _mLeftImgView.image = [UIImage imageNamed:@"user_avatar_blue"];
    
    _mTimeLab.text = makeStrWithInt(notification.timestamp);
    
    _mTitleLab.text = notification.sourceID;
    [_mTitleLab sizeToFit];
    _mTitleLab.left = _mLeftImgView.right + 10;
    _mTitleLab.top = _mLeftImgView.top ;
 
    _mBottomLab.hidden = NO;
    _mButton1.hidden = YES;
    _mButton2.hidden = YES;
    _mLine2.hidden = YES;
    
    switch (self.notification.handleStatus) {
        case SSNotificationAgreed:
            _mBottomLab.text = @"已同意";
            break;
        case SSNotificationDeclined:
            _mBottomLab.text = @"已拒绝";
            break;
        case SSNotificationExpired:
            _mBottomLab.text = @"已过期";
            break;
        default:
            [self setDetailWith:notification];
            break;
    }
    
}

-(void)setDetailWith:(NIMSystemNotification *)notification{
    
    _mBottomLab.text = @"友情提示";
    NSString *text = notification.postscript;
    if(text.length ==0 || text == nil){
        text = @"请求添加您为好友";
    }
    id object = self.notification.attachment;
    if ([object isKindOfClass:[NIMUserAddAttachment class]]) {
        NIMUserOperation operation = [(NIMUserAddAttachment *)object operationType];
        switch (operation) {
            case NIMUserOperationAdd:
                text = @"已添加你为好友";
                break;
            case NIMUserOperationRequest:
                _mBottomLab.hidden = YES;
                _mButton1.hidden = NO;
                _mButton2.hidden = NO;
                _mLine2.hidden = NO;
                break;
            case NIMUserOperationVerify:
                text = @"通过了你的好友请求";
                break;
            case NIMUserOperationReject:
                text = @"拒绝了你的好友请求";
                break;
            default:
                break;
        }
    }
    
    _mMessageLab.text = text;
    [_mMessageLab sizeToFit];
    _mMessageLab.left = _mLeftImgView.right + 10;
    _mMessageLab.bottom = _mLeftImgView.bottom ;
    
}



@end



//群组详情的成员cell
@implementation ContactTeamDetTopCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _mImgView = [UIImageView new];
        _mImgView.bounds = makeRect(0, 0, self.width - 25, self.width - 25);
        _mImgView.top = 5;
        _mImgView.centerX = self.width * 0.5;
        [self.contentView addSubview:_mImgView];
        _mImgView.clipsToBounds = YES;
        _mImgView.layer.cornerRadius = _mImgView.height * 0.5;
        
        _mNameLab = [UILabel new];
        [self.contentView addSubview:_mNameLab];
        _mNameLab.font = [UIFont systemFontOfSize:14];
        _mNameLab.textColor = [UIColor blackColor];
        _mNameLab.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

-(void)setMember:(NIMTeamMember *)member{
    
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:member.userId];
    
    NSString *avatarUrl = user.userInfo.avatarUrl;
    if(avatarUrl == nil)avatarUrl = @"";
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        UIImage *image = [UIImage imageNamed:@"user_avatar_blue"];
        [self.mImgView setImageWithURL:[NSURL URLWithString:urlString] placeholder:image options:YYWebImageOptionIgnoreAnimatedImage completion:nil];
    }];
    
    _mNameLab.text = [PBData getUserNameWithUser:user];
    [_mNameLab sizeToFit];
    if(_mNameLab.width > _mImgView.width){
        _mNameLab.width = _mImgView.width;
    }
    _mNameLab.centerX = self.width * 0.5;
    _mNameLab.top = _mImgView.bottom + 5;
    
}

@end 


//群组详情的其他cell
@implementation ContactTeamDetOtherCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _mTitleLab = [UILabel new];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = [UIFont systemFontOfSize:16];
        _mTitleLab.textColor = [UIColor blackColor];
        _mTitleLab.textAlignment = NSTextAlignmentLeft;
        _mTitleLab.frame = makeRect(15, 0, 200, ContactTeamDetOtherCellH);
        
        _mDetaillab = [UILabel new];
        [self.contentView addSubview:_mDetaillab];
        _mDetaillab.font = [UIFont systemFontOfSize:14];
        _mDetaillab.textColor = [UIColor grayColor];
        _mDetaillab.textAlignment = NSTextAlignmentRight;
        _mDetaillab.bounds = makeRect(0, 0, 200, ContactTeamDetOtherCellH);
        _mDetaillab.top = 0;
        _mDetaillab.right = SCREEN_Width - 15;
        
        _mSwitch = [UISwitch new];
        _mSwitch.right = SCREEN_Width - 15;
        _mSwitch.centerY = ContactTeamDetOtherCellH * 0.5;
        [self.contentView addSubview:_mSwitch];
        [_mSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
        
    }
    return self;
}

//消息提醒0  聊天置顶1
-(void)valueChanged:(UISwitch *)sender{
    
    if(_indexPath.row == 0){
        
        NIMTeamNotifyState state = sender.on?NIMTeamNotifyStateAll:NIMTeamNotifyStateNone;
        
        [[NIMSDK sharedSDK].teamManager updateNotifyState:state inTeam:_team.teamId completion:^(NSError * _Nullable error) {
            if (error) {
                [[self viewController].view showTimeBlack:@"设置消息提醒失败"];
            }else{
                [[self viewController].view showTimeBlack:@"设置消息提醒成功"];
            }
        }];
    }
    
    else if(_indexPath.row == 1){
        NSDictionary *dic = @{@"NTESRecentSessionTopMark":@(sender.on)};
        NIMSession *session = [NIMSession session:_team.teamId type:NIMSessionTypeTeam];
        NIMRecentSession *recent = [[NIMSDK sharedSDK].conversationManager recentSessionBySession:session];
        [[NIMSDK sharedSDK].conversationManager updateRecentLocalExt:dic recentSession:recent];
    }
}

//普通群数据
-(void)setTeamData:(NIMTeam *)team{
    _team = team;
    
    _mSwitch.hidden = YES;
    if(_indexPath.section == 1){
        if(_indexPath.row == 0){
            _mTitleLab.text = @"群主";
            _mDetaillab.text = _team.owner;
        }else{
            _mTitleLab.text = @"群名称";
            _mDetaillab.text = _team.teamName;
        }
    }
    else if(_indexPath.section == 2){
        if(_indexPath.row == 0){
            _mTitleLab.text = @"群介绍";
            _mDetaillab.text = _team.intro?_team.intro:@"暂无";
        }else{
            _mTitleLab.text = @"群公告";
            _mDetaillab.text = _team.announcement?_team.announcement:@"暂无";
        }
    }
    else{
        if(_indexPath.row == 0){
            _mSwitch.hidden = NO;
            _mTitleLab.text = @"消息提醒";
            _mDetaillab.text = @"";
        }else{
            _mSwitch.hidden = NO;
            _mTitleLab.text = @"聊天置顶";
            _mDetaillab.text = @"";
        }
    }
}

//高级群数据
-(void)setSeniorTeamData:(NIMTeam *)team{
    _team = team;
    
    _mSwitch.hidden = YES;
    if(_indexPath.section == 1){
        if(_indexPath.row == 0){
            _mTitleLab.text = @"群主";
            _mDetaillab.text = _team.owner;
        }else{
            _mTitleLab.text = @"群名称";
            _mDetaillab.text = _team.teamName;
        }
    }
    else if(_indexPath.section == 2){
        if(_indexPath.row == 0){
            _mTitleLab.text = @"群介绍";
            _mDetaillab.text = _team.intro?_team.intro:@"暂无";
        }else{
            _mTitleLab.text = @"群公告";
            _mDetaillab.text = _team.announcement?_team.announcement:@"暂无";
        }
    }
    else{
        if(_indexPath.row == 0){
            _mSwitch.hidden = NO;
            _mTitleLab.text = @"消息提醒";
            _mDetaillab.text = @"";
        }else{
            _mSwitch.hidden = NO;
            _mTitleLab.text = @"聊天置顶";
            _mDetaillab.text = @"";
        }
    }
}

@end




//群组详情的功能cell 清空消息 退出群组
@implementation ContactTeamDetBottomCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _mButton.frame = makeRect(0, 0, SCREEN_Width, ContactTeamDetBottomCellH);
        _mButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_mButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_mButton];
    }
    return self;
}

//清空聊天0  删除退出1
-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(ContactTeamDetBottomCellBtnClick:sender:)]){
        [_delegate ContactTeamDetBottomCellBtnClick:_indexPath sender:sender];
    }
}

//讨论组数据
-(void)setTeamData:(NIMTeam *)team{
    _team = team;
    
    if(_indexPath.row == 0){
        [_mButton setTitleColor:makeColorRgb(62, 110, 181) forState:UIControlStateNormal];
        [_mButton setTitle:@"清空聊天记录" forState:UIControlStateNormal];
    }else{
        [_mButton setTitleColor:makeColorRgb(195, 45, 50) forState:UIControlStateNormal];
        [_mButton setTitle:@"删除并退出" forState:UIControlStateNormal];
    }
}

//高级群数据
-(void)setSeniorTeamData:(NIMTeam *)team{
    _team = team;
    
    if(_indexPath.row == 0){
        [_mButton setTitleColor:makeColorRgb(62, 110, 181) forState:UIControlStateNormal];
        [_mButton setTitle:@"清空聊天记录" forState:UIControlStateNormal];
    }else{
        [_mButton setTitleColor:makeColorRgb(195, 45, 50) forState:UIControlStateNormal];
        [_mButton setTitle:@"解散该群" forState:UIControlStateNormal];
    }
}


@end


//好友详情cell
@implementation ContactFriendsDetOtherCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:UITableViewCellStyleValue1
       reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textColor = [UIColor blackColor];
        
        
        _mSwitch = [UISwitch new];
        _mSwitch.right = SCREEN_Width - 15;
        _mSwitch.centerY = ContactFriendsDetOtherCellH * 0.5;
        [self.contentView addSubview:_mSwitch];
        [_mSwitch addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
        
    }
    return self;
}

//置顶聊天0 消息提醒1  黑名单2
-(void)valueChanged:(UISwitch *)sender{
    
    if(_indexPath.row == 0){
        NSDictionary *dic = @{@"NTESRecentSessionTopMark":@(sender.on)};
        NIMSession *session = [NIMSession session:_user.userId type:NIMSessionTypeP2P];
        NIMRecentSession *recent = [[NIMSDK sharedSDK].conversationManager recentSessionBySession:session];
        [[NIMSDK sharedSDK].conversationManager updateRecentLocalExt:dic recentSession:recent];
    }
    else if(_indexPath.row == 1){
        [[NIMSDK sharedSDK].userManager updateNotifyState:sender.on forUser:_user.userId completion:^(NSError *error) {
            if (error) {
                 [[self viewController].view showTimeBlack:@"设置消息提醒失败"];
            }else{
                [[self viewController].view showTimeBlack:@"设置消息提醒成功"];
            }
        }];
    }else{
        //加入黑名单
        if(sender.on){
            [[NIMSDK sharedSDK].userManager addToBlackList:_user.userId completion:^(NSError *error) {
                
                if (!error) {
                    [[self viewController].view showTimeBlack:@"加入了黑名单"];
                }else{
                    [[self viewController].view showTimeBlack:@"加入黑名单失败"];
                }
            }];
        }
        //移除黑名单
        else{
            
            [[NIMSDK sharedSDK].userManager removeFromBlackBlackList:_user.userId completion:^(NSError *error) {
                if (!error) {
                    [[self viewController].view showTimeBlack:@"移除黑名单成功"];
                }else{
                    [[self viewController].view showTimeBlack:@"移除黑名单失败"];
                }
            }];
        }
    }
}

//头像  备注 (昵称 签名 电话)  (置顶聊天 消息提醒  拉黑)  (聊天 删除)
-(void)setUser:(NIMUser *)user{
    _user = user;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    _mSwitch.hidden = YES;
    self.detailTextLabel.hidden = NO;
    if(_indexPath.section == 1){
        self.textLabel.text = @"备注";
        self.detailTextLabel.text = _user.alias;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else if(_indexPath.section == 2){
        if(_indexPath.row == 0){
            self.textLabel.text = @"昵称";
            self.detailTextLabel.text = user.userInfo.nickName?user.userInfo.nickName:@"暂无";
        }
        else if(_indexPath.row == 1){
            self.textLabel.text = @"签名";
            self.detailTextLabel.text = user.userInfo.sign?user.userInfo.sign:@"暂无";
        }else{
            self.textLabel.text = @"电话";
            self.detailTextLabel.text = user.userInfo.mobile?user.userInfo.mobile:@"暂无";
        }
    }
    else{
        _mSwitch.hidden = NO;
        self.detailTextLabel.hidden = YES;
        
        if(_indexPath.row == 0){
            self.textLabel.text = @"置顶聊天";
            if(_user.notifyForNewMsg){
                _mSwitch.on = YES;
            }else{
                _mSwitch.on = NO;
            }
        }
        else if(_indexPath.row == 1){
            self.textLabel.text = @"消息提醒";
            if(_user.notifyForNewMsg){
                _mSwitch.on = YES;
            }else{
                _mSwitch.on = NO;
            }
        }
        else{
            self.textLabel.text = @"黑名单";
            if(_user.isInMyBlackList){
                _mSwitch.on = YES;
            }else{
                _mSwitch.on = NO;
            }
        }
    }
}


@end



//好友详情的功能cell 会话 删除
@implementation ContactFriendsDetBottomCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self = [super initWithStyle:UITableViewCellStyleDefault
                   reuseIdentifier:reuseIdentifier]){
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        
        self.textLabel.font = [UIFont systemFontOfSize:16];
        self.textLabel.textColor = [UIColor redColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

//群组数据
-(void)setUser:(NIMUser *)user{
    _user = user;
    
    BOOL isMyFriend = [[NIMSDK sharedSDK].userManager isMyFriend:_user.userId];
    
    if(_indexPath.row == 0){
        self.textLabel.text = @"发送消息";
        self.textLabel.textColor = makeColorRgb(62, 110, 181);
    }else{
        self.textLabel.textColor = makeColorRgb(195, 45, 50);
        if(isMyFriend){
            self.textLabel.text = @"删除好友";
        }else{
            self.textLabel.text = @"添加好友";
        }
    }
}


@end
