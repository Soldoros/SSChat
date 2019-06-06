//
//  ContactTeamListController.m
//  SSChat
//
//  Created by soldoros on 2019/5/31.
//  Copyright © 2019 soldoros. All rights reserved.
//

//群组列表
#import "ContactTeamListController.h"
#import "ContactViews.h"
#import "SSChatController.h"

@interface ContactTeamListController ()<NIMTeamManagerDelegate>

@end

@implementation ContactTeamListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].teamManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"我的群组"];
    
    [[NIMSDK sharedSDK].teamManager addDelegate:self];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    [self.mTableView registerClass:@"ContactListCell" andCellId:ContactListCellId];
    
    self.mTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    
    [self.mTableView.mj_header beginRefreshing];
}


-(void)netWorking{
    
    NSArray *array = [NIMSDK sharedSDK].teamManager.allMyTeams;
    
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:array];
    [self.mTableView.mj_header endRefreshing];
    [self.mTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.01;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  0.01;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactListCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactListCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactListCellId];
    cell.indexPath = indexPath;
    cell.team = self.datas[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NIMTeam *team =  self.datas[indexPath.row];
    NIMSession *session = [NIMSession session:team.teamId type:NIMSessionTypeTeam];
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.session = session;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
