//
//  SSInputFaceView.m
//  Project
//
//  Created by soldoros on 2021/9/16.
//

//表情窗口
#import "SSInputFaceView.h"

@implementation SSInputFaceView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        _datas = [NSMutableArray new];
        
        _mMenuView = [[SSInputMenuView alloc]initWithFrame:makeRect(0, self.height - SSInputMenuViewH, self.width, SSInputMenuViewH)];
        _mMenuView.delegate = self;
        [self addSubview:_mMenuView];
        
        
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(SSInputFaceCellW, SSInputFaceCellH);
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.collectionView.contentInset =  UIEdgeInsetsMake(0, 0, 0, 0);

        _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.width, SSInputFaceCollectionH) collectionViewLayout:_layout];
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
        [_mCollectionView registerClass:[SSInputFaceCell class]  forCellWithReuseIdentifier:SSInputFaceCellId];
        [_mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
        [_mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
        
        
        _mPageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 0, 200, 10)];
        [self addSubview:_mPageControl];
        _mPageControl.numberOfPages = 4;
        _mPageControl.centerX = self.width * 0.5;
        _mPageControl.bottom = self.height - SSInputMenuViewH - 15;
        _mPageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _mPageControl.pageIndicatorTintColor = [UIColor grayColor];
        _mPageControl.userInteractionEnabled = NO;
        [_mPageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_mPageControl setPageIndicatorTintColor:makeColorRgb(200, 200, 200)];
        
    }
    return self;
}

-(void)setDatas:(NSMutableArray *)datas{
    [_datas removeAllObjects];
    [_datas addObjectsFromArray:datas];
    
    CGFloat pageNumer = SSChatEmojiRow * SSChatEmojiLine;
    _mPageControl.numberOfPages = ceil(_datas.count / pageNumer);
    
    if(_datas.count>0)self.mMenuView.faceString = _datas[0];
    [self.mCollectionView reloadData];
    
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SSInputFaceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SSInputFaceCellId forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.faceString = _datas[indexPath.row];
    return cell;
}

//点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    SSInputFaceCell *cell = (SSInputFaceCell *)[_mCollectionView cellForItemAtIndexPath:indexPath];
    [self inputMenuViewButtonClick:cell.mButton];
}

//底部菜单栏点击回调 + 当前列表cell点击回调
//表情10 发送50  删除51  标签分类100+
-(void)inputMenuViewButtonClick:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(inputFaceViewDidBtnClick:sender:)]){
        [_delegate inputFaceViewDidBtnClick:self sender:sender];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == _mCollectionView) {
        CGFloat pageNumer = SSChatEmojiRow * SSChatEmojiLine;
        _mPageControl.numberOfPages = ceil(_datas.count / pageNumer);
        _mPageControl.currentPage = ceil(_mCollectionView.contentOffset.x / self.width);
    }
}
 

@end



//表情cell
@implementation SSInputFaceCell

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = BackGroundColor;
        self.contentView.backgroundColor = BackGroundColor;
        
        _mButton = [[UIButton alloc] init];
        _mButton.tag = 10;
        _mButton.userInteractionEnabled = false;
        [self.contentView addSubview:_mButton];
        _mButton.frame = self.contentView.bounds;

    }
    return self;
}

-(void)setFaceString:(NSString *)faceString{
    _faceString = faceString;
    
    if ([_faceString isEqualToString: DeleteButtonId]) {
        [_mButton setTitle:nil forState:UIControlStateNormal];
        [_mButton setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
        [_mButton setImage:[UIImage imageNamed:@"DeleteEmoticonBtnHL"] forState:UIControlStateHighlighted];
    } else {
        [_mButton setImage:nil forState:UIControlStateNormal];
        [_mButton setImage:nil forState:UIControlStateHighlighted];
        [_mButton setTitle:_faceString forState:UIControlStateNormal];
        
    }
}

@end
