//
//  ConversationController.m
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ConversationController.h"
#import "ConversationViews.h"
#import "SSChatController.h"
#import "PBSearchView.h"
#import "PBSearchController.h"

@interface ConversationController ()<NIMConversationManagerDelegate,NIMChatManagerDelegate,PBSearchViewsDelegate>

@property(nonatomic,strong)PBSearchTableHeader *tableHeader;

@end

@implementation ConversationController

-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if(self = [super initWithRoot:root title:title]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"Hello"];
    
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    [[NIMSDK sharedSDK].chatManager addDelegate:self];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    self.mTableView.backgroundColor = [UIColor whiteColor];
    self.mTableView.backgroundView.backgroundColor = [UIColor whiteColor];
    [self.mTableView registerClass:@"ConversationListCell" andCellId:ConversationListCellId];
    
    _tableHeader = [[PBSearchTableHeader alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, PBSearchTableHeaderH) placeholder:@"搜索"];
    _tableHeader.delegate = self;
    self.mTableView.tableHeaderView = _tableHeader;
 
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    [self.mTableView.mj_header beginRefreshing];
}

-(void)netWorking{

    self.datas = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self.mTableView.mj_header endRefreshing];
    [self.mTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ConversationListCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConversationListCell *cell = [tableView dequeueReusableCellWithIdentifier:ConversationListCellId];
    cell.indexPath = indexPath;
    cell.recentSession = self.datas[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NIMRecentSession *recentSession = self.datas[indexPath.row];
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.session = recentSession.session;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

#pragma arguments PBSearchViewsDelegate
-(void)PBSearchTableHeaderBtnClick:(UIButton *)sender{
    PBSearchController *vc = [PBSearchController new];
    vc.FirstResponder = YES;
    vc.searchType = PBSearchAllType2;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark NIMConversationManagerDelegate
//新增会话
-(void)didAddRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    [self.datas addObject:recentSession];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//更新会话
-(void)didUpdateRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    
    for (NIMRecentSession *recent in self.datas){
        if ([recentSession.session.sessionId isEqualToString:recent.session.sessionId]){
            [self.datas removeObject:recent];
            break;
        }
    }
    [self.datas insertObject:recentSession atIndex:0];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//删除会话
-(void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    
    NSInteger index = [self.datas indexOfObject:recentSession];
    [self.datas removeObjectAtIndex:index];
    [[NIMSDK sharedSDK].conversationManager deleteRemoteSessions:@[recentSession.session] completion:nil];
    
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//删除消息
-(void)messagesDeletedInSession:(NIMSession *)session{
    self.datas = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//所有消息删除
-(void)allMessagesDeleted{
    self.datas = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}

//所有会话已读
-(void)allMessagesRead{
    self.datas = [[NIMSDK sharedSDK].conversationManager.allRecentSessions mutableCopy];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}



#pragma mark NIMChatManagerDelegate
-(void)onRecvMessageReceipts:(NSArray<NIMMessageReceipt *> *)receipts{
    [self.mTableView reloadData];
}


@end
