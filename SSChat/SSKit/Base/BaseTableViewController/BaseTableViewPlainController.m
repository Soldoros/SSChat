//
//  BaseTableViewPlainController.m
//  htcm
//
//  Created by soldoros on 2018/4/16.
//  Copyright © 2018年 soldoros. All rights reserved.


#import "BaseTableViewPlainController.h"

@interface BaseTableViewPlainController ()

@end

@implementation BaseTableViewPlainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(self.isRoot==YES){
        self.tableViewH = MainViewRoot_Height;
    }else{
        self.tableViewH = MainViewSub_Height;
    }
    
    self.mTableView = [[UITableView alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, self.tableViewH) style:UITableViewStylePlain];
    [self.view addSubview:self.mTableView];
    self.mTableView.delegate = self;
    self.mTableView.dataSource = self;
    self.mTableView.backgroundColor = BackGroundColor;
    self.mTableView.backgroundView.backgroundColor = BackGroundColor;
    self.mTableView.sectionFooterHeight = 0;
    self.mTableView.sectionHeaderHeight = 0;
    self.mTableView.estimatedRowHeight = 0;
    self.mTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.mTableView.scrollIndicatorInsets = self.mTableView.contentInset;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    return cell;
}



@end
