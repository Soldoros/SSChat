//
//  SSChatKeyBordSymbolView.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatKeyBoardDatas.h"
#import "SSChatIMEmotionModel.h"
#import "UIImage+SSAdd.h"

/**
 表情视图底部发送和表情筛选部分
 */
#define SSChatKeyBordSymbolFooterH  40

@protocol SSChatKeyBordSymbolFooterDelegate <NSObject>

-(void)SSChatKeyBordSymbolFooterBtnClick:(UIButton *)sender;

@end


@interface SSChatKeyBordSymbolFooter : UIView

@property(nonatomic,assign)id<SSChatKeyBordSymbolFooterDelegate>delegate;

//表情切换的滚动视图(其实没有很多，为了能拓展就用这个吧)
@property (nonatomic,strong)UIScrollView *emojiFooterScrollView;
//发送按钮
@property (nonatomic,strong)UIButton *sendButton;
//第一类表情 第二类表情
@property (nonatomic,strong)UIButton *mButton1,*mButton2;


@end



/**
 表单cell
 */

#define SSChatEmojiCollectionCellId  @"SSChatEmojiCollectionCellId"
#define DeleteButtonId               @"DeleteButtonId"

@interface SSChatEmojiCollectionCell : UICollectionViewCell

@property (nonatomic,strong)NSString *string;
@property (nonatomic,strong)UIImage *image;
@property (nonatomic,strong)UIButton *button;

@end




/**
 表情列表视图
 */
@protocol SSChatKeyBordSymbolViewDelegate <NSObject>

-(void)SSChatKeyBordSymbolViewBtnClick:(NSInteger)index;
//点击其中的一个表情或者删除按钮
- (void)SSChatKeyBordSymbolCellClick:(NSObject *)emojiText;

@end

@interface SSChatKeyBordSymbolView : UIView<UIScrollViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,SSChatKeyBordSymbolFooterDelegate>

@property(nonatomic,assign)id<SSChatKeyBordSymbolViewDelegate>delegate;

@property(nonatomic,strong)SSChartEmotionImages *emotion;
@property (nonatomic,strong)NSMutableArray *defaultEmoticons;
@property (nonatomic,strong)NSMutableArray *emoticonImages;

//每一页的表情数量
@property (nonatomic,assign)NSInteger number;
//底部pagecontroller显示的数量
@property (nonatomic,assign)NSInteger numberPage;
@property (nonatomic,assign)NSInteger numberPage1;
@property (nonatomic,assign)NSInteger numberPage2;


@property(nonatomic,strong) SSChatKeyBordSymbolFooter *footer;


@property (nonatomic,strong)SSChatCollectionViewFlowLayout *layout;
@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic,strong)UIPageControl *pageControl;

@end




