//
//  ContactFriendDetController.m
//  SSChat
//
//  Created by soldoros on 2019/6/3.
//  Copyright © 2019 soldoros. All rights reserved.
//


//好友详情
#import "ContactFriendDetController.h"
#import "ContactViews.h"
#import "MineViews.h"
#import "SSChatController.h"
#import "ConversationController.h"
#import "PBEditController.h"

@interface ContactFriendDetController ()<NIMUserManagerDelegate>

@end

@implementation ContactFriendDetController

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    [self setNavgaionTitle:@"个人名片"];
    
    [[NIMSDK sharedSDK].userManager addDelegate:self];

    [self.mTableView registerClass:@"MineTopCell" andCellId:MineTopCellId];
    [self.mTableView registerClass:@"ContactFriendsDetOtherCell" andCellId:ContactFriendsDetOtherCellId];
    [self.mTableView registerClass:@"ContactFriendsDetBottomCell" andCellId:ContactFriendsDetBottomCellId];
    
}

//头像  备注 (昵称 签名 电话)  (置顶聊天 消息提醒  拉黑)  (聊天 删除)
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

//头像  备注 (昵称 签名 电话)  (置顶聊天 消息提醒  拉黑)  (聊天 删除)
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0 || section == 1)return 1;
    else if(section == 4) return 2;
    else return 3;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0)return MineTopCellH;
    else if(indexPath.section == 4){
        return ContactTeamDetBottomCellH;
    }else return ContactTeamDetOtherCellH;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        MineTopCell *cell = [tableView dequeueReusableCellWithIdentifier:MineTopCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.user = _user;
        return cell;
    }
    else if(indexPath.section == 4){
        ContactFriendsDetBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactFriendsDetBottomCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        cell.user = _user;
        return cell;
    }
    else{
        ContactFriendsDetOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactFriendsDetOtherCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.indexPath = indexPath;
        cell.user = _user;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView setCelllineWithCell:cell top:0 left:0 bottom:0 right:0];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //设置备注
    if(indexPath.section == 1){
        PBEditController *vc = [[PBEditController alloc]initWithType:PBEditTypeNote user:_user];
        vc.handle = ^(NSError *error, NSString *string, PBEditType type) {
            
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //发消息 添加好友、删除好友
    if(indexPath.section == 4){
        ContactFriendsDetBottomCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if([cell.textLabel.text isEqualToString:@"发送消息"]){
            
            [self sendMesssage];
        }
        else if([cell.textLabel.text isEqualToString:@"添加好友"]){
            
            [self setMessageAddFriend];
        }
        else if([cell.textLabel.text isEqualToString:@"删除好友"]){
            
            [self deleteFriendHelpfulHints];
        }
    }
}

//发送消息
-(void)sendMesssage{
    
    NIMSession *session = [NIMSession session:_user.userId type:NIMSessionTypeP2P];
    SSChatController *vc = [SSChatController new];
    vc.hidesBottomBarWhenPushed = YES;
    vc.session = session;
    [self.navigationController pushViewController:vc animated:YES];
    
    UIViewController *root = self.navigationController.viewControllers[0];
    self.navigationController.viewControllers = @[root,vc];
}


//添加好友
-(void)setMessageAddFriend{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"留言" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UITextField *textF = alert.textFields[0];
        [self addFriend:textF.text];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入留言";
    }];
    
    [okAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
    
}

//添加好友需要验证 NIMUserOperationRequest
-(void)addFriend:(NSString *)message{
    
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = _user.userId;
    request.operation = NIMUserOperationRequest;
    request.message = message.length>0 ? message : @"请求添加您为好友!";
    
    [[NIMSDK sharedSDK].userManager requestFriend:request completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"发送成功"];
        }
        else{
            [self showTime:@"发送失败"];
        }
    }];
}

//删除好友的友情提示
-(void)deleteFriendHelpfulHints{

    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"删除好友会直接解除双方的好友关系" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* outAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确认删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        [self deleteFriend];
    }];
    
    [alert addAction:outAction];
    [alert addAction:deleteAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

//删除好友
-(void)deleteFriend{
    
    [[NIMSDK sharedSDK].userManager deleteFriend:_user.userId removeAlias:YES completion:^(NSError *error) {
        
        if (!error) {
            [self showTime:@"删除成功"];
        }else{
            [self showTime:@"删除好友失败"];
        }
    }];
}

#pragma mark - NIMUserManagerDelegate
//用户信息被更改（在线）
-(void)onUserInfoChanged:(NIMUser *)user{
    if ([user.userId isEqualToString:_user.userId]){
        [self.mTableView reloadData];
    }
}

//好友状态发生变化 (在线)
-(void)onFriendChanged:(NIMUser *)user{
    if ([user.userId isEqualToString:_user.userId]){
        [self.mTableView reloadData];
    }
}

//黑名单列表发生变化 (在线)
-(void)onBlackListChanged{
    [self.mTableView reloadData];
}

//静音列表发生变化 (在线)
-(void)onMuteListChanged{
    [self.mTableView reloadData];
}

@end
