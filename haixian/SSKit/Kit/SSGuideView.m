//
//  SSGuideView.m
//  pinpaijie
//
//  Created by soldoros on 2017/7/5.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "SSGuideView.h"

@interface SSGuideView ()<UIScrollViewDelegate>{
    
    UIScrollView *_mScrollView;
    UIPageControl *_pageControll;
}

@end

@implementation SSGuideView

-(instancetype)initwithImages:(NSArray *)images{
    if(self == [super init]){
        _images = images;
        self.backgroundColor = [UIColor whiteColor];
        self.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Height);
        
        
        _mScrollView = [UIScrollView new];
        _mScrollView.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Height);
        _mScrollView.centerY = SCREEN_Height * 0.5;
        _mScrollView.backgroundColor = BackGroundColor;
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
        _mScrollView.contentSize = makeSize(SCREEN_Width *_images.count, SCREEN_Height);
        
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.bounds = makeRect(0, 0, 160, 30);
        _pageControll.centerX  = SCREEN_Width*0.5;
        _pageControll.top = SCREEN_Height - 50;
        _pageControll.numberOfPages = _images.count;
        _pageControll.currentPage = 0;
        _pageControll.currentPageIndicatorTintColor = RedTitleColor;
        _pageControll.pageIndicatorTintColor = makeColorRgb(205, 229, 245);
        _pageControll.backgroundColor = [UIColor clearColor];
        [self addSubview:_pageControll];

        
        for(int i=0;i<_images.count;++i){
            
            UIImageView *img = [UIImageView new];
            img.bounds = _mScrollView.bounds;
            img.left = i* img.width;
            img.top = 0;
            img.tag = 100 +i;
            img.backgroundColor = ImagePlaceColor;
            [_mScrollView addSubview:img];
            img.image = [UIImage imageNamed:_images[i]];
            img.userInteractionEnabled = YES;
            
            if(i==_images.count-1){
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.bounds = makeRect(0, 0, 100, 1100/37);
                btn.centerX = SCREEN_Width * 0.5;
                btn.bottom = SCREEN_Height-40;
                btn.backgroundColor = [UIColor clearColor];
                [img addSubview:btn];
                

                [btn setBackgroundImage:[UIImage imageNamed:@"guidebtn"] forState:UIControlStateNormal];
                btn.clipsToBounds = YES;
                btn.layer.cornerRadius = 5;
                [btn setTitleColor:TitleColor2 forState:UIControlStateNormal];
                btn.tag = 10 + i;
                [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        
        _pageControll.hidden = YES;
    }
    return self;
}


-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSGuideViewBtn:)]){
        [_delegate SSGuideViewBtn:sender];
    }
}



//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    CGPoint offset = scrollView.contentOffset;
//    CGRect bounds = scrollView.frame;
//    CGFloat _index = offset.x / bounds.size.width;
//    _pageControll.currentPage = _index;
//    
//    if(_index==_images.count-1){
//        _pageControll.hidden = YES;
//    }else{
//        _pageControll.hidden = NO;
//    }
//    
//    if(self.alpha<0.5){
//        if(_delegate && [_delegate respondsToSelector:@selector(SSGuideViewBtn:)]){
//            [_delegate SSGuideViewBtn:[UIButton new]];
//        }
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    CGFloat scrollX = scrollView.contentOffset.x;
//    CGFloat width = (_images.count-1)*SCREEN_Width;
//    if(scrollX<=width)return;
//    
//    CGFloat more = scrollX - width;
//    CGFloat alp = (SCREEN_Width*-more)/SCREEN_Width;
//    
//    cout(@(alp));
//    self.alpha = alp;

}








@end
