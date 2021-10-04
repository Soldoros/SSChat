//
//  SSChatMessageController.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//

#import "SSChatMessageController.h"
#import "SSChatBaseCell.h"

@interface SSChatMessageController ()

@end

@implementation SSChatMessageController

-(instancetype)init{
    if(self = [super init]){
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgationNil];
    
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mTableView registerClass:@"SSChatTextCell" andCellId:SSChatTextCellId];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)setViewFrame:(CGRect)viewFrame{
    [super setViewFrame:viewFrame];
    self.mTableView.frame = self.view.bounds;
    if(self.mTableView.contentSize.height>self.mTableView.height){
        [self.mTableView scrollToBottomAnimated:NO];
    }
}


-(void)sendMessage:(SSChatMessage *)message{
    [self.datas addObject:message];
    [self.mTableView reloadData];

    NSIndexPath *indexPath = [NSIndexPath     indexPathForRow:self.datas.count-1 inSection:0];
    [self.mTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.datas[indexPath.row] cellHeight];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SSChatMessage *message = self.datas[indexPath.row];
    SSChatBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:message.cellId];
    cell.indexPath = indexPath;
    cell.message = message;
    return cell;
}


-(void)tableView:(UITableView *)tableView   didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     
}

@end
