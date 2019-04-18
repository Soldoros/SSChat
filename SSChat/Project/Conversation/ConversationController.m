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

@interface ConversationController ()

@end

@implementation ConversationController

-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if(self = [super initWithRoot:root title:title]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

//刷新界面
-(void)registerNoti{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChange) name:NotiMessageChange object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChange) name:NotiReceiveMessages object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(messageChange) name:NotiContactChange object:nil];
}

-(void)messageChange{
    [self.datas removeAllObjects];
    [self netWorking];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNoti];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"Hello"];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    [self.mTableView registerClass:@"ConversationListCell" andCellId:ConversationListCellId];
    
    [self netWorking];
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
}

-(void)netWorking{
    
    NSArray *conversations = [[EMClient sharedClient].chatManager getAllConversations];
    [self.datas addObjectsFromArray:conversations];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    
    NSInteger count = 0;
    for(int i=0;i<self.datas.count;++i){
        EMConversation *conv = conversations[i];
        count += conv.unreadMessagesCount;
    }
    if(count>0){
        self.tabBarItem.badgeValue = makeStrWithInt(count);
        [UIApplication sharedApplication].applicationIconBadgeNumber = count;
    }else{
        self.tabBarItem.badgeValue = nil;
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    }
    
    [self.mTableView.mj_header endRefreshing];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ConversationListCell *cell = [tableView dequeueReusableCellWithIdentifier:ConversationListCellId];
    cell.indexPath = indexPath;
    cell.conversation = self.datas[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    EMConversation *conversation = self.datas[indexPath.row];
    
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.chatType = SSChatConversationTypeChat;
    vc.sessionId = conversation.conversationId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EMConversation *conversation = [self.datas objectAtIndex:indexPath.row];
        [[EMClient sharedClient].chatManager deleteConversation:conversation.conversationId isDeleteMessages:YES completion:nil];
        [self.datas removeObjectAtIndex:indexPath.row];
        [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



@end
