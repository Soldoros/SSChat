//
//  SSChatKeyBordFunctionView.m
//  htcm
//
//  Created by soldoros on 2018/6/1.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//多功能视图
#import "SSChatKeyBordFunctionView.h"


//多功能视图
@implementation SSChatKeyBordFunctionView{
    NSArray *titles,*images;
    NSInteger count;
    NSInteger number;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = SSChatCellColor;
        count = 8;
        titles = @[@"照片",@"视频",@"位置"];
        images = @[@"Chat_take_picture",@"Chat_take_picture",@"Chat_take_picture"];
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
        _mScrollView.contentSize = makeSize(SCREEN_Width *number, self.height);
        
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.bounds = makeRect(0, 0, 160, 30);
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
            backView.bounds = makeRect(0, 0, self.width-40, self.height);
            backView.centerX = self.width*0.5 + i*self.width;
            backView.top = 0;
            [_mScrollView addSubview:backView];
            
            for(NSInteger j= (i * count);j<(i+1)*count && j<titles.count;++j){
                
                UIView *btnView = [UIView new];
                btnView.bounds = makeRect(0, 0, backView.width/4, backView.height*0.5);
                btnView.left = j%4 * btnView.width;
                btnView.top = j/4*btnView.height;
                [backView addSubview:btnView];
                btnView.backgroundColor = SSChatCellColor;
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.bounds = makeRect(0, 0, 50, 50);
                btn.top = 15;
                btn.backgroundColor = [UIColor whiteColor];
                btn.titleLabel.font = makeFont(14);
                btn.centerX = btnView.width*0.5;
                btn.tag = 10+j;
                [btnView addSubview:btn];
                [btn setTitle:titles[j] forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                btn.layer.borderWidth = 0.5;
                btn.layer.borderColor = CellLineColor.CGColor;
                btn.clipsToBounds = YES;
                btn.layer.cornerRadius = 15;
                [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
                
                UILabel *lab = [UILabel new];
                lab.bounds = makeRect(0, 0, 80, 20);
                lab.text = titles[j];
                lab.font = makeFont(12);
                lab.textColor = [UIColor grayColor];
                lab.textAlignment = NSTextAlignmentCenter;
                [lab sizeToFit];
                lab.centerX = btnView.width*0.5;
                lab.top = btn.bottom + 5;
                [btnView addSubview:lab];
                
            }
        }

    }
    return self;
    
}


-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordFunctionViewBtnClick:)]){
        [_delegate SSChatKeyBordFunctionViewBtnClick:sender.tag];
    }
}



@end
