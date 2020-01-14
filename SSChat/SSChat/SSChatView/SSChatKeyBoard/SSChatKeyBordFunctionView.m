//
//  SSChatKeyBordFunctionView.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatKeyBordFunctionView.h"


@implementation SSChatKeyBordFunctionView{
    NSArray *titles,*images;
    NSInteger count;
    NSInteger number;
}


-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = SSChatCellColor;
        count = 8;
        
        //添加功能只需要在标题和图片数组里面直接添加就行
        titles = @[@"照片",@"视频",@"位置"];
        images = @[@"zhaopian",@"shipin",@"weizhi"];
        
        NSInteger number = titles.count/count+1;
        
        
        _mScrollView = [UIScrollView new];
        _mScrollView.frame = self.bounds;
        _mScrollView.centerY = self.height * 0.5;
        _mScrollView.backgroundColor = SSChatCellColor;
        _mScrollView.pagingEnabled = YES;
        _mScrollView.delegate = self;
        [self addSubview:_mScrollView];
        _mScrollView.maximumZoomScale = 2.0;
        _mScrollView.minimumZoomScale = 0.5;
        _mScrollView.canCancelContentTouches = NO;
        _mScrollView.delaysContentTouches = YES;
        _mScrollView.showsVerticalScrollIndicator = FALSE;
        _mScrollView.showsHorizontalScrollIndicator = FALSE;
        _mScrollView.backgroundColor = [UIColor clearColor];
        _mScrollView.contentSize = CGSizeMake(SCREEN_Width *number, self.height);
        
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.bounds = CGRectMake(0, 0, 160, 30);
        _pageControll.centerX  = SCREEN_Width*0.5;
        _pageControll.top = SCREEN_Height - 50;
        _pageControll.numberOfPages = number;
        _pageControll.currentPage = 0;
        _pageControll.currentPageIndicatorTintColor = [UIColor grayColor];
        _pageControll.pageIndicatorTintColor = BackGroundColor;
        _pageControll.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageControll];
        
        
        for(NSInteger i=0;i<number;++i){
            
            UIView *backView = [UIView new];
            backView.bounds = CGRectMake(0, 0, self.width-40, self.height-55);
            backView.centerX = self.width*0.5 + i*self.width;
            backView.top = 20;
            [_mScrollView addSubview:backView];
            
            for(NSInteger j= (i * count);j<(i+1)*count && j<titles.count;++j){
                
                UIView *btnView = [UIView new];
                btnView.bounds = CGRectMake(0, 0, backView.width/4, backView.height*0.5);
                btnView.tag = 10+j;
                btnView.left = j%4 * btnView.width;
                btnView.top = j/4*btnView.height;
                [backView addSubview:btnView];
                btnView.tag = 10+j;
                btnView.backgroundColor = SSChatCellColor;
                if(btnView.top>btnView.height)btnView.top = 0;
                
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.bounds = CGRectMake(0, 0, 50, 50);
                btn.top = 15;
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                btn.centerX = btnView.width*0.5;
                [btnView addSubview:btn];
                [btn setImage:[UIImage imageNamed:images[j]] forState:UIControlStateNormal];
                btn.userInteractionEnabled = YES;
                
                
                UILabel *lab = [UILabel new];
                lab.bounds = CGRectMake(0, 0, 80, 20);
                lab.text = titles[j];
                lab.font = [UIFont systemFontOfSize:12];
                lab.textColor = [UIColor grayColor];
                lab.textAlignment = NSTextAlignmentCenter;
                [lab sizeToFit];
                lab.centerX = btnView.width*0.5;
                lab.top = btn.bottom + 15;
                [btnView addSubview:lab];
                lab.userInteractionEnabled = YES;
                
                
                UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(footerGestureClick:)];
                [btnView addGestureRecognizer:gesture];
                
            }
        }
        
    }
    return self;
    
}


//多功能点击10+
-(void)footerGestureClick:(UITapGestureRecognizer *)sender{
    
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordFunctionViewBtnClick:)]){
        [_delegate SSChatKeyBordFunctionViewBtnClick:sender.view.tag];
    }
}


@end
