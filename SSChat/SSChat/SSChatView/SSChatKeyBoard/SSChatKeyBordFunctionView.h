//
//  SSChatKeyBordFunctionView.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSChatKeyBoardDatas.h"


/**
 多功能视图
 */

@protocol SSChatKeyBordFunctionViewDelegate <NSObject>

-(void)SSChatKeyBordFunctionViewBtnClick:(NSInteger)index;

@end


@interface SSChatKeyBordFunctionView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)id<SSChatKeyBordFunctionViewDelegate>delegate;

@property(nonatomic,strong)UIScrollView  *mScrollView;
@property(nonatomic,strong)UIPageControl *pageControll;

@end
