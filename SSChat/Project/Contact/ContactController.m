//
//  ContactController.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ContactController.h"
#import "ContactViews.h"
#import "SSChatController.h"
#import "PBSearchController.h"
#import "ContactFriendRequestsController.h"


@interface ContactController ()

@end

@implementation ContactController

-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if(self = [super initWithRoot:root title:title]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

-(void)registerNoti{
   
    //好友添加/删除后的回调
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(contactChange) name:NotiContactChange object:nil];
    //未读通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotificationsUnreadCountUpdate:) name:NotiUnreadCount object:nil];
}


-(void)contactChange{
    [self.datas removeAllObjects];
    [self netWorking];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNoti];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"通讯录"];
    [self setRightOneBtnTitle:@"添加好友"];
    self.rightBtn1.width += 25;
    self.rightBtn1.right = self.navtionImgView.width-15;
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    self.mTableView.allowsSelectionDuringEditing = YES;
    [self.mTableView registerClass:@"ContactListCell" andCellId:ContactListCellId];
    [self.mTableView registerClass:@"UITableViewCell" andCellId:@"cellId"];
    
    [self netWorking];
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
}

-(void)netWorking{
    
    NSDictionary *dic1 = @{@"image":@"notification",@"title":@"好友申请"};
    NSDictionary *dic2 = @{@"image":@"group",@"title":@"我的群组"};
    NSDictionary *dic3 = @{@"image":@"contact",@"title":@"新建群组"};
    [self.datas addObjectsFromArray:@[@[dic1,dic2,dic3]]];
    
    self.mTableView.userInteractionEnabled = NO;
    [[EMClient sharedClient].contactManager getContactsFromServerWithCompletion:^(NSArray *aList, EMError *aError) {
        self.mTableView.userInteractionEnabled = YES;
        [self.mTableView.mj_header endRefreshing];
        if (!aError) {
            NSMutableArray *arr = [NSMutableArray new];
            for(NSString *str in aList){
                NSDictionary *dic = @{@"image":@"user_avatar_blue",@"title":str};
                [arr addObject:dic];
            }
            [self.datas addObject:arr];
            [self.mTableView reloadData];
        }
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0)return 15;
    else return 30;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(section == 1) return @"好友列表";
    else return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactListCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactListCellId];
    cell.indexPath = indexPath;
    cell.dataDic = self.datas[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0 && indexPath.row == 0){
        ContactFriendRequestsController *vc = [ContactFriendRequestsController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    else if(indexPath.section == 1){
        SSChatController *vc = [SSChatController new];
        vc.hidesBottomBarWhenPushed = YES;
        vc.chatType = SSChatConversationTypeChat;
        vc.sessionId = self.datas[indexPath.section][indexPath.row][@"title"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EMError *error = [[EMClient sharedClient].contactManager deleteContact:self.datas[indexPath.section][indexPath.row][@"title"] isDeleteConversation:YES];
        if (!error) {
            NSLog(@"删除成功");
        }
    }
}



-(void)rightBtnClick{
    
    PBSearchController *vc = [PBSearchController new];
    vc.FirstResponder = YES;
    vc.searchType = PBSearchAllType2;
    [self.navigationController pushViewController:vc animated:YES];
}

//显示未读消息
- (void)didNotificationsUnreadCountUpdate:(NSInteger)aUnreadCount{
     [self.mTableView reloadData];
}

@end
