//
//  SSChatMessageController.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "SSChatMessageController.h"

@interface SSChatMessageController ()

@end

@implementation SSChatMessageController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationNil];

////    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    self.mTableView.delaysContentTouches = NO;
//    self.mTableView.canCancelContentTouches = NO;
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)setViewFrame:(CGRect)viewFrame{
    [super setViewFrame:viewFrame];
    self.mTableView.frame = self.view.bounds;
}

-(void)tableView:(UITableView *)tableView   didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [UITableViewCell new];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}



@end
