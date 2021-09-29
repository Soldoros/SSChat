//
//  SSSegmentedView.m
//  sherara
//
//  Created by soldoros on 2018/9/3.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSSegmentedView.h"

@implementation SSSegmentedView

-(instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items segmentedBlock:(SSSegmentedViewBlock)segmentedBlock{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        
        _items = items;
        _segmentedBlock = segmentedBlock;
        CGFloat width = 75*_items.count;
        
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:items];
        segmentedControl.frame = CGRectMake((SCREEN_Width-width)/2, 10, width, 30);
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tintColor = TitleColor;
        [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
        [self addSubview:segmentedControl];
        
        _line = [UIView new];
        _line.bounds = makeRect(0, 0, SCREEN_Width, 0.5);
        _line.bottom = self.height;
        _line.left = 0;
        _line.backgroundColor = LineColor;
        [self addSubview:_line];
        
        
    }
    return self;
}


//顶部筛选回调
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)segmente{
    NSString *string =  _items[segmente.selectedSegmentIndex];
    _segmentedBlock(segmente.selectedSegmentIndex,string);
}






@end
