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


@interface ContactFriendRequestsController ()<ContactViewsDelegate>

@property(nonatomic,strong)SSNotificationManager *manger;

@end

@implementation ContactFriendRequestsController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
        _manger = [SSNotificationManager shareSSNotificationManager];
    }
    return self;
}

//好友申请
-(void)registerNoti{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didNotificationsUpdate) name:NotiDataPersistence object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNoti];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"好友申请"];
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mTableView registerClass:@"ContactFriendRequestsCell" andCellId:ContactFriendRequestsCellId];
    
    [self didNotificationsUpdate];
}


-(void)didNotificationsUpdate{
    
    [_manger setAllRead];
    self.datas = _manger.notificationList;
    [self.mTableView reloadData];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactFriendRequestsCellH;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SSNotificationModel *model = self.datas[indexPath.row];
    ContactFriendRequestsCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactFriendRequestsCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.model = model;
    return cell;
}


//同意 拒绝按钮点击回调
-(void)ContactFriendRequestsCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    
    SSNotificationModel *model = self.datas[indexPath.row];
    
    if([sender.titleLabel.text isEqualToString:@"同意"]){
        
        if (model.type == SSNotificationTypeContact) {
            
            [[EMClient sharedClient].contactManager approveFriendRequestFromUser:model.sender completion:^(NSString *aUsername, EMError *aError) {
                
                if(!aError){
                    model.status = SSNotificationAgreed;
                    self.manger.notificationList[indexPath.row] = model;
                    [self.manger setLocalDatas];
                    [self.mTableView reloadData];

                    [[NSNotificationCenter defaultCenter] postNotificationName:NotiContactChange object:nil];
                }
                else{
                    cout(aError.errorDescription);
                }
            }];
        }
    }
    else{
        if (model.type == SSNotificationTypeContact) {
            
            [[EMClient sharedClient].contactManager declineFriendRequestFromUser:model.sender completion:^(NSString *aUsername, EMError *aError) {
                
                if(!aError){
                    model.status = SSNotificationDeclined;
                    self.manger.notificationList[indexPath.row] = model;
                    [self.manger setLocalDatas];
                    [self.mTableView reloadData];
                }
                else{
                    cout(aError.errorDescription);
                }
                
            }];
        }
    }
  
}



@end
