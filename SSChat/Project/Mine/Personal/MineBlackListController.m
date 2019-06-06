//
//  MineBlackListController.m
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

//通讯录黑名单
#import "MineBlackListController.h"
#import "ContactViews.h"
#import "ContactFriendDetController.h"

@interface MineBlackListController ()<NIMUserManagerDelegate>


@end

@implementation MineBlackListController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

-(void)dealloc{
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"黑名单"];
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];
    
    self.mTableView.allowsSelectionDuringEditing = YES;
    [self.mTableView registerClass:@"ContactChoiceFriendsCell" andCellId:ContactChoiceFriendsCellId];
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    
    [self.mTableView.mj_header beginRefreshing];
}

-(void)netWorking{
    NSArray *array = [NIMSDK sharedSDK].userManager.myBlackList;
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:array];
    [self.mTableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactChoiceFriendsCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ContactChoiceFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactChoiceFriendsCellId];
    cell.indexPath = indexPath;
    cell.user = self.datas[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ContactFriendDetController *vc = [ContactFriendDetController new];
    vc.user = self.datas[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"移除黑名单";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NIMUser *user = self.datas[indexPath.row];
        
        [[NIMSDK sharedSDK].userManager removeFromBlackBlackList:user.userId completion:^(NSError *error) {
            if (!error) {
                [self showTime:@"移除黑名单成功"];
                [self netWorking];
            }else{
                 [self showTime:@"移除黑名单失败"];
            }
        }];
    }
}


#pragma mark - NIMUserManagerDelegate 黑名单列表发生变化 (在线)
-(void)onBlackListChanged{
    [self netWorking];
}


@end
