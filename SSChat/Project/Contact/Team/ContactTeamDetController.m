//
//  ContactTeamDetController.m
//  SSChat
//
//  Created by soldoros on 2019/6/3.
//  Copyright © 2019 soldoros. All rights reserved.
//


//群组详情
#import "ContactTeamDetController.h"
#import "ContactViews.h"
#import "ContactFriendDetController.h"

@interface ContactTeamDetController ()

@end

@implementation ContactTeamDetController

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
    [self setNavgaionTitle:@"群名片"];
    
    self.mCollectionView.height += SafeAreaBottom_Height;
    [self.mCollectionView registerClass:[ContactTeamDetTopCell class] forCellWithReuseIdentifier:ContactTeamDetTopCellId];
    [self.mCollectionView registerClass:[ContactTeamDetOtherCell class] forCellWithReuseIdentifier:ContactTeamDetOtherCellId];
    [self.mCollectionView registerClass:[ContactTeamDetBottomCell class] forCellWithReuseIdentifier:ContactTeamDetBottomCellId];
    self.mCollectionView.backgroundColor = BackGroundColor;
    self.mCollectionView.backgroundView.backgroundColor = BackGroundColor;
    
}


-(void)netWorking{
   
}


//分组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 4;
}

//header尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(SCREEN_Width, 10);
    }
}

//footer尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
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


#pragma SSCollectionViewFlowLayoutDelegate  分组返回灰色
-(UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout{
    if(section == 0){
        return [UIColor whiteColor];
    }else{
        return BackGroundColor;
    }
}


//cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return  6;
    }else if(section == 1 || section == 2){
        return 3;
    }else{
        return 2;
    }
}


//cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGSizeMake(ContactTeamDetTopCellW, ContactTeamDetTopCellH);
    }
    else if(indexPath.section == 1 || indexPath.section == 2){
        return CGSizeMake(ContactTeamDetOtherCellW, ContactTeamDetOtherCellH);
    }
    else{
        return CGSizeMake(ContactTeamDetBottomCellW, ContactTeamDetBottomCellH);
    }
}


//每个分区的内边距（上左下右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0){
        return UIEdgeInsetsMake(15, 10, 0, 10);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}


//分区内cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 0)return 0;
    else return 1;
}

//分区内cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//创建cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ContactTeamDetTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetTopCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
    else if(indexPath.section == 1 || indexPath.section == 2){
        ContactTeamDetOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetOtherCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
    else{
        ContactTeamDetBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetBottomCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        return cell;
    }
}


//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
        ContactFriendDetController *vc = [ContactFriendDetController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


@end
