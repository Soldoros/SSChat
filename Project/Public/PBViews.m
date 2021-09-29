//
//  PBViews.m
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "PBViews.h"


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
    if(section==0){
        _mLab.text = @"热门搜索";
    }else{
        _mLab.text = @"最近搜索";
    }
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
    
    if(_delegate && [_delegate respondsToSelector:@selector(PublicCellBtnClick:sender:)]){
        [_delegate PBCellBtnClick:self.indexPath sender:sender];
    }
}


@end



@implementation PBSearchView{
    NSArray *remenDatas;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        remenDatas = @[@"潮鞋",@"美妆",@"服装",@"3C",@"配饰",@"艺术"];
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _mCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout]; 
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
        
        _datas = [PBDatas getSearchHistory];
        [_mCollectionView reloadData];
    }
    return self;
    
}


-(void)setSearchType:(PBSearchAllType)searchType{
    _searchType = searchType;
    
    
    switch (_searchType) {
            //藏品
        case PBSearchAllType1:
            remenDatas = @[@"邮票",@"翡翠",@"陶瓷",@"珠宝",@"乾隆工艺品"];
            break;
            //圈子
        case PBSearchAllType2:
            remenDatas = @[@"冬天",@"成都",@"旅行",@"好去处",@"古玩"];
            break;
            //医院
        case PBSearchAllType3:
            remenDatas = @[@"健康",@"内科",@"中医",@"人民医院",@"盛世",@"华西"];
            break;
            //科室
        case PBSearchAllType4:
        remenDatas = @[@"肿瘤",@"内科",@"心脏病",@"饮食",@"医生",@"外科"];
        break;
        default:
            break;
    }
    
    [self.mCollectionView reloadData];
}


#pragma mark UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section==0)return remenDatas.count;
    else return _datas.count;
}

//段头段尾
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    PBSearchReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    header.section = indexPath.section;
    return header;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==0){
       
        PBSearchCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier :PBSearchCellId forIndexPath :indexPath];
        cell.backgroundColor = makeColorRgb(200, 200, 200);
        cell.searchString = remenDatas[indexPath.row];
        return cell;
    }else{
        PBSearchCell2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier :PBSearchCell2Id forIndexPath :indexPath];
        cell.delegate = self;
        cell.string = _datas[indexPath.row];
        return cell;
    }
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    
    NSString *string = @"";
    if(indexPath.section==0)string = remenDatas[indexPath.row];
    else string = _datas[indexPath.row];
    
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
    if(indexPath.section==0){
        return CGSizeMake ((self.width-60)/3,30);
    }else{
        return CGSizeMake (SCREEN_Width, PBSearchCell2H);
    }
}

//边界距离（上 左 下 右）
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    if(section==0){
        return UIEdgeInsetsMake ( 0 , 15 , 10 , 15 );
    }else{
        return UIEdgeInsetsMake ( 0 , 0 , 0 , 0);
    }
}

//左右间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if(section==0) return 15;
    else return 0;
}

//上下间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section==0) return 15;
    else return 0;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [[self getViewController].view endEditing:YES];
}


#pragma PBSearchCell2Delegate 删除最近搜索
-(void)PublicCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    
    [PBDatas deleteSearchHistory:_datas[indexPath.row]];
    _datas = [PBDatas getSearchHistory];
    
    NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
    _datas = reversedArray;
    
    [self.mCollectionView reloadData];
}



@end





//banner
@implementation PBBanner

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
       
        
         _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:self.bounds  imageNamesGroup:@[@"xiezi",@"xiezi",]];
         _cycleScrollView.backgroundColor = BackGroundColor;
         _cycleScrollView.placeholderImage = [UIImage imageNamed:@""];
         _cycleScrollView.delegate = self;
        _cycleScrollView.pageDotColor = makeColorHex(@"#333333");
        _cycleScrollView.currentPageDotColor = makeColorHex(@"#999999");
         [self addSubview:_cycleScrollView];
             
    }
    return self;
}


-(void)setBanners:(NSArray *)banners{
    _banners = banners;
    
    _cycleScrollView.imageURLStringsGroup = _banners;
    
}


-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if(_delegate && [_delegate respondsToSelector:@selector(BannerImageClick:object:)]){
        [_delegate BannerImageClick:index object:@{}];
       }
}

@end



//支付顶部视图
@implementation PBPayTopView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        
        _mPriceLab = [UILabel new];
          _mPriceLab.textColor = TitleColor;
        _mPriceLab.font = makeBlodFont(30);
          [self addSubview:_mPriceLab];
          _mPriceLab.text = @"¥380.00";
          [_mPriceLab sizeToFit];
          _mPriceLab.centerX = SCREEN_Width * 0.5;
          _mPriceLab.top = 60;
              
              
          _mDetailLab = [UILabel new];
           _mDetailLab.textColor = [UIColor colorWithHexString:@"#333333"];
          [self addSubview:_mDetailLab];
           _mDetailLab.font = [UIFont systemFontOfSize:13];
           _mDetailLab.text = @"剩余支付时间00：00";
           [_mDetailLab sizeToFit];
           _mDetailLab.centerX = SCREEN_Width * 0.5;
           _mDetailLab.top = _mPriceLab.bottom + 12;
              
              
              _time = 0;
    }
    return self;
}


//fragmentId = "-1";
//freightPrice = "0.00";
//payAmount = "225.60";
//prepayNo = 210820173505665555071;
-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    if(dataDic.count == 0)return;
    
    
    _mDetailLab.hidden = YES;

    _mPriceLab.text = makeString(@"￥", [dataDic[@"payAmount"]description]);
    [_mPriceLab sizeToFit];
    _mPriceLab.centerX = SCREEN_Width * 0.5;
    _mPriceLab.top = 30;
    
    _mDetailLab.text = @"剩余支付时间00:00";
    [_mDetailLab sizeToFit];
    _mDetailLab.centerX = SCREEN_Width * 0.5;
    _mDetailLab.top = _mPriceLab.bottom + 12;
    
    _time = 3453333;
    [self updateTime];
    if(self.timer == nil){
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            self.time --;
            [self updateTime];
        }];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
}


-(void)updateTime{
    
    if(_time>0){
        NSInteger h = _time/3600;
        NSInteger m = (_time%3600) / 60;
        NSInteger s = _time%3600 - 60*m;
        if(h>99){
            h = 99;
            m = 99;
            s = 99;
        }
        NSString *hs = makeStrWithInt(h);
        NSString *ms = makeStrWithInt(m);
        NSString *ss = makeStrWithInt(s);
        if(h<10)hs = makeString(@"0", hs);
        if(m<10)ms = makeString(@"0", ms);
        if(s<10)ss = makeString(@"0", ss);
        
        NSString *time = makeMoreStr(@"支付剩余",hs,@"时",ms,@"分",ss,@"秒",nil);
        NSDictionary *dic1 = @{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"#FE9F09"]};
        
        NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:time];
        [mutableString addAttributes:dic1 range:NSMakeRange(4,2)];
        [mutableString addAttributes:dic1 range:NSMakeRange(7,2)];
        [mutableString addAttributes:dic1 range:NSMakeRange(10,2)];
        _mDetailLab.attributedText = mutableString;
        [_mDetailLab sizeToFit];
        _mDetailLab.centerX = SCREEN_Width * 0.5;
        _mDetailLab.top = _mPriceLab.bottom + 12;
        
    }else{
        [_timer invalidate];
        _timer = nil;
        
        _mDetailLab.text = @"订单超时已失效";
        [_mDetailLab sizeToFit];
        _mDetailLab.centerX = SCREEN_Width * 0.5;
        _mDetailLab.top = _mPriceLab.bottom + 12;
    }
}

@end


//支付界面cell
@implementation PBPayCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
         self.backgroundColor = BackGroundColor;
               self.contentView.backgroundColor = BackGroundColor;
               
       _mBackImgView = [UIImageView new];
       _mBackImgView.bounds = makeRect(0, 0, SCREEN_Width-24, PBPayCellH);
       _mBackImgView.left = 12;
       _mBackImgView.top = 0;
       [self.contentView addSubview:_mBackImgView];
        _mBackImgView.backgroundColor = [UIColor whiteColor];
        _mBackImgView.layer.cornerRadius = 4;
       
       _mIcon = [UIImageView new];
       _mIcon.bounds = makeRect(0, 0, 25, 25);
       [_mBackImgView addSubview:_mIcon];
       _mIcon.left = 10;
       _mIcon.centerY = PBPayCellH * 0.5;
       
       
       _mTitleLab = [UILabel new];
       _mTitleLab.font = [UIFont systemFontOfSize:14];
       _mTitleLab.textColor = [UIColor colorWithHexString:@"#333333"];
       [_mBackImgView addSubview:_mTitleLab];
       
       
       _mRightIcon = [UIImageView new];
       _mRightIcon.bounds = makeRect(0, 0, 15, 15);
       _mRightIcon.image = [UIImage imageNamed:@"choice_nol"];
       _mRightIcon.right = _mBackImgView.width - 15;
       _mRightIcon.centerY = _mBackImgView.height * 0.5;
       [_mBackImgView addSubview:_mRightIcon];
    }
    return self;
}


-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    NSString *imgString = dataDic[@"imgUrl"];
    [_mIcon setImageWithURL:[NSURL URLWithString:imgString] placeholder:[UIImage imageFromColor:BackGroundColor]];
    
    
    //选中和未选中
    NSInteger choice = [dataDic[@"choice"]intValue];
    if(choice == 0){
        _mRightIcon.image = [UIImage imageNamed:@"choice_nol"];
    }else{
        _mRightIcon.image = [UIImage imageNamed:@"choice_sel"];
    }
    
    
    _mTitleLab.text = dataDic[@"payName"];
    [_mTitleLab sizeToFit];
    _mTitleLab.centerY = PBPayCellH * 0.5;
    _mTitleLab.left = _mIcon.right + 12;
}


@end


//搜索的商品列表
@implementation PBGoodsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor whiteColor];
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        _mIcon = [UIImageView new];
        _mIcon.bounds = makeRect(0, 0, 120, 120);
        [self.contentView addSubview:_mIcon];
        _mIcon.centerY = PBGoodsCellH * 0.5;
        _mIcon.left = 10;
        _mIcon.backgroundColor = BackGroundColor;
        
         _mTitleLab1 = [UILabel new];
        _mTitleLab1.bounds = makeRect(0, 0, SCREEN_Width - _mIcon.right - 20, 20);
        _mTitleLab1.numberOfLines = 2;
        [self.contentView addSubview:_mTitleLab1];
          _mTitleLab1.textAlignment = NSTextAlignmentLeft;
          _mTitleLab1.font = makeFont(14);
          _mTitleLab1.textColor = makeColorHex(@"#222222");
        
        NSString *string = @"新西兰进口奇异果zespri金果黄猕猴桃新鲜水果";
        setLabHeight(_mTitleLab1, string, 4);
          [_mTitleLab1 sizeToFit];
        _mTitleLab1.left = _mIcon.right + 10;
        _mTitleLab1.top = _mIcon.top;
        
        
        _mTitleLab2 = [UILabel new];
        _mTitleLab2.bounds = makeRect(0, 0, 100, 20);
        _mTitleLab2.numberOfLines = 2;
        [self.contentView addSubview:_mTitleLab2];
          _mTitleLab2.textAlignment = NSTextAlignmentLeft;
          _mTitleLab2.font = makeFont(16);
          _mTitleLab2.textColor = makeColorHex(@"#FF3B33");
        _mTitleLab2.text = @"￥48.9";
          [_mTitleLab2 sizeToFit];
        _mTitleLab2.left = _mIcon.right + 10;
        _mTitleLab2.centerY = _mIcon.centerY;
        
        
        _mTitleLab3 = [UILabel new];
        _mTitleLab3.bounds = makeRect(0, 0, 35, 18);
        _mTitleLab3.backgroundColor = TitleColor;
        _mTitleLab1.clipsToBounds = YES;
        _mTitleLab1.layer.cornerRadius = 2;
        [self.contentView addSubview:_mTitleLab3];
          _mTitleLab3.textAlignment = NSTextAlignmentCenter;
          _mTitleLab3.font = makeFont(12);
          _mTitleLab3.textColor = makeColorHex(@"#FFFFFF");
        _mTitleLab3.text = @"自营";
        _mTitleLab3.left = _mIcon.right + 10;
        _mTitleLab3.bottom = _mIcon.bottom - 4;
        
        _mTitleLab4 = [UILabel new];
        _mTitleLab4.bounds = makeRect(0, 0, 65, 18);
        _mTitleLab4.backgroundColor = makeColorHex(@"#FCB50F");
        _mTitleLab4.clipsToBounds = YES;
        _mTitleLab4.layer.cornerRadius = 2;
        [self.contentView addSubview:_mTitleLab4];
          _mTitleLab4.textAlignment = NSTextAlignmentCenter;
          _mTitleLab4.font = makeFont(12);
          _mTitleLab4.textColor = makeColorHex(@"#FFFFFF");
        _mTitleLab4.text = @"满减产品";
        _mTitleLab4.left = _mTitleLab3.right + 10;
        _mTitleLab4.bottom = _mIcon.bottom - 4;
        
        
        _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:_mButton];
        _mButton.bounds = makeRect(0, 0, 25, 25);
        [_mButton setImage:[UIImage imageNamed:@"cang153"] forState:UIControlStateNormal];
        _mButton.right = SCREEN_Width - 13;
        _mButton.bottom = _mIcon.bottom;
        [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(PBCellBtnClick:sender:)]){
        [_delegate PBCellBtnClick:_indexPath sender:sender];
    }
}

-(void)setDataDic:(NSDictionary *)dataDic{
    
}

@end
