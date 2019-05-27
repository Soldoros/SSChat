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


@interface ContactController ()<NIMSystemNotificationManagerDelegate,NIMUserManagerDelegate>

@end

@implementation ContactController

-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if(self = [super initWithRoot:root title:title]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"通讯录"];
    [self setRightOneBtnTitle:@"添加好友"];
    self.rightBtn1.width += 25;
    self.rightBtn1.right = self.navtionImgView.width-15;
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    self.mTableView.allowsSelectionDuringEditing = YES;
    [self.mTableView registerClass:@"ContactListCell" andCellId:ContactListCellId];
    [self.mTableView registerClass:@"UITableViewCell" andCellId:@"cellId"];
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    
    [self.mTableView.mj_header beginRefreshing];
}

-(void)netWorking{
    
    NSDictionary *dic1 = @{@"image":@"notification",@"title":@"好友申请"};
    NSDictionary *dic2 = @{@"image":@"group",@"title":@"我的群组"};
    NSDictionary *dic3 = @{@"image":@"contact",@"title":@"新建群组"};
    
    NSArray *array = [NIMSDK sharedSDK].userManager.myFriends;
    
    [self.datas removeAllObjects];
    [self.datas addObject:@[dic1,dic2,dic3]];
    [self.datas addObject:array];
    [self.mTableView.mj_header endRefreshing];
    [self.mTableView reloadData];
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
    return [(NSArray *)self.datas[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactListCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactListCellId];
    cell.indexPath = indexPath;
    if(indexPath.section == 0){
        cell.dataDic = self.datas[indexPath.section][indexPath.row];
    }else{
        cell.user = self.datas[indexPath.section][indexPath.row];
    }
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
        
        NSArray *array = [NIMSDK sharedSDK].userManager.myFriends;
        NSString *userId = [array[indexPath.row] userId];
        
        [[NIMSDK sharedSDK].userManager deleteFriend:userId removeAlias:YES completion:^(NSError *error) {

            if (!error) {
                [self showTime:@"删除成功"];
                [self netWorking];
            }else{
                [self showTime:@"删除好友失败"];
            }
        }];
    }
}

-(void)rightBtnClick{
    PBSearchController *vc = [PBSearchController new];
    vc.FirstResponder = YES;
    vc.searchType = PBSearchAllType2;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)onSystemNotificationCountChanged:(NSInteger)unreadCount{
    [self netWorking];
}

-(void)onFriendChanged:(NIMUser *)user{
    [self netWorking];
}


@end
