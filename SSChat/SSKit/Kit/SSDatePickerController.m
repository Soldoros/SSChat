//
//  SSDatePickerController.m
//  htcm
//
//  Created by soldoros on 2018/7/11.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSDatePickerController.h"





//选择日期弹窗
@implementation SSDatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor whiteColor];
        self.clipsToBounds = YES;
        self.layer.cornerRadius = 10;
    
        _mTitleLab = [UILabel new];
        _mTitleLab.frame = makeRect(0, 0, SSDatePickerViewW, 50);
        [self addSubview:_mTitleLab];
        _mTitleLab.text = @"请选择日期";
        _mTitleLab.textAlignment = NSTextAlignmentCenter;
        _mTitleLab.textColor = makeColorHex(@"333333");
        _mTitleLab.font = makeBlodFont(14);
        
        
        UIView *line = [[UIView alloc]initWithFrame:makeRect(0, _mTitleLab.bottom-0.5, SSDatePickerViewW, 0.5)];
        line.backgroundColor = CellLineColor;
        [self addSubview:line];
        
        
        //返回按钮
        _mBackBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mBackBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mBackBtn.left = 0;
        _mBackBtn.bottom = self.height;
        [self addSubview:_mBackBtn];
        _mBackBtn.tag = 10;
        _mBackBtn.titleLabel.font = makeFont(14);
        [_mBackBtn setTitle:@"取消" forState:UIControlStateNormal];
        [_mBackBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mBackBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //确认
        _mOKBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _mOKBtn.bounds = makeRect(0, 0, self.width * 0.5, 45);
        _mOKBtn.left = _mBackBtn.right;
        _mOKBtn.bottom = self.height;
        [self addSubview:_mOKBtn];
        _mOKBtn.tag = 11;
        _mOKBtn.titleLabel.font = makeBlodFont(14);
        [_mOKBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_mOKBtn setTitleColor:TitleColor forState:UIControlStateNormal];
        [_mOKBtn addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        
        //两个按钮之间的分割线
        UIView *line2 = [[UIView alloc]init];
        line2.bounds = makeRect(0, 0, 0.5, 45);
        line2.centerX = self.width * 0.5;
        line2.bottom = self.height;
        line2.backgroundColor = CellLineColor;
        [self addSubview:line2];
     
        
        UIView *line3 = [[UIView alloc]initWithFrame:makeRect(0, _mOKBtn.top, SSDatePickerViewW, 0.5)];
        line3.backgroundColor = CellLineColor;
        [self addSubview:line3];
        
        
        _datePicker = [[UIDatePicker alloc] init];
        _datePicker.frame = makeRect(0, 45, SSDatePickerViewW, SSDatePickerViewH-_mTitleLab.height-_mBackBtn.height);
        [self addSubview:_datePicker];
        //设置本地语言
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];
        //设置日期显示的格式
        _datePicker.datePickerMode = UIDatePickerModeDateAndTime;
        //监听datePicker的ValueChanged事件
        [_datePicker addTarget:self action:@selector(valueChange:) forControlEvents:UIControlEventValueChanged];
        
        [self valueChange:_datePicker];
        
    }
    return self;
}

- (void)valueChange:(UIDatePicker *)datePicker{
    //创建一个日期格式
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //设置日期的显示格式
    fmt.dateFormat = @"YYYY-MM-dd";
    //将日期转为指定格式显示
    _timeString = [fmt stringFromDate:datePicker.date];
    
}



//返回10  确认11
-(void)buttonPressed:(UIButton *)sender{
    if(_delegate && [_delegate respondsToSelector:@selector(SSDatePickerViewBtnClick:date:)]){
        [_delegate SSDatePickerViewBtnClick:sender.tag date:_timeString];
    }
    
}


@end






//时间选择器的控制器
@interface SSDatePickerController ()<SSDatePickerViewDelegate>

@end

@implementation SSDatePickerController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];

    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    _backView.alpha = 0.01;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewClick)];
    [_backView addGestureRecognizer: tap];
    
    
    _datePickerView = [[SSDatePickerView alloc]initWithFrame:makeRect(0, 0, SSDatePickerViewW, SSDatePickerViewH)];
    _datePickerView.delegate = self;
    _datePickerView.centerY = SCREEN_Height*0.5;
    _datePickerView.centerX = SCREEN_Width*0.5;
    _datePickerView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    
    [self.view addSubview:_backView];
    [self.view addSubview:_datePickerView];
    
    
}

-(void)setPickerViewAnimation{
    
    [UIView animateIn:_datePickerView];
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _backView.alpha = 0.5;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
    
}


-(void)pickerViewClick{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        _datePickerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        _backView.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [_datePickerView removeFromSuperview];
        [_backView removeFromSuperview];
        _datePickerView = nil;
        _backView = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}


#pragma SSDatePickerViewDelegate 返回10  确定11
-(void)SSDatePickerViewBtnClick:(NSInteger)index date:(NSString *)date{
    [self pickerViewClick];
    if(index==11){
        _datePickerBlock(date);
    }
}






@end
