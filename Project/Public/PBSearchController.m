//
//  PBSearchController.m
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "PBSearchController.h"

@interface PBSearchController ()<UITextFieldDelegate,PBViewsDelegate>

@property(nonatomic,assign)BOOL frist;
@property(nonatomic,assign)BOOL searchFrist;

//搜索状态和历史记录 历史记录数据
@property(nonatomic,strong)PBSearchView *searchView;

@property(nonatomic,strong)UIButton *searchBtn;
@property(nonatomic,strong)UIImageView *mSearchImg;
@property(nonatomic,strong)UITextField *searchField;

@end

@implementation PBSearchController

-(instancetype)init{
    if(self = [super init]){
        _FirstResponder = YES;
        _frist = YES;
        _searchFrist = YES;
        
        self.isSearch = NO;
        _searchString = @"";
        self.user = [NSUserDefaults standardUserDefaults];
      
        self.page = 1;
        self.datas = [NSMutableArray new];
    }
    return self;
}

-(void)setTextFPlaceHolder:(NSString *)string{
    NSMutableAttributedString *placeholderString = [[NSMutableAttributedString alloc] initWithString:string attributes:@{NSForegroundColorAttributeName : makeColorHex(@"#999999")}];
    _searchField.attributedPlaceholder = placeholderString;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setRightOneBtnTitle:@"取消"];
    [self.rightBtn1 setTitle:@"搜索"  forState:UIControlStateSelected];
    self.navLine.hidden = YES;
    
    
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.bounds = CGRectMake(0, 0, SCREEN_Width-105, 32);
    _searchBtn.left = 45;
    _searchBtn.centerY = StatuBar_Height+NavBar_Height*0.5;
    [self.navtionBar addSubview:_searchBtn];
    _searchBtn.clipsToBounds = YES;
    _searchBtn.layer.cornerRadius = _searchBtn.height * 0.5;
    [_searchBtn setBackgroundImage:[UIImage imageWithColor:makeColorHex(@"#F6F6F6")] forState:UIControlStateNormal];
    
    
     _mSearchImg = [UIImageView new];
      _mSearchImg.bounds = makeRect(0, 0, 15, 15);
      _mSearchImg.image = [UIImage imageNamed:@"sousuo"];
      [_searchBtn addSubview:_mSearchImg];
      _mSearchImg.left = 10;
      _mSearchImg.centerY = _searchBtn.height * 0.5;
    _mSearchImg.userInteractionEnabled = YES;
    
      _searchField = [UITextField new];
      _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
      _searchField.frame = makeRect(40, 0, _searchBtn.width - 50, _searchBtn.height);
      [_searchBtn addSubview:_searchField];
      _searchField.delegate = self;
      _searchField.font = [UIFont systemFontOfSize:14];
      _searchField.textColor = makeColorHex(@"#333333");
      _searchField.tintColor = makeColorHex(@"#999999");
     [self setTextFPlaceHolder:@"输入模特ID..."];
      [_searchField addTarget:self action:@selector(textClick:) forControlEvents:UIControlEventEditingChanged];
    
    [self.view bringSubviewToFront:self.navtionBar];
    
    self.mCollectionView.top -= 1;
    self.mCollectionView.height += 1;
    [self.mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    
    if(_FirstResponder){
        _FirstResponder = NO;
        [_searchField becomeFirstResponder];
    }

    self.mCollectionView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        [self searchNetworking];
    }];
    
    self.mCollectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.page ++;
        [self searchNetworking];
    }];
    
}



#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
//分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREEN_Width, 10);
}


//区尾大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{

    return CGSizeMake(SCREEN_Width, 20);
}

//每个分区的内边距（上左下右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 12, 0, 12);
    
}


//创建区头视图和区尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        return headerView;
    }else if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
    
}


//每个分区item的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.datas.count;
}

//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return makeSize(SCREEN_Width, 50);
}


//分区内cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{

    return 10;
}

//分区内cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
 
     return 8;
}

//创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    return [UICollectionViewCell new];
}


#pragma SSCollectionViewFlowLayoutDelegate  分组返回灰色
-(UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout{
    return [UIColor whiteColor];
}


//点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
    
}

-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if(!_frist){
        _frist = NO;
        return;
    }
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
        [_searchField endEditing:YES];
        self.rightBtn1.selected = NO;
    }else{
        [self addSearchView];
    }
}


//加载搜索历史
-(void)addSearchView{
    if(!_searchView){
        _searchView = [[PBSearchView alloc]initWithFrame:self.mCollectionView.frame];
    }
    _searchView.delegate = self;
    [self.view addSubview:_searchView];
}

//删除搜索历史
-(void)removeSearch{
    if(_searchView){
        [_searchField endEditing:YES];
        [_searchView removeFromSuperview];
        _searchView = nil;
    }
}



//开始输入
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    self.isSearch = YES;
    [self textClick:_searchField];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    if(_searchField.text.length>0){
        [PBDatas saveSearchHistory:_searchField.text];
    }
    _searchString = _searchField.text;
}

#pragma mark PBSearchViewDelegate 开始搜索
-(void)PBSearchCellClick:(NSIndexPath *)indexPath result:(NSString *)result{

    _searchFrist = NO;
    _searchString = result;
    _searchField.text = result;
    if(_searchField.text.length>0){
        [PBDatas saveSearchHistory:_searchField.text];
    }
    [self startSearch];
}


-(void)navgationButtonPressed:(UIButton *)sender{
    if(sender.tag == 10){
        [self.navigationController popViewControllerAnimated:YES];
    }
    else{
        if(self.rightBtn1.selected){
            if(_searchField.text.length>0){
                [PBDatas saveSearchHistory:_searchField.text];
            }
            _searchString = _searchField.text;
            [self startSearch];
        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//回车判断
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
        if(_searchField.text.length>0){
            [PBDatas saveSearchHistory:_searchField.text];
        }
        _searchString = _searchField.text;
        [self startSearch];
    }
    
    return YES;
}


-(void)startSearch{
    cout(@(self.navtionBar.userInteractionEnabled));
    cout(@(self.navtionImgView.userInteractionEnabled));
    
    cout(@"开始搜索");
    [self.datas removeAllObjects];
    self.isSearch = NO;
    _searchString = [_searchString stringByReplacingOccurrencesOfString:@" " withString:@""];

    [self setLoadingStatus];
}

-(void)setLoadingStatus{
    
    [self deleteLoadingStatus];
    [self searchNetworking];
    
    self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.mCollectionView.frame superView:self.view];
}


-(void)deleteLoadingStatus{
    
    [self.loadingStatus.mActivityImg.layer removeAllAnimations];
    [self.loadingStatus removeFromSuperview];
    self.loadingStatus = nil;
}

//搜索
-(void)searchNetworking{
    

    NSDictionary *dic = @{@"page":@(self.page),
                          @"categoryType":@"-1",
                          @"wd":_searchString
    };
    
    [SSAFRequest RequestNetWorking:SSRequestGetHeader parameters:dic method:URLGoodsSearch requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [self deleteLoadingStatus];
        [self.mCollectionView.mj_header endRefreshing];
        [self.mCollectionView.mj_footer endRefreshing];

        if(error){
            
            self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.loadFrame superView:self.view loadingBlock:^(SSRequestStatusCode statusCode) {
                [self setLoadingStatus];
            }];
           }else{
               
               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);
               
               if([dict[@"code"] integerValue] != 0){
                   NSString *message = dict[@"msg"];
                   self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.loadFrame superView:self.view message:message loadingBlock:^(SSRequestStatusCode statusCode) {
                       [self setLoadingStatus];
                   }];
               }
               else{
                   
                   if(self.page == 1){
                       [self.datas removeAllObjects];
                   }
                   [self.datas addObjectsFromArray:dict[@"data"][@"recordList"]];
                   [self.mCollectionView reloadData];
                   if(self.datas.count == 0){
                       self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.mCollectionView.frame superView:self.view statusCode:SSRequestStatusVaule12 loadingBlock:^(SSRequestStatusCode statusCode) {
                           [self setLoadingStatus];
                       }];
                   }
               }
           }
       }];
    
}


@end
