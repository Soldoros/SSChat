//
//  MineController.m
//  SSChat
//
//  Created by soldoros on 2019/4/9.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "MineController.h"
#import "MineViews.h"
#import "AccountLoginController.h"
#import "MineScanningController.h"
#import "MinePersonalController.h"
#import "MineAboutUsController.h"
#import "SSChatController.h"
#import "MineSettingController.h"
#import "MineBlackListController.h"

@interface MineController ()<NIMUserManagerDelegate>


@end

@implementation MineController

-(instancetype)initWithRoot:(BOOL)root title:(NSString *)title{
    if(self = [super initWithRoot:root title:title]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)dealloc{
    [[NIMSDK sharedSDK].userManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"我的"];
    [self setRightOneBtnImg:@"saoyisao"];
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];

    [self.mTableView registerClass:@"MineTopCell" andCellId:MineTopCellId];
    [self.mTableView registerClass:@"MineCenterCell" andCellId:MineCenterCellId];
    [self.mTableView registerClass:@"MineLogOutCell" andCellId:MineLogOutCellId];
    
    [self netWorking];
}

-(void)netWorking{
    
    NSString *me = [[NIMSDK sharedSDK].loginManager currentAccount];
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:me];
    
    NSArray *array =
    @[@[@{@"title":@"",@"detail":user}],
      @[@{@"title":@"黑名单",@"detail":@""},
        @{@"title":@"意见反馈",@"detail":@""},
        @{@"title":@"关于我们",@"detail":@""}],
      @[@{@"title":@"系统设置",@"detail":@""}]];
    
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:array];
    [self.mTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [(NSArray *)self.datas[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)return MineTopCellH;
    else return MineCenterCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MineTopCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTopCellId];
        cell.user = self.datas[indexPath.section][indexPath.row][@"detail"];
        return cell;
    }
    else{
        MineCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:MineCenterCellId];
        cell.textLabel.text = self.datas[indexPath.section][indexPath.row][@"title"];
        return cell;
    }
}

//扫一扫添加好友
-(void)rightBtnClick{
    MineScanningController *vc = [MineScanningController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //个人信息
    if(indexPath.section == 0){
        MinePersonalController *vc = [MinePersonalController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //黑名单
    else if(indexPath.section == 1 && indexPath.row == 0){
        MineBlackListController *vc = [MineBlackListController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //意见反馈
    else if(indexPath.section == 1 && indexPath.row == 1){
     
        SSChatController *vc = [SSChatController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //关于我们
    else if(indexPath.section == 1 && indexPath.row == 2){
        MineAboutUsController *vc = [MineAboutUsController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //系统设置
    else{
        MineSettingController *vc = [MineSettingController new];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


#pragma mark - NIMUserManagerDelagate
- (void)onUserInfoChanged:(NIMUser *)user
{
    if ([user.userId isEqualToString:[[NIMSDK sharedSDK].loginManager currentAccount]]) {
        [self netWorking];
    }
}

@end
