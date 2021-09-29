//
//  SSInputMoreView.m
//  Project
//
//  Created by soldoros on 2021/9/9.
//

#import "SSInputMoreView.h"



//输入框更多弹窗
@interface SSInputMoreView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation SSInputMoreView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        _datas = [NSMutableArray new];
        _mItemCount = 4;
        _mSectionCount = 1;
        
        _mLine = [UIView new];
        [self addSubview:_mLine];
        _mLine.frame = CGRectMake(0, 0, self.width, 0.5);
        _mLine.backgroundColor = CellLineColor;

        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(SSInputMoreCellW, SSInputMoreCellH);
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.collectionView.contentInset =  UIEdgeInsetsMake(0, 0, 0, 0);

        _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, _mLine.bottom, self.width, self.height - 30) collectionViewLayout:_layout];
        [self addSubview:_mCollectionView];
        _mCollectionView.backgroundColor = BackGroundColor;
        _mCollectionView.backgroundView.backgroundColor = BackGroundColor;
        _mCollectionView.bounces = YES;
        _mCollectionView.dataSource = self;
        _mCollectionView.delegate = self;
        _mCollectionView.pagingEnabled = YES;
        _mCollectionView.showsHorizontalScrollIndicator = NO;
        _mCollectionView.showsVerticalScrollIndicator = NO;
        _mCollectionView.alwaysBounceHorizontal = YES;
        [_mCollectionView registerClass:[SSInputMoreCell class] forCellWithReuseIdentifier:SSInputMoreCellId];
        [_mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        [_mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
        
        
        _mPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 10)];
        [self addSubview:_mPageControl];
        _mPageControl.numberOfPages = _mSectionCount;
        _mPageControl.centerX = self.width * 0.5;
        _mPageControl.bottom = self.height - 15;
        _mPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _mPageControl.pageIndicatorTintColor = [UIColor grayColor];
        _mPageControl.userInteractionEnabled = NO;
        [_mPageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_mPageControl setPageIndicatorTintColor:makeColorRgb(200, 200, 200)];

        self.datas = (NSMutableArray *)@[@{@"img":@"zhaopian",@"name":@"图片"},@{@"img":@"shipin",@"name":@"视频"},@{@"img":@"yuyin",@"name":@"语音"},@{@"img":@"weizhi",@"name":@"位置"},@{@"img":@"hongbao",@"name":@"红包"},@{@"img":@"zhuanzhang",@"name":@"转账"},@{@"img":@"weizhi",@"name":@"文件"}];
        
    }
    return self;
}

-(void)setDatas:(NSMutableArray *)datas{
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:datas];
    while (_datas.count % 8 != 0) {
        [_datas addObject:@{@"img":@"",@"name":@""}];
    }
    
    _mItemCount = 2 * SSInputMoreRowCount;
    _mSectionCount = ceil(_datas.count / 8.0);
    _mPageControl.numberOfPages = _mSectionCount;
    [self setIndex];
    [_mCollectionView reloadData];
}

//横向列表是纵向排列，这里需要处理布局排序
-(void)setIndex{
            
    _mItemIndexs = [NSMutableDictionary new];
    for (NSInteger i = 0; i < _mSectionCount; ++i) {
        for (NSInteger j = 0; j < _mItemCount; ++j) {
            
            NSInteger row = j % 2;
            NSInteger column = j / 2;
            NSInteger reIndex = SSInputMoreRowCount * row + column + i * _mItemCount;
            [_mItemIndexs setObject:@(reIndex) forKey:[NSIndexPath indexPathForRow:j inSection:i]];
        }
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _mSectionCount;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _mItemCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *index = _mItemIndexs[indexPath];
    SSInputMoreCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SSInputMoreCellId forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.dataDic = _datas[index.integerValue];
    return cell;
}

//点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSNumber *index = _mItemIndexs[indexPath];
    NSDictionary *dic = _datas[index.integerValue];
    if([dic[@"name"]length] == 0)return;
    
    if(_delegate && [_delegate respondsToSelector:@selector(inputMoreView:didSelect:)]){
        [_delegate inputMoreView:self didSelect:dic];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _mCollectionView) {
        _mPageControl.numberOfPages = _mSectionCount;
        _mPageControl.currentPage = ceil(_mCollectionView.contentOffset.x / self.width);
    }
}



@end



@implementation SSInputMoreCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
        
        _mImgView = [UIImageView new];
        [self.contentView addSubview:_mImgView];
        _mImgView.bounds = makeRect(0, 0, 50, 50);
        _mImgView.centerX = self.width * 0.5;
        _mImgView.top = 20;
        
        _mLabel = [UILabel new];
        [self.contentView addSubview:_mLabel];
        _mLabel.bounds = CGRectMake(0, 0, 80, 20);
        _mLabel.font = [UIFont systemFontOfSize:12];
        _mLabel.textColor = makeColorHex(@"#666666");
        _mLabel.textAlignment = NSTextAlignmentCenter;
        
    }
    return self;
}

-(void)setDataDic:(NSDictionary *)dataDic{
    _dataDic = dataDic;
    
    _mImgView.hidden = YES;
    _mLabel.hidden = YES;
    NSString *img = dataDic[@"img"];
    NSString *name = dataDic[@"name"];
    
    if(img.length>0){
        
        _mImgView.hidden = NO;
        _mLabel.hidden = NO;
        
        _mImgView.image = [UIImage imageNamed:img];
        if(_indexPath.row%2 == 0)_mImgView.top = 18;
        if(_indexPath.row%2 != 0)_mImgView.top = 8;
        
        _mLabel.text = name;
        [_mLabel sizeToFit];
        _mLabel.centerX = self.width * 0.5;
        _mLabel.top = _mImgView.bottom + 8;
    }
    
}

@end
