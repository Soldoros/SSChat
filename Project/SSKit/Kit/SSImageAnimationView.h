//
//  SSImageAnimationView.h
//  Img
//
//  Created by soldoros on 2017/7/7.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSImageAnimationViewDelegate <NSObject>

-(void)SSImageAnimationViewClick:(NSInteger)index;

@end

@interface SSImageAnimationView : UIView{
    UIScrollView *_mScrollView;
    
    CGRect _newFrame;
    
    UIImageView *imageView;
    UIImage *image;
    
    //展现的宽高
    CGFloat width,height;
}

@property(nonatomic,assign)id<SSImageAnimationViewDelegate>delegate;

-(instancetype)initWithImages:(NSArray *)images placeIndex:(NSInteger)index superView:(UIView *)superView;

@property(nonatomic,strong)UIView *superView;


@property(nonatomic,strong)NSArray *images;
@property(nonatomic,strong)NSMutableArray *oldFrames;


//当前的位置
@property(nonatomic,assign)NSInteger index;


@property(nonatomic,strong)UIPageControl *pageControll;

@property(nonatomic,strong)UILabel *mNumLab;


@end
