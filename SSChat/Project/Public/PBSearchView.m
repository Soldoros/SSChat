//
//  PBSearchView.m
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "PBSearchView.h"


@implementation PBSearchTableHeader

- (instancetype)initWithFrame:(CGRect)frame placeholder:(NSString *)placeholder
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        
        _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _searchBtn.bounds = CGRectMake(0, 0, SCREEN_Width-25, 38);
        _searchBtn.centerX = self.width * 0.5;
        _searchBtn.centerY = self.height * 0.5;
        [self addSubview:_searchBtn];
        _searchBtn.clipsToBounds = YES;
        _searchBtn.layer.cornerRadius = 6;
        [_searchBtn setBackgroundImage:[UIImage imageWithColor:makeColorHex(@"F7F7F7")] forState:UIControlStateNormal];
        _searchBtn.showsTouchWhenHighlighted = YES;
        [_searchBtn addTarget:self action:@selector(searchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _mSearchBar = [[UISearchBar alloc]init];
        _mSearchBar.frame = _searchBtn.bounds;
        [_searchBtn addSubview:_mSearchBar];
        _mSearchBar.clipsToBounds = YES;
        _mSearchBar.layer.cornerRadius = 6;
        [_mSearchBar setReturnKeyType:UIReturnKeyDone];
        _mSearchBar.delegate = self;
        _mSearchBar.placeholder = placeholder;
        _mSearchBar.showsCancelButton = NO;
        _mSearchBar.enablesReturnKeyAutomatically = NO;
        _mSearchBar.barTintColor = [UIColor clearColor];
        _mSearchBar.tintColor=[UIColor blackColor];
        [[[[_mSearchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
        [_mSearchBar setBackgroundColor:[UIColor clearColor]];
        _mSearchBar.userInteractionEnabled = NO;
        
        [_mSearchBar setImage:[[UIImage imageNamed:@"icon_sousuo"] imageWithColor:makeColorHex(@"#999999")]
             forSearchBarIcon:UISearchBarIconSearch
                        state:UIControlStateNormal];
        
        UITextField *searchField = [_mSearchBar valueForKey:@"searchField"];
        if (searchField) {
            [searchField setBackgroundColor:[UIColor clearColor]];
            searchField.clipsToBounds = YES;
            searchField.layer.cornerRadius = 6;
            [searchField setFont:[UIFont systemFontOfSize:16]];
            searchField.tintColor = makeColorHex(@"C7C7C7");
            [searchField setValue:makeColorHex(@"C7C7C7") forKeyPath:@"_placeholderLabel.textColor"];
            searchField.textColor = makeColorHex(@"333333");
        }
    }
    return self;
}

-(void)searchButtonClick:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchTableHeaderBtnClick:)]){
        [_delegate PBSearchTableHeaderBtnClick:sender];
    }
}

@end


@implementation PBSearchReusableView
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        _mLab = [UILabel new];
        _mLab.frame = makeRect(15, 0, self.width-15, self.height);
        [self addSubview:_mLab];
        _mLab.font = makeFont(16);
        _mLab.textAlignment = NSTextAlignmentLeft;
        
    }
    return self;
}

- (void)setSection:(NSInteger)section{
    _section = section;
    _mLab.text = @"最近搜索";
}

@end

/**
 cell
 */
@implementation PBSearchCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = self.bounds;
        [self.contentView addSubview:_mLab];
        _mLab.backgroundColor = [UIColor whiteColor];
        _mLab.clipsToBounds = YES;
        _mLab.layer.cornerRadius = self.height*0.5;
        _mLab.layer.borderColor = makeColorHex(@"999999").CGColor;
        _mLab.layer.borderWidth = 1;
        _mLab.textAlignment = NSTextAlignmentCenter;
        _mLab.font = makeFont(14);
        _mLab.textColor = makeColorHex(@"999999");
        
    }
    return self;
}

-(void)setSearchString:(NSString *)searchString{
    _searchString = searchString;
    _mLab.text = _searchString;
}

@end



/**
 cell2
 */
@implementation PBSearchCell2

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = makeRect(15, 0, SCREEN_Width-50, PBSearchCell2H);
        [self.contentView addSubview:_mLab];
        _mLab.textAlignment = NSTextAlignmentLeft;
        _mLab.font = makeFont(14);
        _mLab.textColor = makeColorHex(@"666666");
        
        _mLine = [UIView new];
        _mLine.bounds = makeRect(0, 0, SCREEN_Width-15, 0.5);
        _mLine.bottom = PBSearchCell2H;
        _mLine.left = 15;
        _mLine.backgroundColor = CellLineColor;
        [self.contentView addSubview:_mLine];
        
        UIImage *img = [UIImage imageNamed:@"guanbi"];
        _mDeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mDeleteBtn.bounds = makeRect(0, 0, 15, 15);
        _mDeleteBtn.right = SCREEN_Width-20;
        _mDeleteBtn.centerY = self.height*0.5;
        [self.contentView addSubview:_mDeleteBtn];
        [_mDeleteBtn setImage:[img imageWithColor:makeColorHex(@"999999")]  forState:UIControlStateNormal];
        [_mDeleteBtn addTarget:self action:@selector(buttonPressed:)  forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

-(void)setString:(NSString *)string{
    _mLab.text = string;
}

-(void)buttonPressed:(UIButton *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchCell2BtnClick:)]){
        [_delegate PBSearchCell2BtnClick:self.indexPath];
    }
}


@end


//搜索输入界面
@implementation PBSearchView{
    NSArray *remenDatas;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        remenDatas = @[@"肿瘤",@"内科",@"心脏病",@"饮食",@"医生",@"美容"];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _mCollectionView = [[UICollectionView alloc]initWithFrame:makeRect(0, 0, self.width,self.height) collectionViewLayout:flowLayout];
        _mCollectionView.showsVerticalScrollIndicator = TRUE;
        _mCollectionView.showsHorizontalScrollIndicator = TRUE;
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        _mCollectionView.alwaysBounceVertical = YES;
        _mCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mCollectionView];
        [_mCollectionView registerClass:[PBSearchCell class] forCellWithReuseIdentifier:PBSearchCellId];
        [_mCollectionView registerClass:[PBSearchCell2 class] forCellWithReuseIdentifier:PBSearchCell2Id];
        [_mCollectionView registerClass:[PBSearchReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if([user arrayForKey:USER_Serchhistory]){
            _datas = [user arrayForKey:USER_Serchhistory];
            NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
            _datas = reversedArray;
        }
        [_mCollectionView reloadData];
    }
    return self;
    
}


-(void)setSearchType:(PBSearchAllType)searchType{
    _searchType = searchType;
    
    [self.mCollectionView reloadData];
}


#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

//段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PBSearchReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.section = indexPath.section;
    return header;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    PBSearchCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier :PBSearchCell2Id forIndexPath :indexPath];
    cell.indexPath = indexPath;
    cell.string = _datas[indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    
    NSString *string = _datas[indexPath.row];
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchCellClick:result:)]){
        [_delegate PBSearchCellClick:indexPath result:string];
    }
}

#pragma mark --UICollectionViewDelegateFlowLayout
//header尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return (CGSize){self.width,60};
}

//item的尺寸
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    return CGSizeMake (SCREEN_Width, PBSearchCell2H);
}

//边界距离（上 左 下 右）
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0);
}

//左右间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//上下间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[self getViewController].view endEditing:YES];
}


#pragma PBSearchCell2Delegate 删除最近搜索
-(void)PBSearchCell2BtnClick:(NSIndexPath *)indexPath{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[user objectForKey:USER_Serchhistory]];
    [array removeObject:_datas[indexPath.row]];
    [user setObject:array forKey:USER_Serchhistory];
    
    _datas = [user arrayForKey:USER_Serchhistory];
    NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
    _datas = reversedArray;
    
    [self.mCollectionView reloadData];
}



@end



//搜索结果header
@implementation PBSearchHeader
{
    UIButton *button1,*button2,*button3,*button4,*currentBtn;
    SearchResultState state;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        //价格升序
        state = SearchResultStateUp;
        
        UIButton *btn[4];
        NSArray *titles = @[@"分类",@"类型",@"销量",@"价格"];
        NSArray *images1 = @[@"下-hui",@"下-hui",@"",@"组-22"];
        NSArray *images2 = @[@"上",@"上",@"",@"priceshang"];
        
        for(int i=0;i<titles.count;++i){
            btn[i] = [UIButton buttonWithType:UIButtonTypeCustom];
            btn[i].bounds = makeRect(0, 0, 70, self.height-1);
            btn[i].centerX = self.width/titles.count*0.5 + i*(self.width/titles.count);
            btn[i].top = 0;
            btn[i].titleLabel.font = makeFont(16);
            [btn[i] setTitle:titles[i] forState:UIControlStateNormal];
            [btn[i] setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [btn[i] setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self addSubview:btn[i]];
            btn[i].selected = NO;
            btn[i].tag = 10+i;
            [btn[i] addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            [btn[i] setImage:[UIImage imageNamed:images1[i]] forState:UIControlStateNormal];
            [btn[i] setImage:[UIImage imageNamed:images2[i]] forState:UIControlStateSelected];
            
            if(i!=2){
                [self textImage:btn[i]];
            }
            
        }
        
        button1 = btn[0];
        button2 = btn[1];
        button3 = btn[2];
        button4 = btn[3];
        
        UIView *line = [UIView new];
        line.backgroundColor = CellLineColor;
        line.bounds = makeRect(0, 0, self.width, 0.5);
        line.left = 0;
        line.bottom = self.bottom;
        [self addSubview:line];
        
    }
    return self;
}


//设置按钮的名称 并置灰
-(void)setbuttonDic:(NSDictionary *)dict{
    NSString *title = dict[_keyString];
    [currentBtn setTitle:title forState:UIControlStateNormal];
    [self textImage:currentBtn];
    if(currentBtn == button1) {
       [button2 setTitle:@"类型" forState:UIControlStateNormal];
        [self textImage:button2];
    }else{
        [button1 setTitle:@"分类" forState:UIControlStateNormal];
        [self textImage:button1];
    }
    currentBtn.selected = NO;
    currentBtn = nil;
}


//文字居左 图片居右
-(void)textImage:(UIButton *)button{
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -button.imageView.size.width, 0, button.imageView.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, button.titleLabel.bounds.size.width+5, 0, -button.titleLabel.bounds.size.width)];
}


//分类10 类型11 销量12 价格13
-(void)buttonPressed:(UIButton *)sender{
    UIButton *crBtn = currentBtn;
    UIButton *sdBtn = sender;
    state = SearchResultStateUp;
    
    if(currentBtn==sender && sender==button3)return;
    
    if(sender == button1 || sender==button2){
        if(currentBtn == sender){
            currentBtn.selected = !currentBtn.selected;
        }else if(currentBtn==button4){
            currentBtn.selected = NO;
            [currentBtn setImage:[UIImage imageNamed:@"组-22"] forState:UIControlStateNormal];
            [currentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            currentBtn = sender;
            currentBtn.selected = YES;
        }else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
    }
    if(sender == button3){
        if(currentBtn==button4){
            currentBtn.selected = NO;
            [currentBtn setImage:[UIImage imageNamed:@"组-22"] forState:UIControlStateNormal];
            [currentBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            currentBtn = sender;
            currentBtn.selected = YES;
        }
        else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
    }
    if(sender == button4){
        if(currentBtn==sender){
            currentBtn.selected = !currentBtn.selected;
        }else{
            currentBtn.selected = NO;
            currentBtn = sender;
            currentBtn.selected = YES;
        }
        [currentBtn setImage:[UIImage imageNamed:@"pricexia"] forState:UIControlStateNormal];
        [currentBtn setImage:[UIImage imageNamed:@"priceshang"] forState:UIControlStateSelected];
        [currentBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if(currentBtn.selected == YES)state = SearchResultStateUp;
        if(currentBtn.selected == NO) state = SearchResultStateDown;
    }
    
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchHeaderBtnClick:currentBtn:state:)]){
        [_delegate PBSearchHeaderBtnClick:sdBtn currentBtn:crBtn state:state];
    }
}



@end








//分类 类型弹出视图
@implementation PBSearchClassTypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _mCollectionView = [[UICollectionView alloc]initWithFrame:makeRect(0, 0, self.width,self.height) collectionViewLayout:flowLayout];
        _mCollectionView.showsVerticalScrollIndicator = TRUE;
        _mCollectionView.showsHorizontalScrollIndicator = TRUE;
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        _mCollectionView.alwaysBounceVertical = YES;
        _mCollectionView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_mCollectionView];
        [_mCollectionView registerClass:[PBSearchClassTypeCell class] forCellWithReuseIdentifier:@"cell"];
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if([user arrayForKey:USER_Serchhistory]){
            _datas = [user arrayForKey:USER_Serchhistory];
        }
        [_mCollectionView reloadData];
    }
    return self;
    
}

-(void)setDatas:(NSArray *)datas{
    _datas =datas;
    [_mCollectionView reloadData];
    
}


#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PBSearchClassTypeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier :@"cell" forIndexPath :indexPath];
    cell.backgroundColor = makeColorRgb(200, 200, 200);
    cell.keyString = _keyString;
    cell.searchDic = _datas[indexPath.row];
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    if(_delegate && [_delegate respondsToSelector:@selector(PBSearchClassTypeViewCellBtnClick:keyString:)]){
        [_delegate PBSearchClassTypeViewCellBtnClick:_datas[indexPath.row] keyString:_keyString];
    }
    
}

#pragma mark --UICollectionViewDelegateFlowLayout

//item的尺寸
- ( CGSize )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:( NSIndexPath *)indexPath{
    return CGSizeMake (self.width/2,45);
}

//边界距离（上 左 下 右）
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake ( 0 , 0 , 0 , 0 );
}

//左右间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//上下间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

@end





/**
 cell
 */
@implementation PBSearchClassTypeCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLab = [UILabel new];
        _mLab.frame = self.bounds;
        [self.contentView addSubview:_mLab];
        _mLab.textAlignment = NSTextAlignmentCenter;
        _mLab.font = makeFont(14);
        
    }
    return self;
}

-(void)setSearchDic:(NSDictionary *)searchDic{
    _mLab.text = searchDic[_keyString];
}


@end







//搜索医生结果cell
@implementation PBSearchFriendCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mLeftImgView = [UIImageView new];
        _mLeftImgView.bounds = CGRectMake(0, 0, 35, 35);
        _mLeftImgView.left = 10;
        _mLeftImgView.centerY = PBSearchFriendCellH * 0.5;
        _mLeftImgView.clipsToBounds = YES;
        _mLeftImgView.backgroundColor = [UIColor colora];
        _mLeftImgView.layer.cornerRadius = _mLeftImgView.height * 0.5;
        [self.contentView addSubview:_mLeftImgView];
        
        _mTitleLab = [UILabel new];
        _mTitleLab.bounds = makeRect(0, 0, 100, 30);
        _mTitleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:_mTitleLab];
        _mTitleLab.font = makeFont(16);
        
    }
    return self;
}

//通讯列表数据
-(void)setUser:(NIMUser *)user{
    _user = user;
    
    [[NIMSDK sharedSDK].resourceManager fetchNOSURLWithURL:user.userInfo.avatarUrl completion:^(NSError * _Nullable error, NSString * _Nullable urlString) {
        
        [self.mLeftImgView setImageWithURL:[NSURL URLWithString:urlString] placeholder:[UIImage imageNamed:@"user_avatar_blue"] options:YYWebImageOptionIgnoreAnimatedImage completion:nil];
    }];
    
    
    _mTitleLab.text = _user.userInfo.nickName ? _user.userInfo.nickName : _user.userId;
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = _mLeftImgView.centerY;
    _mTitleLab.left = _mLeftImgView.right + 15;
    
}

@end






