//
//  BaseCollectionViewController.m
//  sherara
//
//  Created by soldoros on 2018/8/21.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseCollectionViewController.h"

@interface BaseCollectionViewController ()

@end

@implementation BaseCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    if(self.isRoot==YES){
        self.tableViewH = MainViewRoot_Height;
    }else{
        self.tableViewH = MainViewSub_Height;
    }
    
    //创建layout
    self.collectionLayout = [[SSCollectionViewFlowLayout alloc] init];
//    //设置item的行间距和列间距
//    self.collectionLayout.minimumInteritemSpacing = 0;
//    self.collectionLayout.minimumLineSpacing = 0;
//    //设置item的大小
//    self.collectionLayout.itemSize = CGSizeMake(SCREEN_Width, 44);
//    //设置每个分区的上左下右的内边距
//    self.collectionLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
//    //设置区头和区尾的大小
//    self.collectionLayout.headerReferenceSize = CGSizeMake(0, 0);
//    self.collectionLayout.footerReferenceSize = CGSizeMake(0, 0);
//    //设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
//    self.collectionLayout.sectionFootersPinToVisibleBounds = YES;
//    self.collectionLayout.sectionHeadersPinToVisibleBounds = YES;
    

    //创建collectionView
    self.mCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, SafeAreaTop_Height, SCREEN_Width, self.tableViewH) collectionViewLayout:self.collectionLayout];
    self.mCollectionView.delegate = self;
    self.mCollectionView.dataSource = self;
    self.mCollectionView.backgroundColor = [UIColor whiteColor];
    self.mCollectionView.backgroundView.backgroundColor = [UIColor whiteColor];
   
    [self.mCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerId"];
    [self.mCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footerId"];
    [self.view addSubview:self.mCollectionView];
   
    
}


#pragma mark - UICollectionViewDelegate,UICollectionViewDataSource
//分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//区头大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}


//区尾大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}

//每个分区的内边距（上左下右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
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
    return 20;
}

//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(SCREEN_Width, 44);
}


//分区内cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//分区内cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

//创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor whiteColor];
    return cell;
}


//点击某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击了第%ld分item",(long)indexPath.item);
}

#pragma SSCollectionViewFlowLayoutDelegate  分组返回灰色
-(UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout{
    return BackGroundColor;
}








@end
