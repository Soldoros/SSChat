//
//  SSSegmentedView.h
//  sherara
//
//  Created by soldoros on 2018/9/3.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SSSegmentedViewH    50

typedef void (^SSSegmentedViewBlock)(NSInteger index , NSString *string);


@interface SSSegmentedView : UIView

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items segmentedBlock:(SSSegmentedViewBlock)segmentedBlock;

@property(nonatomic,copy)SSSegmentedViewBlock segmentedBlock;

@property(nonatomic,strong)UISegmentedControl *segmentedControl;
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)UIView *line;

@end
