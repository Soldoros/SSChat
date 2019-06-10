//
//  ContactChoiceFriendsController.m
//  SSChat
//
//  Created by soldoros on 2019/5/31.
//  Copyright © 2019 soldoros. All rights reserved.
//


//选择联系人
#import "ContactChoiceFriendsController.h"
#import "ContactViews.h"

@interface ContactChoiceFriendsController ()

@property(nonatomic,strong)NSMutableArray *choiceUsers;

@end

@implementation ContactChoiceFriendsController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = [NSMutableArray new];
        _choiceUsers = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"选择联系人"];
    [self setRightOneBtnTitle:@"完成"];
    [self setLeftOneBtnTitle:@"取消"];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    [self.mTableView registerClass:@"ContactChoiceFriendsCell" andCellId:ContactChoiceFriendsCellId];
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    
    [self.mTableView.mj_header beginRefreshing];
}


-(void)netWorking{
    
    NSArray *array = [NIMSDK sharedSDK].userManager.myFriends;
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
    
    NIMUser *user =  self.datas[indexPath.row];
    ContactChoiceFriendsCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if(cell.accessoryType == UITableViewCellAccessoryNone){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        [_choiceUsers addObject:user.userId];
    }else{
        cell.accessoryType = UITableViewCellAccessoryNone;
        [_choiceUsers removeObject:user.userId];
    }
}

-(void)leftBtnCLick{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)rightBtnClick{
    
    if(_choiceUsers.count == 0){
        [self showTime:@"请选择联系人"];
        return;
    }
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"群名称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UITextField *textF = alert.textFields[0];
        [self createTeam:textF.text];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入群名称";
    }];
    
    [okAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)createTeam:(NSString *)name{
    
    if(name.length == 0 || name == nil){
        if(_type == NIMTeamTypeNormal){
            name = @"讨论组";
        }else{
            name = @"高级群";
        }
    }
    if(_handle){
        _handle(_choiceUsers,name, _type);
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
