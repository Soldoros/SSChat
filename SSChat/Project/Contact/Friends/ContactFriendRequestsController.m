//
//  ContactFriendRequestsController.m
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

//好友申请列表
#import "ContactFriendRequestsController.h"
#import "ContactViews.h"

static const NSInteger MaxNotificationCount = 20;

@interface ContactFriendRequestsController ()<ContactViewsDelegate,NIMSystemNotificationManagerDelegate>

@end

@implementation ContactFriendRequestsController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[[NIMSDK sharedSDK] systemNotificationManager] markAllNotificationsAsRead];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"好友申请"];
    [self setRightOneBtnTitle:@"清空"];
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mTableView registerClass:@"ContactFriendRequestsCell" andCellId:ContactFriendRequestsCellId];

    [self netWorking];
}

-(void)netWorking{
    
    id<NIMSystemNotificationManager> manager = [[NIMSDK sharedSDK] systemNotificationManager];
    [manager addDelegate:self];
    NSArray *notifications = [manager fetchSystemNotifications:nil limit:MaxNotificationCount];
    
    [self.datas removeAllObjects];
    [self.datas addObjectsFromArray:notifications];
    [self.mTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactFriendRequestsCellH;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ContactFriendRequestsCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactFriendRequestsCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.notification = self.datas[indexPath.row];
    return cell;
}

//清空
-(void)rightBtnClick{
    [[[NIMSDK sharedSDK] systemNotificationManager] deleteAllNotifications];
    [self netWorking];
}

//收到好友、群组的邀请通知
-(void)onReceiveSystemNotification:(NIMSystemNotification *)notification{
    [self.datas insertObject:notification atIndex:0];
    [self.mTableView reloadSection:0 withRowAnimation:UITableViewRowAnimationAutomatic];
}


//拒绝50  同意51
-(void)ContactFriendRequestsCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    NIMSystemNotification *notification = self.datas[indexPath.row];
    
    if(sender.tag == 50){
        switch (notification.type) {
            case NIMSystemNotificationTypeTeamApply:
                
                break;
            case NIMSystemNotificationTypeTeamInvite:
                
                break;
            case NIMSystemNotificationTypeFriendAdd:{
                [self notificationDeleteFriend:notification];
            }
                break;
                
            default:
                break;
        }
    }
    
    else{
        switch (notification.type) {
            case NIMSystemNotificationTypeTeamApply:
                
                break;
            case NIMSystemNotificationTypeTeamInvite:
                
                break;
            case NIMSystemNotificationTypeFriendAdd:{
                [self notificationAddFriend:notification];
            }
                break;
                
            default:
                break;
        }
    }
}

//添加好友
-(void)notificationAddFriend:(NIMSystemNotification *)notification{
    
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = notification.sourceID;
    request.operation = NIMUserOperationVerify;
    
    [[[NIMSDK sharedSDK] userManager] requestFriend:request completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"验证成功"];
            notification.handleStatus = SSNotificationAgreed;
        }
        else{
           [self showTime:@"验证失败，请重试"];
        }
        [self.mTableView reloadData];
        cout(error.localizedDescription);
    }];
}


//删除好友
-(void)notificationDeleteFriend:(NIMSystemNotification *)notification{
    
    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = notification.sourceID;
    request.operation = NIMUserOperationReject;
    
    [[[NIMSDK sharedSDK] userManager] requestFriend:request completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"拒绝成功"];
            notification.handleStatus = SSNotificationDeclined;
        }
        else{
            [self showTime:@"拒绝失败，请重试"];
        }
        [self.mTableView reloadData];
        cout(error.localizedDescription);
    }];
}




@end
