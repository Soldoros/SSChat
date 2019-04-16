//
//  MinePersonalController.m
//  SSChat
//
//  Created by soldoros on 2019/4/15.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "MinePersonalController.h"
#import "MineViews.h"
#import "MineQrCodeController.h"
#import "MineAddressController.h"

@interface MinePersonalController ()

@property(nonatomic,strong)NSUserDefaults *user;

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *nickName;
//我的地址
@property(nonatomic,strong)NSString *address;

@end

@implementation MinePersonalController

-(instancetype)init{
    if(self = [super init]){
        _user = [NSUserDefaults standardUserDefaults];
        _address = @"";
        _userName = @"";
        _nickName = @"";
        self.datas = [NSMutableArray new];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"个人信息"];
    
    [self.mTableView registerClass:@"MineInformationCell" andCellId:MineInformationCellId];
    
    [self netWorking];
}

-(void)netWorking{
    
    //[EMClient sharedClient].pushOptions.displayName;
    _userName = [[EMClient sharedClient] currentUsername];
    _nickName = [_user valueForKey:USER_Nickname];
    if(_userName == nil)_userName = @"";
    if(_nickName == nil)_nickName = @"";

    NSArray *array =
    @[@[@{@"title":@"头像",@"detail":@"user_avatar_gray"},
        @{@"title":@"昵称",@"detail":_nickName},
        @{@"title":@"账号",@"detail":_userName},
        @{@"title":@"二维码",@"detail":@"jiankangerweima"}],
      @[@{@"title":@"我的地址",@"detail":_address}]];
    
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
    return [self.datas[section] count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        return MineInformationCellH;
    }else{
        return MineInformationCellH2;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MineInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:MineInformationCellId];
    cell.indexPath = indexPath;
    cell.dataDic = self.datas[indexPath.section][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //昵称
    if(indexPath.row == 1){
        [self setNikeName];
    }
    //我的二维码
    if(indexPath.row == 3){
        MineQrCodeController *vc = [MineQrCodeController new];
        vc.userName = _userName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    //我的地址
    if(indexPath.section == 1){
        MineAddressController *vc = [MineAddressController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


//昵称
-(void)setNikeName{
    
    NSString *string = @"修改昵称";
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UITextField *textF = alert.textFields[0];
        [[EMClient sharedClient] setApnsNickname:textF.text];
        makeUserNickName(textF.text);
        [self.datas removeAllObjects];
        [self netWorking];
        [[NSNotificationCenter defaultCenter] postNotificationName:NotiMinePersonalChange object:nil];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入新的昵称";
    }];
    
    [okAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
