//
//  SSImageAnimationView.m
//  Img

//  Created by soldoros on 2017/7/7.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "SSImageAnimationView.h"


@interface SSImageAnimationView ()<UIScrollViewDelegate>{
    
    NSMutableArray *winFrames;
    CGRect winFrame;
    
    
}

@end

@implementation SSImageAnimationView

-(instancetype)initWithImages:(NSArray *)images placeIndex:(NSInteger)index superView:(UIView *)superView{
    if(self = [super init]){
        _superView = superView;
        width = [[UIScreen mainScreen] bounds].size.width;
        height = [[UIScreen mainScreen] bounds].size.height;
        self.frame = CGRectMake(0, 0, width, height);
        self.backgroundColor = [UIColor clearColor];
        _images = images;
        _index = index;
        
        _oldFrames = [NSMutableArray new];
        winFrames = [NSMutableArray new];
        for(UIImageView *imgview in _images){
            NSValue *value = [NSValue valueWithCGRect:imgview.frame];
            [_oldFrames addObject:value];
            
            CGRect winRect = [imgview convertRect:imgview.bounds toView:self];
            NSValue *winValue = [NSValue valueWithCGRect:winRect];
            [winFrames addObject:winValue];
        }

        _mScrollView = [UIScrollView new];
        _mScrollView.frame = self.bounds;
        _mScrollView.backgroundColor = [UIColor clearColor];
        _mScrollView.pagingEnabled = YES;
        _mScrollView.delegate = self;
        [self addSubview:_mScrollView];
        _mScrollView.maximumZoomScale = 2.0;
        _mScrollView.minimumZoomScale = 0.5;
        _mScrollView.canCancelContentTouches = NO;
        _mScrollView.delaysContentTouches = YES;
        _mScrollView.showsVerticalScrollIndicator = FALSE;
        _mScrollView.showsHorizontalScrollIndicator = FALSE;
        _mScrollView.contentSize=CGSizeMake(width*_images.count,0);
        _mScrollView.contentOffset = CGPointMake(width*_index, 0);
        
        
        
        _pageControll = [[UIPageControl alloc] init];
        _pageControll.bounds = makeRect(0, 0, 160, 30);
        _pageControll.centerX  = SCREEN_Width*0.5;
        _pageControll.top = height - 100;
        _pageControll.numberOfPages = _images.count;
        _pageControll.currentPage =_index;
        _pageControll.currentPageIndicatorTintColor = RedTitleColor;
        _pageControll.pageIndicatorTintColor = makeColorRgb(205, 229, 245);
        _pageControll.backgroundColor = [UIColor clearColor];
        _pageControll.alpha = 0.01;
        [self addSubview:_pageControll];
        
        UIImage *coloriMG = [UIImage imageFromColor:ImagePlaceColor andFrame:self.bounds];
        
        
        
        _mNumLab = [[UILabel alloc]init];
        _mNumLab.bounds = makeRect(0, 0, 160, 40);
        _mNumLab.centerX = SCREEN_Width * 0.5;
        _mNumLab.font = makeFont(22);
        _mNumLab.top = _pageControll.bottom + 5;
        _mNumLab.textAlignment = NSTextAlignmentCenter;
        _mNumLab.textColor = makeColorRgb(205, 229, 245);
        _mNumLab.text = makeMoreStr(makeStrWithInt(_index+1),@"/",makeStrWithInt(_images.count),nil);
        [self addSubview:_mNumLab];
        
        
        imageView = (UIImageView *)images[_index];
        imageView.frame = [imageView convertRect:imageView.bounds toView:self];
        winFrame = imageView.frame;
        [self addSubview:imageView];
        if(imageView.image == nil){
            imageView.image = coloriMG;
        }
        CGRect newFrame = [self getImgRect:imageView.image count:0];
        
        [UIView animateWithDuration:0.3 animations:^{
            imageView.frame = newFrame;
            self.backgroundColor = [UIColor blackColor];
            _pageControll.alpha = 1;
        } completion:^(BOOL finished) {
            [_mScrollView addSubview:imageView];
            
            for(int i=0;i<_images.count;++i){
            
                UIImageView *imgV = _images[i];
                if(imgV.image == nil){
                    imgV.image = coloriMG;
                }
                imgV.frame = [self getImgRect:imgV.image count:i];
                [_mScrollView addSubview:imgV];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(i*width, 0, width, height);
                [_mScrollView addSubview:btn];
                btn.tag = i;
                [btn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            [_pageControll bringSubviewToFront:self];
        }];
        
        
    }
    
    return self;
}


//点击返回
-(void)buttonPressed:(UIButton *)sender{
    
    for(int i=0;i<_images.count;++i){
        if(_index==i)continue;
        UIImageView *imgV = (UIImageView *)_images[i];
        CGRect oldF = [_oldFrames[i] CGRectValue];
        imgV.frame = oldF;
        [_superView addSubview:imgV];
    }
    
    
    UIImageView *indexImgView = (UIImageView *)_images[_index];

    indexImgView.frame = [self getImgRect:indexImgView.image count:0];
    [self addSubview:indexImgView];
    
    [UIView animateWithDuration:0.3 animations:^{
        
        indexImgView.frame = [winFrames[_index] CGRectValue];
        self.backgroundColor = [UIColor clearColor];
        _pageControll.alpha = 0.01;
        
    } completion:^(BOOL finished) {
        indexImgView.frame = [_oldFrames[_index] CGRectValue];
        [_superView addSubview:indexImgView];
        
        if(_delegate && [_delegate respondsToSelector:@selector(SSImageAnimationViewClick:)]){
            [_delegate SSImageAnimationViewClick:_index];
        }
        
    }];
    
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    CGRect bounds = scrollView.frame;
    _index = offset.x / bounds.size.width;
    _pageControll.currentPage = _index;
    
    _mNumLab.text = makeMoreStr(makeStrWithInt(_index+1),@"/",makeStrWithInt(_images.count),nil);
}



//获取图片的展示尺寸
-(CGRect)getImgRect:(UIImage *)rectImg count:(NSInteger)count{
    
    if(rectImg == nil){
        return CGRectMake(0, 0, width, height);
    }
    
    CGFloat iw = CGImageGetWidth(rectImg.CGImage);
    CGFloat ih = CGImageGetHeight(rectImg.CGImage);
    //图片宽高比
    CGFloat pn = ih/iw;
    
    CGFloat imgWidth = iw>width?width:iw;
    CGFloat imgHeight = imgWidth * pn;
    
    CGFloat left = count*width + (width-imgWidth)/2;
    CGFloat top  = _mScrollView.height*0.5 - imgHeight*0.5;;
    
    return  CGRectMake(left, top, imgWidth, imgHeight);

}




@end
