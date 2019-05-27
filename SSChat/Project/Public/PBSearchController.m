//
//  PBSearchController.m
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "PBSearchController.h"
#import "ConversationViews.h"
#import "ContactViews.h"
#import "MineViews.h"
#import "SSTableSwitchView.h"

@interface PBSearchController ()<UISearchBarDelegate,PBSearchViewsDelegate>

@property(nonatomic,assign)BOOL frist;
@property(nonatomic,assign)BOOL searchFrist;
@property(nonatomic,strong)NSUserDefaults *user;

//搜索状态和历史记录 历史记录数据
@property(nonatomic,strong)PBSearchView *searchView;

//已经申请过的联系人
@property(nonatomic,strong)NSMutableArray  *invitedUsers;

@end

@implementation PBSearchController

-(instancetype)init{
    if(self = [super init]){
        _FirstResponder = YES;
        _frist = YES;
        _searchFrist = YES;
        
        _invitedUsers = [NSMutableArray new];
        
        self.isSearch = NO;
        _searchString = @"";
        self.datas = [NSMutableArray new];
        _user = [NSUserDefaults standardUserDefaults];
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightOneBtnTitle:@"取消"];
    [self setLeftOneBtnImg:@"fanhui"];
    
    [self.rightBtn1 setTitle:@"搜索" forState:UIControlStateSelected];
    [self.rightBtn1 setTitleColor:makeColorHex(@"333333") forState:UIControlStateNormal];
    [self.rightBtn1 setTitleColor:makeColorHex(@"333333") forState:UIControlStateSelected];
    self.rightBtn1.selected = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *_searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.bounds = CGRectMake(0, 0, SCREEN_Width-105, 32);
    _searchBtn.left = 45;
    _searchBtn.centerY = StatuBar_Height+NavBar_Height*0.5;
    [self.navtionImgView addSubview:_searchBtn];
    _searchBtn.clipsToBounds = YES;
    _searchBtn.layer.cornerRadius = _searchBtn.height * 0.5;
    [_searchBtn setBackgroundImage:[UIImage imageWithColor:makeColorHex(@"F7F7F7")] forState:UIControlStateNormal];
    
    _mSearchBar = [[UISearchBar alloc]init];
    _mSearchBar.frame = _searchBtn.bounds;
    [_searchBtn addSubview:_mSearchBar];
    _mSearchBar.clipsToBounds = YES;
    _mSearchBar.layer.cornerRadius = 6;
    [_mSearchBar setReturnKeyType:UIReturnKeyDone];
    _mSearchBar.delegate = self;
    _mSearchBar.showsCancelButton = NO;
    _mSearchBar.enablesReturnKeyAutomatically = NO;
    _mSearchBar.barTintColor = [UIColor clearColor];
    _mSearchBar.tintColor=[UIColor blackColor];
    [[[[_mSearchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [_mSearchBar setBackgroundColor:[UIColor clearColor]];
    
    [_mSearchBar setImage:[[UIImage imageNamed:@"icon_sousuo"] imageWithColor:makeColorHex(@"#999999")]
         forSearchBarIcon:UISearchBarIconSearch
                    state:UIControlStateNormal];
    
    UITextField *searchField = [_mSearchBar valueForKey:@"searchField"];
    if (searchField) {
        [searchField setBackgroundColor:[UIColor clearColor]];
        searchField.clipsToBounds = YES;
        searchField.layer.cornerRadius = 16;
        [searchField setFont:[UIFont systemFontOfSize:14]];
        searchField.tintColor = makeColorHex(@"C7C7C7");
        [searchField setValue:makeColorHex(@"C7C7C7") forKeyPath:@"_placeholderLabel.textColor"];
        searchField.textColor = makeColorHex(@"333333");
        [searchField addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventEditingChanged];
    }

    self.mTableView.top -= 1;
    self.mTableView.height += 1;
    self.mTableView.backgroundColor = [UIColor whiteColor];
    self.mTableView.backgroundView.backgroundColor = [UIColor whiteColor];

    [self.mTableView registerClass:@"PBSearchFriendCell" andCellId:PBSearchFriendCellId];

    [self.view bringSubviewToFront:self.navtionBar];
    
    UILabel *footerLab = [[UILabel alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 60)];
    footerLab.textAlignment = NSTextAlignmentCenter;
    footerLab.font = makeFont(14);
    footerLab.textColor = makeColorHex(@"666666");
    footerLab.text = @"没有更多啦";
    self.mTableView.tableFooterView = footerLab;
    
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    
    [_mSearchBar changeLeftPlaceholder:@"请输入联系人..."];

    
    if(_FirstResponder){
        _FirstResponder = NO;
        [_mSearchBar becomeFirstResponder];
    }
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

//会话搜索 添加好友搜索 好友搜索 黑名单搜索
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_searchType == PBSearchAllType2){
        return  ContactListCellH;
    }
    else return  80;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    PBSearchFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:PBSearchFriendCellId];
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.invitedUsers = _invitedUsers;
    cell.friendString = self.datas[indexPath.row];
    return cell;
}


#pragma mark - Table view data source
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(!_frist){
        _frist = NO;
        return;
    }
}


//体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


-(void)textClick:(UITextField *)textField{
    _searchString = textField.text;
    self.rightBtn1.selected = YES;
}

//是否处于输入搜索词状态 是(yes)  否(no)
-(void)setIsSearch:(BOOL)isSearch{
    _isSearch = isSearch;
    if(!_isSearch){
        [self removeSearch];
        [_mSearchBar endEditing:YES];
        self.rightBtn1.selected = NO;
    }else{
        [self addSearchView];
    }
}


//加载搜索历史
-(void)addSearchView{
    if(!_searchView){
        _searchView = [[PBSearchView alloc]initWithFrame:self.mTableView.frame];
    }
    _searchView.delegate = self;
    _searchView.searchType = _searchType;
    [self.view addSubview:_searchView];
}

//删除搜索历史
-(void)removeSearch{
    if(_searchView){
        [_mSearchBar endEditing:YES];
        [_searchView removeFromSuperview];
        _searchView = nil;
    }
}


//保存搜索历史
-(void)historySave{
    NSMutableArray *array = [NSMutableArray new];
    NSArray *arr = [_user arrayForKey:USER_Serchhistory];
    if(arr==nil){
        [array addObject:_mSearchBar.text];
        [_user setObject:array forKey:USER_Serchhistory];
        return;
    }
    [array addObjectsFromArray:arr];
    
    BOOL bu = NO;
    for(NSString *str in arr){
        if([str isEqualToString:_mSearchBar.text]){
            bu = YES;
            break;
        }
    }
    if(bu==NO){
        [array addObject:_mSearchBar.text];
    }
    if(array.count<8){
        [_user setObject:array forKey:USER_Serchhistory];
        return;
    }
    for(int i=0;i<array.count-8;++i){
        [array removeObjectAtIndex:i];
    }
    [_user setObject:array forKey:USER_Serchhistory];

}


//开始输入
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.isSearch = YES;
    [self textClick:[_mSearchBar valueForKey:@"searchField"]];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_mSearchBar.text.length>0){
        [self historySave];
    }
    _searchString = _mSearchBar.text;
}

#pragma mark PBSearchViewDelegate 开始搜索
-(void)PBSearchCellClick:(NSIndexPath *)indexPath result:(NSString *)result{

    _searchFrist = NO;
    _searchString = result;
    _mSearchBar.text = result;
    if(_mSearchBar.text.length>0){
        [self historySave];
    }
    [self startSearch];
}


-(void)rightBtnClick{
    
    if(self.rightBtn1.selected){
        if(_mSearchBar.text.length>0){
            [self historySave];
        }
        _searchString = _mSearchBar.text;
        [self startSearch];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//回车判断
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        if(_mSearchBar.text.length>0){
            [self historySave];
        }
        _searchString = _mSearchBar.text;
        [self startSearch];
    }
    
    return YES;
}



-(void)startSearch{
    cout(@"开始搜索");
    [self.datas removeAllObjects];
    self.isSearch = NO;
    _searchString = [_searchString stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    if(_searchString.length==0){
        [self showTime:@"请输入账号"];
        return;
    }
    
    [[NIMSDK sharedSDK].userManager fetchUserInfos:@[_searchString] completion:^(NSArray *users, NSError *error) {

        if (users.count) {
            [self.datas addObject:self.searchString];
            [self.mTableView reloadData];
        }else{
            [self showTime:@"该用户不存在"];
        }
    }];

}

//点击添加联系人回调
-(void)PBSearchFriendCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"留言" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        
        UITextField *textF = alert.textFields[0];
        [self addFriend:textF.text indexPath:indexPath];
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"请输入留言";
    }];
    
    [okAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}

//添加好友需要验证 NIMUserOperationRequest
-(void)addFriend:(NSString *)message indexPath:(NSIndexPath *)indexPath{
    
    NSString *user = self.datas[indexPath.row];

    NIMUserRequest *request = [[NIMUserRequest alloc] init];
    request.userId = user;
    request.operation = NIMUserOperationRequest;
    request.message = message.length>0 ? message : @"请求添加您为好友!";
   
    [[NIMSDK sharedSDK].userManager requestFriend:request completion:^(NSError *error) {

        if (!error) {
            [self showTime:@"发送成功"];
            [self.invitedUsers addObject:user];
            [self.mTableView reloadData];
        }
        else{
            [self showTime:@"发送失败"];
        }
    }];
}

@end

