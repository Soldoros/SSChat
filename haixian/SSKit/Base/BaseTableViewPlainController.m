//
//  BaseTableViewPlainController.m
//  htcm
//
//  Created by soldoros on 2018/4/16.
//  Copyright © 2018年 soldoros. All rights reserved.
//

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
    //    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    return cell;
    
}

-(void)configureHedaerFooter:(id)view atInSection:(NSInteger)section{
    [view setFd_enforceFrameLayout:YES];
}

//cell高度自适应 并且给cell赋值
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = YES;
}



@end
