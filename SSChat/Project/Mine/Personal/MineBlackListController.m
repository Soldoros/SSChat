//
//  MineBlackListController.m
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

//通讯录黑名单
#import "MineBlackListController.h"
#import "MineViews.h"

@interface MineBlackListController ()


@end

@implementation MineBlackListController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"黑名单"];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datas count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.font = makeFont(16);
    }
    cell.textLabel.text = self.datas[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}



@end
