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

@interface ContactFriendRequestsController ()

@end

@implementation ContactFriendRequestsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"好友申请"];
    
//    NSString *fileName = @"emdemo_options.data";
//    NSString *file = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:fileName];
//    [NSKeyedArchiver archiveRootObject:self toFile:file];
//
//    NSString *_fileName = [NSString stringWithFormat:@"emdemo_notifications_%@.data", [EMClient sharedClient].currentUsername];
//
//    NSString *file2 = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:_fileName];
//    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:file2];
 
    
    [self.mTableView registerClass:@"ContactFriendRequestsCell" andCellId:ContactFriendRequestsCellId];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ContactFriendRequestsCellH;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactFriendRequestsCell *cell = [tableView dequeueReusableCellWithIdentifier:ContactFriendRequestsCellId];
    return cell;
}


@end
