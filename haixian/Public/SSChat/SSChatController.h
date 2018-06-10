//
//  SSChatController.h
//  haixian
//
//  Created by soldoros on 2017/10/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "BaseController.h"
#import "SSChatBottom.h"
#import "SSChatModelLayout.h"
#import "SSChatDatas.h"
#import "SSChatBaseCell.h"




@interface SSChatController : BaseController

-(void)tableReloadData;

@property(nonatomic,strong)NSDictionary *goodsDic;

//键盘弹起的高度 耗时
@property (assign, nonatomic) CGFloat cHeight;
@property (assign, nonatomic) CGFloat cTime;

//聊天对象
@property (strong, nonatomic) NSString *userName;
//聊天类型
@property (assign, nonatomic) SSChatConversationType conversationType;


//输入框 多功能视图
@property (strong, nonatomic) SSChatBottom        *mBottomView;
@property (strong, nonatomic) SSChatKeyBordView   *mKeyBordView;

//显示表情试图 多功能视图
-(void)addSSChatKeyBordView;
//隐藏表情视图 多功能视图
-(void)deleteSSChatKeyBordView;


@end
