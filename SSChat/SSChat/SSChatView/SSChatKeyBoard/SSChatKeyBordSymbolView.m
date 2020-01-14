//
//  SSChatKeyBordSymbolView.m
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSChatKeyBordSymbolView.h"


//表情视图底部发送和表情筛选部分
@implementation SSChatKeyBordSymbolFooter

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _sendButton .frame = CGRectMake(SCREEN_Width-80, 0, 80, self.height);
        _sendButton.tag = 200;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.backgroundColor = SSChatCellColor;
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:16];
        _sendButton.enabled = NO;
        [_sendButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_sendButton];
        
        
        _emojiFooterScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width - _sendButton.width, self.height)];
        _emojiFooterScrollView.showsHorizontalScrollIndicator = NO;
        _emojiFooterScrollView.showsVerticalScrollIndicator = NO;
        _emojiFooterScrollView.contentSize = CGSizeMake(SCREEN_Width - _sendButton.width+1,  self.height);
        [self addSubview:_emojiFooterScrollView];
        
        
        _mButton1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width / 6, 40)];
        _mButton1.tag = 500;
        [_mButton1 setImage:[UIImage imageNamed:@"Expression_1"] forState:UIControlStateNormal];
        [_mButton1 setImage:[UIImage imageNamed:@"Expression_13"] forState:UIControlStateSelected];
        [_mButton1 setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_mButton1 setBackgroundImage:[UIImage imageFromColor:SSChatCellColor] forState:UIControlStateSelected];
        [_mButton1 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_emojiFooterScrollView addSubview:_mButton1];
        _mButton1.selected = YES;


        _mButton2 = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_Width / 6, 0, SCREEN_Width / 6, 40)];
        _mButton2.tag = 501;
        [_mButton2 setImage:[UIImage imageNamed:@"Expression_1"] forState:UIControlStateNormal];
        [_mButton2 setImage:[UIImage imageNamed:@"Expression_13"] forState:UIControlStateSelected];
        [_mButton2 setBackgroundImage:[UIImage imageFromColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [_mButton2 setBackgroundImage:[UIImage imageFromColor:SSChatCellColor] forState:UIControlStateSelected];
        [_mButton2 addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [_emojiFooterScrollView addSubview:_mButton2];
        _mButton2.selected = NO;
      
        
        
    }
    return self;
}


//发送200  表情包切换500+
-(void)buttonPressed:(UIButton *)sender{
    NSLog(@"点击了发送");
    if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordSymbolFooterBtnClick:)]){
        [_delegate SSChatKeyBordSymbolFooterBtnClick:sender];
    }
}

@end




//表情视图的表单cell
@implementation SSChatEmojiCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = SSChatCellColor;
        self.contentView.frame = self.bounds;
        
        self.button = [[UIButton alloc] init];
        self.button.userInteractionEnabled = false;
        [self.contentView addSubview:self.button];
        _button.frame = self.contentView.bounds;
    }
    return self;
}

- (void)setString:(NSString *)string{
    if ([string isEqual: DeleteButtonId]) {
        [self.button setTitle:nil forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"DeleteEmoticonBtn"] forState:UIControlStateNormal];
        [self.button setImage:[UIImage imageNamed:@"DeleteEmoticonBtnHL"] forState:UIControlStateHighlighted];
        
    } else {
        [self.button setImage:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateHighlighted];
        [self.button setTitle:string forState:UIControlStateNormal];
        
    }
}

- (void)setImage:(UIImage *)image{
    
    [self.button setTitle:nil forState:UIControlStateNormal];
    if (image) {
        [self.button setImage:image forState:UIControlStateNormal];
        [self.button setImage:image forState:UIControlStateHighlighted];
    } else {
        [self.button setImage:nil forState:UIControlStateNormal];
        [self.button setImage:nil forState:UIControlStateHighlighted];
    }
}

@end





@implementation SSChatKeyBordSymbolView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = SSChatCellColor;
        
        _number = SSChatEmojiRow * SSChatEmojiLine;
        _defaultEmoticons = [NSMutableArray array];
        _emoticonImages = [NSMutableArray array];
        
        
        _footer = [[SSChatKeyBordSymbolFooter alloc] initWithFrame:CGRectMake(0, self.height-SSChatKeyBordSymbolFooterH, SCREEN_Width, SSChatKeyBordSymbolFooterH)];
        _footer.backgroundColor = [UIColor whiteColor];
        [self addSubview:_footer];
        _footer.delegate = self;
        
        
        self.layout = [[SSChatCollectionViewFlowLayout alloc] init];

        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, self.height-_footer.height-20) collectionViewLayout:self.layout];
        self.collectionView.backgroundColor = SSChatCellColor;
        self.collectionView.backgroundView.backgroundColor = SSChatCellColor;
        self.collectionView.dataSource = self;
        self.collectionView.delegate = self;
        [self addSubview:self.collectionView];
        [self.collectionView registerClass:[SSChatEmojiCollectionCell class] forCellWithReuseIdentifier:SSChatEmojiCollectionCellId];

        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _collectionView.bottom, 0, 10)];
        _pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
        _pageControl.pageIndicatorTintColor = [UIColor grayColor];
        _pageControl.userInteractionEnabled = NO;
        _pageControl.centerX = SCREEN_Width*0.5;
        [self addSubview:_pageControl];
        [_pageControl setCurrentPageIndicatorTintColor:[UIColor grayColor]];
        [_pageControl setPageIndicatorTintColor:makeColorRgb(200, 200, 200)];


        //获取本地的表情和系统表情
        dispatch_async(dispatch_get_global_queue(0, 0), ^{

            self.emotion = [SSChartEmotionImages ShareSSChartEmotionImages];
            [self.emotion initEmotionImages];
            [self.emotion initSystemEmotionImages];
            
            [self.emoticonImages addObjectsFromArray:self.emotion.images];
            self.defaultEmoticons = [self.emotion dealWithArray:self.emotion.images arr2:self.emotion.systemImages];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
                
                self.numberPage = self.defaultEmoticons.count/self.number;
                self.numberPage1 = self.numberPage * self.emotion.images.count/(self.emotion.images.count + self.emotion.systemImages.count);
                self.numberPage2 = self.numberPage-self.numberPage1;
                self.pageControl.numberOfPages = self.numberPage1;
                
            });
        });

    }
    
    return self;
    
}


- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.defaultEmoticons.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SSChatEmojiCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SSChatEmojiCollectionCellId forIndexPath:indexPath];
    if ([self.defaultEmoticons[indexPath.row] isKindOfClass:[UIImage class]]) {
        cell.image = self.defaultEmoticons[indexPath.row];
    } else {
        cell.string = self.defaultEmoticons[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSObject *str = self.defaultEmoticons[indexPath.row];
    
    if (_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordSymbolCellClick:)]) {
        [_delegate SSChatKeyBordSymbolCellClick:str];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.collectionView) {
        if (scrollView.contentOffset.x >= SCREEN_Width * _numberPage1){
            [self setSymbolValue2];
            
        } else {
            [self setSymbolValue1];
        }
    }
}


#pragma SSChatKeyBordSymbolFooterDelegate
//底部切换表情500+  发送200
-(void)SSChatKeyBordSymbolFooterBtnClick:(UIButton *)sender{
    if(sender.tag==500){
        [self.collectionView setContentOffset:CGPointMake(0, self.collectionView.contentOffset.y) animated:YES];
        [self setSymbolValue1];
        self.pageControl.currentPage = 0;
        
    }else if (sender.tag==501){
        [self.collectionView setContentOffset:CGPointMake(SCREEN_Width * _numberPage1, self.collectionView.contentOffset.y) animated:YES];
        [self setSymbolValue2];
        
    }else{
        if(_delegate && [_delegate respondsToSelector:@selector(SSChatKeyBordSymbolViewBtnClick:)]){
            [_delegate SSChatKeyBordSymbolViewBtnClick:sender.tag];
        }
    }
}

//跳转到第一类表情
-(void)setSymbolValue1{
    self.pageControl.numberOfPages = _numberPage1;
    self.pageControl.currentPage = (self.collectionView.contentOffset.x / SCREEN_Width);
    _footer.mButton1.selected = YES;
    _footer.mButton2.selected = NO;
}

//跳转到第二类表情
-(void)setSymbolValue2{
    self.pageControl.numberOfPages = _numberPage2;
    self.pageControl.currentPage = ((self.collectionView.contentOffset.x - _numberPage1*SCREEN_Width) / SCREEN_Width);
    _footer.mButton1.selected = NO;
    _footer.mButton2.selected = YES;
}



@end
