//
//  SSCollectionReusableView.h
//  sherara
//
//  Created by soldoros on 2018/8/26.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, strong) UIColor *backgroundColor;

@end




/**
 分组
 */
#define SSCollectionReusableViewId   @"SSCollectionReusableViewId"

@interface SSCollectionReusableView : UICollectionReusableView

@end





@protocol SSCollectionViewFlowLayoutDelegate <UICollectionViewDelegateFlowLayout>

- (UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout;

@end

@interface SSCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, strong) NSMutableArray *decorationViewAttrs;

//cell列间距
@property (nonatomic, strong) NSArray *minimumInteritemSpacings;

@end



