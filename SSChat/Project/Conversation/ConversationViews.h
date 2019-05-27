//
//  ConversationViews.h
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatDatas.h"
#import "SSChatMessage.h"


#define ConversationListCellId  @"ConversationListCellId"
#define ConversationListCellH   70

@interface ConversationListCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NIMRecentSession *recentSession;


@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mDetailLab;

@property(nonatomic,strong)UILabel *mTimeLab;
//红色数字提示
@property(nonatomic,strong)UILabel *mRedLab;

@end

