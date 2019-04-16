//
//  PBSearchAllController.m
//  htcm
//
//  Created by soldoros on 2018/7/24.
//  Copyright © 2018年 soldoros. All rights reserved.
//



#import "PBSearchAllController.h"
#import "ConversationViews.h"
#import "ContactViews.h"
#import "MineViews.h"

#import "SSTableSwitchView.h"



@interface PBSearchAllController ()<UISearchBarDelegate,PBSearchViewsDelegate,SSTableScrollSwitchViewDelegate>

@property(nonatomic,assign)BOOL frist;
@property(nonatomic,assign)BOOL searchFrist;
@property(nonatomic,strong)NSUserDefaults *user;

//筛选视图
@property(nonatomic,strong)SSTableScrollSwitchView *topView;
@property(nonatomic,assign)NSInteger topStyle;

@property(nonatomic,strong)NSArray *topArray;

//搜索状态和历史记录 历史记录数据
@property(nonatomic,strong)PBSearchView *searchView;

//显示底部
@property(nonatomic,strong)UILabel *footerLab;

@property(nonatomic,strong)UIButton *currentSender;

@end

@implementation PBSearchAllController

-(instancetype)init{
    if(self = [super init]){
        _FirstResponder = YES;
        _frist = YES;
        _searchFrist = YES;
        _currentSender = nil;
        
        self.isSearch = NO;
        _searchString = @"";
        self.datas = [NSMutableArray new];
        _user = [NSUserDefaults standardUserDefaults];
        
        _topStyle = 0;
        _searchType = (PBSearchAllType)_topStyle+1;
        _topArray = @[@"特色服务",@"医疗美容",@"专家队伍"];
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
    [_mSearchBar changeLeftPlaceholder:@"搜索医生、症状、服务......"];
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
    
    _topView = [[SSTableScrollSwitchView alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, 50)];
    _topView.delegate = self;
    _topView.array = _topArray;
    [self.view addSubview:_topView];
    
    
    self.mTableView.top = SafeAreaTop_Height + _topView.height-1;
    self.mTableView.height -= _topView.height+1;
    self.mTableView.backgroundColor = [UIColor whiteColor];
    self.mTableView.backgroundView.backgroundColor = [UIColor whiteColor];
    
    
    _footerLab = [[UILabel alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 60)];
    _footerLab.textAlignment = NSTextAlignmentCenter;
    _footerLab.font = makeFont(14);
    _footerLab.textColor = makeColorHex(@"666666");
    _footerLab.text = @"没有更多啦";
    self.mTableView.tableFooterView = _footerLab;
    

    if(_FirstResponder){
        _FirstResponder = NO;
        [_mSearchBar becomeFirstResponder];
    }
    
}

//体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
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

//体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

//体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@""];
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
        _searchView = [[PBSearchView alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height)];
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



//开始搜索
-(void)startSearch{
    cout(@"开始搜索");
    self.isSearch = NO;
    [self.datas removeAllObjects];
    self.searchType = (PBSearchAllType)_topStyle+1;
    if(!_currentSender){
        [self startNetworking:@"特色服务"];
    }else{
        [self startNetworking:_currentSender.titleLabel.text];
    }
}


#pragma SSTableSwitchViewDelegate
-(void)SSTableScrollSwitchViewBtnClick:(UIButton *)sender{
    _topStyle = sender.tag-10;
    [self.datas removeAllObjects];
    self.searchType = (PBSearchAllType)_topStyle+1;
    
    _currentSender = sender;
    [self startNetworking:_currentSender.titleLabel.text];
    
}


//@"体检套餐",@"特色服务",@"医疗美容",@"科室",@"常见疾病",@"专家队伍"
-(void)setSearchType:(PBSearchAllType)searchType{
    _searchType = searchType;
    
    
    //体检套餐 特色服务 医疗美容 科室 常见疾病 专家队伍 食物
    if(_searchType == PBSearchAllType1){
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mSearchBar changeLeftPlaceholder:@"搜索体检套餐......"];
        self.mTableView.backgroundColor = BackGroundColor;
        self.mTableView.backgroundView.backgroundColor = BackGroundColor;
        _footerLab.backgroundColor = BackGroundColor;
        
    }else if(_searchType == PBSearchAllType2){
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mSearchBar changeLeftPlaceholder:@"搜索特色服务......"];
    }else if(_searchType == PBSearchAllType3){
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_mSearchBar changeLeftPlaceholder:@"搜索医疗美容......"];
    }else if(_searchType == PBSearchAllType4){
        self.mTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [_mSearchBar changeLeftPlaceholder:@"搜索科室......."];
    }
    
}



-(void)startNetworking:(NSString *)string{
   
}


//搜索
-(void)searchNetworking:(NSString *)urlString dic:(NSDictionary *)dic{
    
    cout(urlString);
    
}



@end

