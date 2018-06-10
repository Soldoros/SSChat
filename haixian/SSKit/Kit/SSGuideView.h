//
//  SSGuideView.h
//  pinpaijie
//
//  Created by soldoros on 2017/7/5.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSGuideViewDelegate <NSObject>

-(void)SSGuideViewBtn:(UIButton *)sender;

@end

@interface SSGuideView : UIView

@property(nonatomic,assign)id<SSGuideViewDelegate>delegate;

-(instancetype)initwithImages:(NSArray *)images;
@property(nonatomic,strong)NSArray *images;

@end
