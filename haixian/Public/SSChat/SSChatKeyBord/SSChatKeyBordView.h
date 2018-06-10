//
//  SSChatKeyBordView.h
//  haixian
//
//  Created by soldoros on 2017/11/14.
//  Copyright © 2017年 soldoros. All rights reserved.


#import <UIKit/UIKit.h>
#import "SSChatModelLayout.h"
#import "SSChatKeyBordSymbolView.h"
#import "SSChatKeyBordFunctionView.h"




/**
 弹出多功能界面是表情还是其他功能

 - KeyBordViewFouctionSymbol: 表情
 - KeyBordViewFouctionAdd: 多功能
 */
typedef NS_ENUM(NSInteger,KeyBordViewFouctionType) {
    KeyBordViewFouctionAdd=1,
    KeyBordViewFouctionSymbol,
};


@protocol SSChatKeyBordViewDelegate <NSObject>

//点击其他按钮
-(void)SSChatKeyBordViewBtnClick:(NSInteger)index type:(KeyBordViewFouctionType)type;

//点击表情
-(void)SSChatKeyBordSymbolViewBtnClick:(NSObject *)emojiText;

@end


@interface SSChatKeyBordView : UIView<UIScrollViewDelegate,SSChatKeyBordSymbolViewDelegate,SSChatKeyBordFunctionViewDelegate>

@property(nonatomic,assign)id<SSChatKeyBordViewDelegate>delegate;

//弹窗界面是表情还是其他功能
@property(nonatomic,assign)KeyBordViewFouctionType type;
//表情视图
@property(nonatomic,strong)SSChatKeyBordSymbolView   *symbolView;
//多功能视图
@property(nonatomic,strong)SSChatKeyBordFunctionView *functionView;
//覆盖视图
@property(nonatomic,strong)UIView *mCoverView;

@end






