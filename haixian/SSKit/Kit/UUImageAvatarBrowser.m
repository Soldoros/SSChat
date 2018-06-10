//
//  UUAVAudioPlayer.m
//  BloodSugarForDoc
//
//  Created by shake on 14-9-1.
//  Copyright (c) 2014年 shake. All rights reserved.
//

#import "UUImageAvatarBrowser.h"

static UIImageView *orginImageView;
static UIScrollView *_mScrollView;
static CGFloat width;
static NSInteger count;
static NSInteger tags = 200;

@interface UUImageAvatarBrowser ()


@end

@implementation UUImageAvatarBrowser



+(void)showImages:(NSArray *)images{
    
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    
    _mScrollView = [UIScrollView new];
    _mScrollView.frame = makeRect(0, 0, SCREEN_Width, SCREEN_Height);
    _mScrollView.backgroundColor = [UIColor clearColor];
    _mScrollView.pagingEnabled = NO;
    [window addSubview:_mScrollView];
    _mScrollView.maximumZoomScale = 2.0;
    _mScrollView.minimumZoomScale = 0.5;
    _mScrollView.canCancelContentTouches = NO;
    _mScrollView.delaysContentTouches = YES;
    _mScrollView.showsVerticalScrollIndicator = FALSE;
    _mScrollView.showsHorizontalScrollIndicator = FALSE;
    _mScrollView.pagingEnabled = YES;
    
    count = images.count;
    width = count * SCREEN_Width;
    _mScrollView.contentSize=CGSizeMake(width,SCREEN_Height);
    
    for(int i=0;i<count;++i){
        UIView *view = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SCREEN_Height)];
        view.backgroundColor = [UIColor clearColor];
        view.left = i*SCREEN_Width;
        view.tag = tags + i;
        [_mScrollView addSubview:view];

    }

}

+(void)showImage:(UIImageView *)avatarImageView{
    
    UIWindow *window =[UIApplication sharedApplication].keyWindow;
    
    UIImage *image=avatarImageView.image;
    orginImageView = avatarImageView;
    orginImageView.alpha = 0;
    
    UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    CGRect oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
    backgroundView.backgroundColor= [UIColor blackColor];
    backgroundView.alpha = 0.01;
                                    
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:oldframe];
    imageView.image=image;
    imageView.tag=1;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
    [backgroundView addGestureRecognizer: tap];
    
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=CGRectMake(0, ([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width,  image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
        backgroundView.alpha=1;
    } completion:^(BOOL finished) {
        
    }];
}

+(void)hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView=tap.view;
    UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:1];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame=[orginImageView convertRect:orginImageView.bounds toView:[UIApplication sharedApplication].keyWindow];
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
        orginImageView.alpha = 1;
        backgroundView.alpha=0;
        [_mScrollView removeFromSuperview];
        _mScrollView = nil;
    }];
}



@end
