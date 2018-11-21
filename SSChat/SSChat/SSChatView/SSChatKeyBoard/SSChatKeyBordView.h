//
//  SSChatKeyBordView.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatKeyBoardDatas.h"
#import "SSChatKeyBordSymbolView.h"
#import "SSChatKeyBordFunctionView.h"


/**
 多功能界面+表情视图的承载视图
 */

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






