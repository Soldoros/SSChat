//
//  SSChatKeyBordFunctionView.h
//  htcm
//
//  Created by soldoros on 2018/6/1.
//  Copyright © 2018年 soldoros. All rights reserved.
//

//多功能视图
#import <UIKit/UIKit.h>
#import "SSChatModelLayout.h"

@protocol SSChatKeyBordFunctionViewDelegate <NSObject>

-(void)SSChatKeyBordFunctionViewBtnClick:(NSInteger)index;

@end


@interface SSChatKeyBordFunctionView : UIView<UIScrollViewDelegate>

@property(nonatomic,assign)id<SSChatKeyBordFunctionViewDelegate>delegate;

@property(nonatomic,strong)UIScrollView  *mScrollView;
@property(nonatomic,strong)UIPageControl *pageControll;

@end
