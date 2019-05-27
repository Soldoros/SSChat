//
//  MineSettingController.m
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "MineSettingController.h"
#import "SSAccountManager.h"
#import "MineViews.h"

@interface MineSettingController ()

@property(nonatomic,strong)NSUserDefaults *user;

@end

@implementation MineSettingController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
        _user = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"系统设置"];
    
    [self.mTableView registerClass:@"MineSwitchCell" andCellId:MineSwitchCellId];
    [self.mTableView registerClass:@"MineLogOutCell" andCellId:MineLogOutCellId];
    
    
    NSArray *arr = @[@[@{@"title":@"加我好友需要验证",
                         @"status":@"2",
                         @"detail":@([_user boolForKey:USER_AddVerification])},
                       @{@"title":@"清空聊天记录",
                         @"status":@"3",
                         @"detail":@""}],
                     @[@{@"title":@"退出登录",
                         @"status":@"-1",
                         @"detail":@""}]];
    [self.datas addObjectsFromArray:arr];
    
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
    NSString *status = self.datas[indexPath.section][indexPath.row][@"status"];
    if(status.integerValue == -1){
        return  MineLogOutCellH;
    }else{
        return  MineSwitchCellH;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *status = self.datas[indexPath.section][indexPath.row][@"status"];
    if(status.integerValue == -1){
        MineLogOutCell *cell = [tableView dequeueReusableCellWithIdentifier:MineLogOutCellId];
        cell.textLabel.text = self.datas[indexPath.section][indexPath.row][@"title"];
        return cell;
    }else{
        MineSwitchCell *cell = [tableView dequeueReusableCellWithIdentifier:MineSwitchCellId];
        cell.indexPath = indexPath;
        cell.dataDic = self.datas[indexPath.section][indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *status = self.datas[indexPath.section][indexPath.row][@"status"];
    //退出登录
    if(status.integerValue == -1){
        [self loginOutCellClick];
    }
}


//退出登录
-(void)loginOutCellClick{
    //显示弹出框列表选择
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:@"退出登录后数据会保存，下次登录还可正常使用" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* outAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确认退出" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self loginOutNetWorking];
    }];
    
    [alert addAction:outAction];
    [alert addAction:deleteAction];
    [self presentViewController:alert animated:YES completion:nil];
}

-(void)loginOutNetWorking{
    
    [[NIMSDK sharedSDK].loginManager logout:^(NSError * _Nullable error) {
        if(error){
            cout(error.description);
            [self showTime:error.description];
        }else{
            [[NSNotificationCenter defaultCenter] postNotificationName:NotiLoginStatusChange object:@NO];
        }
    }];
}

@end
