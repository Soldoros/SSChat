//
//  SSGuideController.m
//  htcm
//
//  Created by soldoros on 2018/8/22.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSGuideController.h"

@interface SSGuideController ()<UIScrollViewDelegate>

@property(nonatomic,strong) UIScrollView *mScrollView;
@property(nonatomic,strong) UIPageControl *pageControll;

@end

@implementation SSGuideController

-(instancetype)init{
    if(self = [super init]){
        _type = SSScrollViewImageValue1;
        _imageModel = SSScrollViewImageModel1;
    }
    return self;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
    [UIApplication sharedApplication].statusBarHidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    _mScrollView = [UIScrollView new];
    _mScrollView.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Height);
    _mScrollView.backgroundColor = [UIColor whiteColor];
    _mScrollView.pagingEnabled = YES;
    _mScrollView.delegate = self;
    [self.view addSubview:_mScrollView];
    _mScrollView.maximumZoomScale = 2.0;
    _mScrollView.minimumZoomScale = 0.5;
    _mScrollView.canCancelContentTouches = NO;
    _mScrollView.delaysContentTouches = YES;
    _mScrollView.showsVerticalScrollIndicator = FALSE;
    _mScrollView.showsHorizontalScrollIndicator = FALSE;
    _mScrollView.contentSize = makeSize(SCREEN_Width *_images.count, SCREEN_Height-1);
    
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.bounds = makeRect(0, 0, 160, 30);
    _pageControll.centerX  = SCREEN_Width*0.5;
    _pageControll.top = SCREEN_Height - 50;
    
    _pageControll.currentPage = 0;
    _pageControll.currentPageIndicatorTintColor = RedTitleColor;
    _pageControll.pageIndicatorTintColor = makeColorRgb(205, 229, 245);
    _pageControll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageControll];
    _pageControll.numberOfPages = _images.count;
    
    
    _pageControll.hidden = YES;

    
    
    for(int i=0;i<_images.count;++i){
        
        UIImageView *img = [UIImageView new];
        img.frame = makeRect(i*SCREEN_Width, 0, SCREEN_Width, SCREEN_Height);
        img.tag = 100 +i;
        img.backgroundColor = [UIColor blackColor];
        [_mScrollView addSubview:img];
        img.image = [UIImage imageNamed:_images[i]];
        img.userInteractionEnabled = YES;
        img.contentMode = UIViewContentModeScaleAspectFit;
   
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = img.bounds;
        btn.backgroundColor = [UIColor clearColor];
        [img addSubview:btn];
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    
}








-(void)buttonPressed:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:NO];
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
