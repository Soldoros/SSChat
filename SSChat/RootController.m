//
//  RootController.m
//  SSChatView
//
//  Created by soldoros on 2018/10/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "RootController.h"
#import "SSChatController.h"


@interface RootController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *mTableView;
@property(nonatomic,strong)NSMutableArray *datas;

@end

@implementation RootController

-(instancetype)init{
    if(self = [super init]){
        _datas = [NSMutableArray new];
        [_datas addObjectsFromArray:@[@{@"image":@"touxiang1",
                                        @"title":@"神经萝卜",
                                        @"detail":@"王医生你好，我最近老感觉头晕乏力，是什么原因造成的呢？",
                                        @"sectionId":@"13540033103",
                                        @"type":@"1"
                                        },
                                      @{@"image":@"touxaing2",
                                        @"title":@"王医生",
                                        @"detail":@"您好，可以给我发送一份你的体检报告吗？便于我了解情况，谁是给我打电话13540033104",
                                        @"sectionId":@"13540033104",
                                        @"type":@"1"
                                        }]];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"SSChat";
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect rect = CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, SCREEN_Height-SafeAreaTop_Height-SafeAreaBottom_Height);
    
    _mTableView = [[UITableView alloc]initWithFrame:rect style:UITableViewStylePlain];
    _mTableView.dataSource = self;
    _mTableView.delegate = self;
    _mTableView.backgroundColor = SSChatCellColor;
    _mTableView.backgroundView.backgroundColor = SSChatCellColor;
    [self.view addSubview:self.mTableView];
    _mTableView.rowHeight = 70;
    
    _mTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _mTableView.scrollIndicatorInsets = _mTableView.contentInset;
    if (@available(iOS 11.0, *)){
        _mTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _mTableView.estimatedRowHeight = 0;
        _mTableView.estimatedSectionHeaderHeight = 0;
        _mTableView.estimatedSectionFooterHeight = 0;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if(!cell){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cellId"];
        cell.textLabel.font = [UIFont systemFontOfSize:18];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor grayColor];
    }
    cell.imageView.image = [UIImage imageNamed:_datas[indexPath.row][@"image"]];
    cell.textLabel.text = _datas[indexPath.row][@"title"];
    cell.detailTextLabel.text = _datas[indexPath.row][@"detail"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    SSChatController *vc = [SSChatController new];
    vc.chatType = (SSChatConversationType)[_datas[indexPath.row][@"type"]integerValue];
    vc.sessionId = _datas[indexPath.row][@"sectionId"];
    vc.titleString = _datas[indexPath.row][@"title"];
    [self.navigationController pushViewController:vc animated:YES];
    
}




@end
