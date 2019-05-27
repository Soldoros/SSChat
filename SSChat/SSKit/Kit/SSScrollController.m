//
//  SSScrollController.m
//  DEShop
//
//  Created by soldoros on 2017/6/6.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSScrollController.h"


@interface SSScrollController ()<UIScrollViewDelegate>

@property(nonatomic,strong)UILabel *mNumLab;

@end

@implementation SSScrollController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavgationBarImgAtColor:[UIColor blackColor]];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setLeftOneBtnTitle:@""];
    [self setRightOneBtnImg:@"tupianguanbi"];
    self.view.backgroundColor = [UIColor blackColor];
    
    
//    UIView *header = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SCREEN_Width)];
//    header.centerY = SCREEN_Height * 0.5 - 65;
//    header.backgroundColor = [UIColor colora];
//    [self.view addSubview:header];
    
    
    _mScrollView = [UIScrollView new];
    _mScrollView.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Width);
    _mScrollView.centerY = SCREEN_Height * 0.5 - 65;
    _mScrollView.backgroundColor = BackGroundColor;
    _mScrollView.pagingEnabled = YES;
    _mScrollView.delegate = self;
    [self.view addSubview:_mScrollView];
    _mScrollView.maximumZoomScale = 2.0;
    _mScrollView.minimumZoomScale = 0.5;
    _mScrollView.canCancelContentTouches = NO;
    _mScrollView.delaysContentTouches = YES;
    _mScrollView.showsVerticalScrollIndicator = FALSE;
    _mScrollView.showsHorizontalScrollIndicator = FALSE;
    _mScrollView.contentSize=CGSizeMake(SCREEN_Width*_images.count,0);
    _mScrollView.contentOffset = makePoint(_mScrollView.width*_index, 0);
    _mScrollView.backgroundColor = [UIColor clearColor];

    
    _pageControll = [[UIPageControl alloc] init];
    _pageControll.bounds = makeRect(0, 0, 160, 30);
    _pageControll.centerX  = SCREEN_Width*0.5;
    _pageControll.top = _mScrollView.bottom + 20;
    _pageControll.numberOfPages = _images.count;
    _pageControll.currentPage =_index;
    _pageControll.currentPageIndicatorTintColor = RedTitleColor;
    _pageControll.pageIndicatorTintColor = makeColorRgb(205, 229, 245);
    _pageControll.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_pageControll];
    
    
    _mNumLab = [[UILabel alloc]init];
    _mNumLab.bounds = makeRect(0, 0, 160, 40);
    _mNumLab.centerX = SCREEN_Width * 0.5;
    _mNumLab.font = makeFont(22);
    _mNumLab.top = _pageControll.bottom + 5;
    _mNumLab.textAlignment = NSTextAlignmentCenter;
    _mNumLab.textColor = makeColorRgb(205, 229, 245);
    _mNumLab.text = makeMoreStr(makeStrWithInt(_index+1),@"/",makeStrWithInt(_images.count),nil);
    [self.view addSubview:_mNumLab];

    
    
    for(int i=0;i<_images.count;++i){

        NSString *imgstr = _images[i];
        if (![imgstr hasPrefix:@"http://"]) {
            imgstr = makeString(URLContentString, imgstr);
        }
        
        UIImageView *img = [UIImageView new];
        img.bounds = _mScrollView.bounds;
        img.left = i* img.width;
        img.top = 0;
        img.tag = 100 +i;
        img.backgroundColor = [UIColor blackColor];
        [_mScrollView addSubview:img];
//        [[img setImageWithURL:nil placeholder:[UIImage imageNamed:ImagePlace1]];
        img.userInteractionEnabled = YES;
        img.contentMode = UIViewContentModeScaleAspectFit;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = img.bounds;
        [img addSubview:btn];
        btn.tag = 10 + i;
        [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
 
    
}


-(void)rightBtnClick{
    [self clickOver];
}

-(void)buttonPressed:(UIButton *)sender{
    [self clickOver];
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    _index = offset.x / bounds.size.width;
    _pageControll.currentPage = _index;
    _mNumLab.text = makeMoreStr(makeStrWithInt(_index+1),@"/",makeStrWithInt(_images.count),nil);
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self clickOver];
}



//返回
-(void)clickOver{
    [self.navigationController popViewControllerAnimated:NO];
}







@end
