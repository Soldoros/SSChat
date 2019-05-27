//
//  SSCollectionReusableView.m
//  sherara
//
//  Created by soldoros on 2018/8/26.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSCollectionReusableView.h"

@implementation SSCollectionViewLayoutAttributes

@end



@implementation SSCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    if ([layoutAttributes isKindOfClass:[SSCollectionViewLayoutAttributes class]]) {
        SSCollectionViewLayoutAttributes *attr = (SSCollectionViewLayoutAttributes *)layoutAttributes;
        self.backgroundColor = attr.backgroundColor;
    }
}

@end



@implementation SSCollectionViewFlowLayout

- (instancetype)init{
    if (self = [super init]) {
        self.decorationViewAttrs = [NSMutableArray array];
        [self registerClass:[SSCollectionReusableView class] forDecorationViewOfKind:SSCollectionReusableViewId];
    }
    return self;
}



- (void)prepareLayout{
    [super prepareLayout];
    [self.decorationViewAttrs removeAllObjects];
    
    NSInteger numberOfSections = [self.collectionView numberOfSections];
    id delegate = self.collectionView.delegate;
    if (!numberOfSections || ![delegate conformsToProtocol:@protocol(SSCollectionViewFlowLayoutDelegate)]) {
        return;
    }
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems <= 0) {
            continue;
        }
        UICollectionViewLayoutAttributes *firstItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        UICollectionViewLayoutAttributes *lastItem = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:numberOfItems - 1 inSection:section]];
        if (!firstItem || !lastItem) {
            continue;
        }
        
        UIEdgeInsets sectionInset = [self sectionInset];
        
        if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
            UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
            sectionInset = inset;
        }
        
        
        CGRect sectionFrame = CGRectUnion(firstItem.frame, lastItem.frame);
        sectionFrame.origin.x -= sectionInset.left;
        sectionFrame.origin.y -= sectionInset.top;
        
        if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
            sectionFrame.size.width += sectionInset.left + sectionInset.right;
            sectionFrame.size.height = self.collectionView.frame.size.height;
        } else {
            sectionFrame.size.width = self.collectionView.frame.size.width;
            sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
        }
        
        // 2、定义
        SSCollectionViewLayoutAttributes *attr = [SSCollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:SSCollectionReusableViewId withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
        attr.frame = sectionFrame;
        attr.zIndex = -1;
        
        attr.backgroundColor = [delegate backgroundColorForSection:section collectionView:self.collectionView layout:self ];
        
    
        
        
        [self.decorationViewAttrs addObject:attr];
    }
    
}

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

//    NSInteger numberOfSections = [self.collectionView numberOfSections];
//
//
//        
//    for(NSInteger section =0;section<numberOfSections;++section){
//
//        NSInteger hotItemCount = [self.collectionView numberOfItemsInSection:section];
//
//        for(int i=0;i<hotItemCount;++i){
//            
//            UICollectionViewLayoutAttributes *att1 = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:section]];
//            
//            UICollectionViewLayoutAttributes *att2 = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i-1 inSection:section]];
//
//                //我们想设置的最大间距，可根据需要改
//            NSInteger maximumSpacing = [_minimumInteritemSpacings[section] floatValue];
//
//                //前一个cell的最右边
//                NSInteger origin = CGRectGetMaxX(att2.frame);
//
//                if(origin + maximumSpacing + att1.frame.size.width <  self.collectionViewContentSize.width) {
//                    CGRect frame = att1.frame;
//                    frame.origin.x = origin + maximumSpacing;
//                    att1.frame = frame;
//                }
//
//            }
//    }


    
    
    for (UICollectionViewLayoutAttributes *attr in self.decorationViewAttrs) {
        
        if (CGRectIntersectsRect(rect, attr.frame)) {
            [attributes addObject:attr];
        }
    }
    return attributes;
    
}



- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)elementKind atIndexPath:(NSIndexPath *)indexPath{
    if ([elementKind isEqualToString:SSCollectionReusableViewId]) {
        return [self.decorationViewAttrs objectAtIndex:indexPath.section];
    }
    return [super layoutAttributesForDecorationViewOfKind:elementKind atIndexPath:indexPath];
}


@end









