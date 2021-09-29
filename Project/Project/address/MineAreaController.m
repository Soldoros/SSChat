//
//  MineAreaController.m
//  YongHui
//
//  Created by soldoros on 2019/7/2.
//  Copyright © 2019 soldoros. All rights reserved.
//


//选择省市区
#import "MineAreaController.h"

@interface MineAreaController ()<UIPickerViewDelegate,UIPickerViewDataSource>{
    NSArray *provinceArr,*cityArr,*areaArr;
    NSString *province,*city,*area;
}

@property (nonatomic, strong)UIPickerView *areaPicker;
@property (nonatomic, strong)UIView *bottomView;
@property (nonatomic, strong)UIButton *mButton;

@property(nonatomic,strong)UIView *backView;

@end

@implementation MineAreaController

-(instancetype)init{
    if(self = [super init]){
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    
    _backView = [[UIView alloc]initWithFrame:self.view.bounds];
    _backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_backView];
    _backView.alpha = 0.01;
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pickerViewClick)];
    [_backView addGestureRecognizer: tap];
    
    
    _bottomView = [[UIView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, 400)];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    _bottomView.top = SCREEN_Height;
    
    _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _mButton.bounds = makeRect(0, 0, 70, 30);
    _mButton.right = SCREEN_Width - 10;
    _mButton.top = 10;
    [_bottomView addSubview:_mButton];
    [_mButton setTitle:@"确定" forState:UIControlStateNormal];
    [_mButton setTitleColor:TitleColor forState:UIControlStateNormal];
    [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _areaPicker = [UIPickerView new];
    _areaPicker.frame = makeRect(0, 100, SCREEN_Width, 300);
    [_bottomView addSubview:_areaPicker];
    _areaPicker.dataSource = self;
    _areaPicker.delegate = self;
    
    [self netWorking];
}

-(void)setSSPickerViewAnimation{

    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.backView.alpha = 0.5;
        self.bottomView.bottom = SCREEN_Height - SafeAreaBottom_Height;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
    }];
}

-(void)pickerViewClick{
    self.view.userInteractionEnabled = NO;
    [UIView animateWithDuration:0.3 animations:^{
        self.bottomView.top = SCREEN_Height;
        self.backView.alpha = 0.01;
    } completion:^(BOOL finished) {
        self.view.userInteractionEnabled = YES;
        [self.bottomView removeFromSuperview];
        [self.backView removeFromSuperview];
        self.bottomView = nil;
        self.backView = nil;
        [self dismissViewControllerAnimated:NO completion:nil];
    }];
}

-(void)netWorking{
    
    provinceArr = [[NSMutableArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
    cityArr = [[provinceArr objectAtIndex:0] objectForKey:@"cities"];
    areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
    
    
    province = [[provinceArr objectAtIndex:0] objectForKey:@"state"];
    city = [[cityArr objectAtIndex:0] objectForKey:@"city"];
    area = @"";
    
    [_areaPicker reloadAllComponents];
}
    
#pragma mark - UIPickerViewDelegate
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (component==0) {
        
        return [provinceArr count];
        
    }else if(component==1){
        return [cityArr count];
    }else{
        return [areaArr count];
    }
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component==0) {
        
        
        province = [[provinceArr objectAtIndex:row] objectForKey:@"state"];
        
        cout(province);
        
        cityArr = [[provinceArr objectAtIndex:row] objectForKey:@"cities"];
      
        [self pickerView:pickerView didSelectRow:0 inComponent:1];
        
        [self.areaPicker reloadComponent:1];
        
        if ([cityArr count]!=0) {
            
            areaArr = [[cityArr objectAtIndex:0] objectForKey:@"areas"];
            
            [pickerView selectRow:0 inComponent:2 animated:NO];
            
            [self.areaPicker reloadComponent:2];
            
            if(areaArr.count==0){
                area = @"";
            }
        }
        
    }
    
    else if (component==1){
        
        city = [[cityArr objectAtIndex:row] objectForKey:@"city"];
        cout(city);
        
        areaArr = [[cityArr objectAtIndex:row] objectForKey:@"areas"];
        if(areaArr.count>0){
            area = [areaArr objectAtIndex:0];
        }else{
            area = @"";
        }
        
//        [pickerView selectRow:0 inComponent:2 animated:NO];
        [self pickerView:pickerView didSelectRow:0 inComponent:2];
        
        [self.areaPicker reloadComponent:2];
        
    }
    
    else{
        if(areaArr.count > row){
            area = [areaArr objectAtIndex:row];
        }else if(areaArr.count == 0){
            area = @"";
        }
        cout(area);
    }
}



/**
 
 *通过自定义view去显示pickerView中的内容,这样做的好处是可以自定义的调整pickerView中显示内容的格式
 
 */
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    
    UILabel *myView = nil;
    
    myView = [[UILabel alloc] initWithFrame:CGRectMake(0.0, 0.0, 100, 30)];
    
    myView.textAlignment = NSTextAlignmentCenter;
    
    myView.font = [UIFont systemFontOfSize:15];         //用label来设置字体大小
    
    if (component==0) {
        
        myView.text =[[provinceArr objectAtIndex:row] objectForKey:@"state"];
        
    }else if (component==1)
        
    {
        
        myView.text =[[cityArr objectAtIndex:row] objectForKey:@"city"];
        
    }else
        
    {
        myView.text = [areaArr objectAtIndex:row];
        
    }
    
    return myView;
    
}


//确定
-(void)buttonPressed:(UIButton *)sender{
    
    
    if(self.handle){
        self.handle(province, city, area);
    }
    
    [self pickerViewClick];
}



@end


