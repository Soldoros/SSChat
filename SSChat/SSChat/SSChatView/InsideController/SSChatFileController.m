//
//  SSChatFileController.m
//  SSChat
//
//  Created by soldoros on 2019/5/30.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSChatFileController.h"

@interface SSChatFileController ()

@end

@implementation SSChatFileController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"文件列表"];
    
    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    
    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self.datas removeAllObjects];
        [self netWorking];
    }];
    [self.mTableView.mj_header beginRefreshing];
    
}

-(void)netWorking{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSArray *array = [self localFile];
        [self.datas addObjectsFromArray:array];

        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mTableView.mj_header endRefreshing];
            [self.mTableView reloadData];
        });
    });
    
}

-(NSMutableArray *)localFile {
    
    NSMutableArray *array = [NSMutableArray new];
    
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSFileManager *fm = [NSFileManager defaultManager];
    NSDirectoryEnumerator *dirEnum = [fm enumeratorAtPath:path];
    NSString *fileName;
    
    while (fileName = [dirEnum nextObject]) {
        NSLog(@"短路径:%@", fileName);
        NSLog(@"全路径:%@", [path stringByAppendingPathComponent:fileName]);
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        NSString *key = [[path stringByAppendingPathComponent:fileName] componentsSeparatedByString:@"/"].lastObject;
        [dict setObject:key forKey:@"key"];
        [dict setObject:[path stringByAppendingPathComponent:fileName] forKey:@"value"];
        [array addObject:dict];
    }
    return array;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSString *path = self.datas[indexPath.row][@"key"];
    cout(path);
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.textLabel.text = path.lastPathComponent;
    cell.imageView.image = [UIImage imageNamed:@"icon_file"];
    cell.imageView.bounds = CGRectMake(0, 0, 25, 40);
    cell.imageView.top = 5;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(_handle){
        NSDictionary *dic =  self.datas[indexPath.row];
        _handle(dic,dic[@"value"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
