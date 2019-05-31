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
#import "SSAddImage.h"

@interface MinePersonalController ()<NIMUserManagerDelegate>

@property(nonatomic,strong)SSAddImage *mAddImage;

@end

@implementation MinePersonalController

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
    [self setNavgaionTitle:@"个人信息"];
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];
    
    [self.mTableView registerClass:@"MineInformationCell" andCellId:MineInformationCellId];
    
    [self netWorking];
}

-(void)netWorking{
    
    NSString *me = [[NIMSDK sharedSDK].loginManager currentAccount];
    NIMUser *user = [[NIMSDK sharedSDK].userManager userInfo:me];
    
    NSString *avatarUrl = user.userInfo.avatarUrl;
    NSString *nickName  = user.userInfo.nickName;
    NSString *account   = me;
    NSString *qrCode    = me;
    NSString *address   = @"";

    if(avatarUrl == nil)avatarUrl = @"";
    if(nickName == nil)nickName = @"";
    
    NSArray *array =
    @[@[@{@"title":@"头像",@"detail":avatarUrl},
        @{@"title":@"昵称",@"detail":nickName},
        @{@"title":@"账号",@"detail":account},
        @{@"title":@"二维码",@"detail":qrCode}],
      @[@{@"title":@"我的地址",@"detail":address}]];
    
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
    
    //头像
    if(indexPath.row == 0){
        [self setHeaderImage];
    }
    //昵称
    if(indexPath.row == 1){
        [self setNikeName];
    }
    //我的二维码
    if(indexPath.row == 3){
        MineQrCodeController *vc = [MineQrCodeController new];
        vc.userName = self.datas[indexPath.section][indexPath.row][@"detail"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //我的地址
    if(indexPath.section == 1){
        MineAddressController *vc = [MineAddressController new];
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

//头像
-(void)setHeaderImage{
    if(!_mAddImage){
        _mAddImage = [[SSAddImage alloc]init];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.mAddImage getImagePickerWithAlertController:self modelType:SSImagePickerModelImage pickerBlock:^(SSImagePickerWayStyle wayStyle, SSImagePickerModelType modelType, id object) {
            
            NSString *path = (NSString *)object;
            cout(path);
            [self uploadImage:path];
            
        }];
        
    });
}

-(void)uploadImage:(NSString *)filePath{
    
    [[NIMSDK sharedSDK].resourceManager upload:filePath scene:NIMNOSSceneTypeAvatar progress:^(float progress) {
        cout(@(progress));
    } completion:^(NSString * _Nullable urlString, NSError * _Nullable error) {
        if(error){
            [self showTime:@"图片上传失败，请重试"];
        }else{
            [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagAvatar):urlString} completion:^(NSError *error) {
                if (!error) {
                    [self showTime:@"头像更新成功"];
                }else{
                    [self showTime:@"头像设置失败，请重试!"];
                }
            }];
        }
    }];
    
}


//昵称
-(void)setNikeName{
    
    NSString *string = @"修改昵称";
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:string message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UITextField *textF = alert.textFields[0];
        [self uploadNicknName:textF.text];
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

//更新昵称
-(void)uploadNicknName:(NSString *)nickName{
    
    [[NIMSDK sharedSDK].userManager updateMyUserInfo:@{@(NIMUserInfoUpdateTagNick) : nickName} completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"昵称设置成功"];
        }else{
            [self showTime:@"昵称设置失败，请重试"];
        }
    }];
}

@end
