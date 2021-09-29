//
//  BaseVirtualController.m
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseVirtualController.h"



@implementation BaseVirtualController


-(void)setViewFrame:(CGRect)viewFrame{
    _viewFrame = viewFrame;
    self.view.frame = viewFrame;
}


//=========================================
//导航栏部分
//=========================================


//导航栏视图 用切图
-(void)setNavgationBarImg:(NSString *)str{
    if(!self.navtionBar){
        self.navtionBar = [[UIImageView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SafeAreaTop_Height)];
        self.navtionBar.userInteractionEnabled = YES;
        [self.view addSubview:self.navtionBar];
    }
    
    if(!self.navtionImgView){
        self.navtionImgView = [[UIImageView alloc]initWithFrame:self.navtionBar.bounds];
        self.navtionImgView.contentMode = UIViewContentModeTop;
        [self.navtionBar addSubview:self.navtionImgView];
        self.navtionImgView.userInteractionEnabled = YES;
    }
    
    self.navtionImgView.image = [UIImage imageNamed:str];
}


//导航栏视图 用颜色
-(void)setNavgationBarColor:(UIColor *)color{
    if(!self.navtionBar){
        self.navtionBar = [[UIImageView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SafeAreaTop_Height)];
        self.navtionBar.userInteractionEnabled = YES;
        [self.view addSubview:self.navtionBar];
    }
    self.navtionBar.backgroundColor = color;
    
    if(!self.navtionImgView){
        self.navtionImgView = [[UIImageView alloc]initWithFrame:self.navtionBar.bounds];
        [self.navtionBar addSubview:self.navtionImgView];
        self.navtionImgView.userInteractionEnabled = YES;
    }
    self.navtionImgView.image = nil;
    self.navtionImgView.backgroundColor = color;
}


//导航栏视图 用颜色视图
-(void)setNavgationBarColorImg:(UIColor *)color{
    if(!self.navtionBar){
        self.navtionBar = [[UIImageView alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, SafeAreaTop_Height)];
        self.navtionBar.userInteractionEnabled = YES;
        [self.view addSubview:self.navtionBar];
    }
    
    if(!self.navtionImgView){
        self.navtionImgView = [[UIImageView alloc]initWithFrame:self.navtionBar.bounds];
        [self.navtionBar addSubview:self.navtionImgView];
        self.navtionImgView.userInteractionEnabled = YES;
    }
    self.navtionImgView.image = [UIImage imageFromColor:color];
}

//给导航栏添加一条线
-(void)setNavgationBarLine:(UIColor *)color{
    if(!self.navtionImgView)return;
    if(!self.navLine){
        self.navLine = [UIView new];
        self.navLine.frame = makeRect(0, 0, SCREEN_Width, 0.5);
        self.navLine.bottom = self.navtionImgView.height;
        [self.navtionImgView addSubview:self.navLine];
    }
    self.navLine.backgroundColor = LineColor;
}

//删除导航栏
-(void)setNavgationNil{
    if(self.navtionBar){
        [self.navLine removeFromSuperview];
        self.navLine = nil;
        [self.navtionBar.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.navtionBar removeFromSuperview];
        self.navtionBar = nil;
    }
}


//导航栏标题属性
-(void)setNavgationTitleFont:(UIFont *)font color:(UIColor *)color{
    if(!self.titleLab){
        self.titleLab = [[UILabel alloc]initWithFrame:makeRect(0, StatuBar_Height, SCREEN_Width, NavBar_Height)];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self.navtionBar addSubview:self.titleLab];
        self.titleLab.userInteractionEnabled = YES;
    }
    self.titleLab.font = font;
    self.titleLab.textColor = color;
}

//给导航栏标题赋值
-(void)setNavgaionTitle:(NSString *)str{

    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.text = str;
    [self.titleLab sizeToFit];
    self.titleLab.width = 200;
    self.titleLab.centerX = self.navtionImgView.width*0.5;
    self.titleLab.centerY = StatuBar_Height+NavBar_Height*0.5;
}

//导航栏主题图片
-(void)setNavgaionTitleImg:(NSString *)str{
    if(self.titleImgView==nil){
        self.titleImgView = [[UIImageView alloc]initWithFrame:makeRect(0, StatuBar_Height, (NavBar_Height-25)*63/22, NavBar_Height-25)];
        [self.navtionImgView addSubview:self.titleImgView];
        self.titleImgView.userInteractionEnabled = YES;
        self.titleImgView.centerX = self.navtionImgView.width*0.5;
        self.titleImgView.centerY = StatuBar_Height+NavBar_Height*0.5;
    }
    self.titleImgView.image = [UIImage imageNamed:str];
}


//导航栏主题按钮 (报告对比的导航栏按钮筛选)
-(void)setNavgaionTitleButton:(NSString *)str{
    if(self.titleButton==nil){
        self.titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        self.titleButton.bounds = makeRect(0, StatuBar_Height, SCREEN_Width*0.5, NavBar_Height-10);
        [self.navtionBar addSubview:self.titleButton];
        self.titleButton.userInteractionEnabled = YES;
        self.titleButton.centerX = self.navtionImgView.width*0.5;
        self.titleButton.centerY = StatuBar_Height+NavBar_Height*0.5;
        [self.titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [UIButton textImage:self.titleButton];
        [self.titleButton setImage:[UIImage imageNamed:@"shaixuan_jiantou"] forState:UIControlStateNormal];
        [self.titleButton setImage:[UIImage imageNamed:@"shaixuan_jiantou2"] forState:UIControlStateSelected];
        [self.titleButton addTarget:self action:@selector(titleButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    [self.titleButton setTitle:str forState:UIControlStateNormal];
    [UIButton textImage:self.titleButton];
}

-(void)titleButtonClick{
    
}


//左侧图片按钮
-(void)setLeftOneBtnImg :(NSString *)str{
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.left = 0;
        self.leftBtn1.top = StatuBar_Height;
        self.leftBtn1.tag = 10;
        [self.leftBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    [self.leftBtn1 setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
    
}

//左侧控制颜色的图片按钮
-(void)setLeftOneBtnImg:(NSString *)str color:(UIColor *)color{
    
    UIImage *img = [UIImage imageNamed:str];
    img = [img imageWithColor:color];
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.left = 0;
        self.leftBtn1.top = StatuBar_Height;
        self.leftBtn1.tag = 10;
        [self.leftBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    [self.leftBtn1 setImage:img forState:UIControlStateNormal];
    
}

//左侧文字按钮
-(void)setLeftOneBtnTitle :(NSString *)str{
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(10, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.tag = 10;
        self.leftBtn1.left = 15;
        self.leftBtn1.top = StatuBar_Height;
        [self.leftBtn1 setTitleColor:NavBarTitColor forState:UIControlStateNormal];
        self.leftBtn1.titleLabel.font = makeFont(14);
        [self.leftBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    [self.leftBtn1 setTitle:str forState:UIControlStateNormal];
}

//设置左侧头像按钮
-(void)setLeftImgButton{
    [self setLeftOneBtnImg:@"headerImg"];
    self.leftBtn1.bounds = makeRect(0, 0, 32, 32);
    self.leftBtn1.left = 10;
    self.leftBtn1.centerY = self.titleLab.centerY;
    self.leftBtn1.clipsToBounds = YES;
    self.leftBtn1.layer.cornerRadius = 16;
    self.leftBtn1.tag = 10;
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *headerImg = [[user valueForKey:@""] imageString];
    [self.leftBtn1 setImageWithURL:[NSURL URLWithString:headerImg] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"headerImg"]];
    self.leftBtn1.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.leftBtn1.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentFill;
    self.leftBtn1.contentVerticalAlignment =  UIControlContentVerticalAlignmentFill;
    

}

//右侧图片按钮
-(void)setRightOneBtnImg:(NSString *)str{
    
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height+5, NavBar_Height);
        self.rightBtn1.right = self.navtionImgView.width;
        self.rightBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        self.rightBtn1.tag = 12;
        [self.rightBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
    }
    [self.rightBtn1 setImage:[UIImage imageNamed:str] forState:UIControlStateNormal];
}

//右侧控制颜色的图片按钮
-(void)setRightOneBtnImg:(NSString *)str color:(UIColor *)color{
    
    UIImage *img = [UIImage imageNamed:str];
    img = [img imageWithColor:color];
    
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn1.right = self.navtionImgView.width-5;
        self.rightBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        self.rightBtn1.tag = 12;
        [self.rightBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
    }
    [self.rightBtn1 setImage:img forState:UIControlStateNormal];
    
}

//右侧文字按钮 12
-(void)setRightOneBtnTitle:(NSString *)str{
    
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn1.showsTouchWhenHighlighted = NO;
        self.rightBtn1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
        self.rightBtn1.selected = NO;
        self.rightBtn1.tag = 12;
        [self.rightBtn1 addTarget:self action:@selector(navgationButtonPressed:)  forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
        self.rightBtn1.titleLabel.font = makeFont(14);
        self.rightBtn1.titleLabel.textAlignment = NSTextAlignmentRight;
    }
    
    [self.rightBtn1 setTitleColor:NavBarTitColor forState:UIControlStateNormal];
    [self.rightBtn1 setTitleColor:NavBarTitColor forState:UIControlStateSelected];
    [self.rightBtn1 setTitle:str forState:UIControlStateNormal];
    [self.rightBtn1.titleLabel sizeToFit];
    self.rightBtn1.bounds = self.rightBtn1.titleLabel.bounds;
    self.rightBtn1.height = NavBar_Height;
    self.rightBtn1.width += 10;
    self.rightBtn1.right = self.navtionImgView.width-15;
         self.rightBtn1.top = StatuBar_Height;
    
}

//左侧两个图片按钮
-(void)setLeftBtnImg:(NSString *)str1 str2:(NSString *)str2{
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.left = 0;
        self.leftBtn1.top = StatuBar_Height;
        self.leftBtn1.tag = 10;
        [self.leftBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    
    if(!self.leftBtn2){
        self.leftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn2.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn2.left = self.leftBtn1.right;
        self.leftBtn2.top = StatuBar_Height;
        self.leftBtn2.selected = NO;
        self.leftBtn2.tag = 11;
        [self.leftBtn2 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn2];
    }
    
    
    [self.leftBtn1 setImage:[UIImage imageNamed:str1] forState:UIControlStateNormal];
    [self.leftBtn2 setImage:[UIImage imageNamed:str2] forState:UIControlStateNormal];
    
}


//右侧两个图片按钮
-(void)setRightBtnImg:(NSString *)str1 str2:(NSString *)str2{
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn1.right = self.navtionImgView.width;
        self.rightBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        self.rightBtn1.tag = 12;
        [self.rightBtn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
    }
    
    
    if(!self.rightBtn2){
        self.rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn2.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn2.right = self.rightBtn1.left;
        self.rightBtn2.top = StatuBar_Height;
        self.rightBtn2.selected = NO;
        self.rightBtn2.tag = 13;
        [self.rightBtn2 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn2];
    }
    
    [self.rightBtn1 setImage:[UIImage imageNamed:str1] forState:UIControlStateNormal];
    [self.rightBtn2 setImage:[UIImage imageNamed:str2] forState:UIControlStateNormal];
    
}


//左侧图片按钮组
-(void)setLeftBtnImgArr :(NSArray *)arr{
    
}
//左侧文字按钮组
-(void)setLeftBtnTitleArr :(NSArray *)arr{
    
}
//右侧图片按钮组
-(void)setRightBtnImgArr:(NSArray *)arr{
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(navgationButtonPressed:)];
    refreshItem.tag = 12;
    
    // 分享
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(navgationButtonPressed:)];
    shareItem.tag = 13;
    
    // 显示在导航栏右侧
    self.navigationItem.rightBarButtonItems = @[refreshItem,  shareItem];
    
}
//右侧文字按钮组
-(void)setRightBtnTitleArr:(NSArray *)arr{
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn1 setTitle:arr[0] forState:UIControlStateNormal];
    btn1.bounds = CGRectMake(0, 0, 40, 35);
    btn1.titleLabel.font = makeFont(18);
    btn1.tag = 12;
    [btn1 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    // 分享
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:arr[1] forState:UIControlStateNormal];
    btn2.bounds = CGRectMake(0, 0, 40, 35);
    btn2.titleLabel.font = makeFont(18);
    btn2.tag = 13;
    [btn2 addTarget:self action:@selector(navgationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    // 显示在导航栏右侧
    self.navigationItem.rightBarButtonItems = @[refreshItem,  shareItem];
    
}



//设置导航栏背景色
-(void)setNavgationBarBackcolor:(UIColor *)color{
    self.navigationController.navigationBar.barTintColor = color;
}
//设置导航栏控件颜色
-(void)setNavgationBarTintcolor:(UIColor *)color{
    self.navigationController.navigationBar.tintColor = color;
}
//设置导航栏标题颜色
-(void)setNavgationBarTitlecolor:(UIColor *)color size:(double)size{
    self.navigationController.navigationBar.tintColor = color;
    
    
    
    NSDictionary *titleTextAttributes = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:size],NSForegroundColorAttributeName:color};
    self.navigationController.navigationBar.titleTextAttributes = titleTextAttributes;
}

//设置导航栏的图片 用颜色设置
-(void)setNavgationBarImgAtColor:(UIColor *)color{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageFromColor:color] forBarMetrics:UIBarMetricsDefault];
    
}

//设置导航栏的图片 用本地图片设置
-(void)setNavgationBarImgAtString:(NSString *)string{
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:string] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.userInteractionEnabled = YES;
    
}

//用颜色设置工具栏的图片
-(void)setToorBarImgAtColor:(UIColor *)color{
    
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageFromColor:color] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
}

//用本地图片设置工具栏的图片
-(void)setToorBarImgAtString:(NSString *)string{
    
    [self.navigationController.toolbar setBackgroundImage:[UIImage imageNamed:string] forToolbarPosition:UIBarPositionBottom barMetrics:UIBarMetricsDefault];
}


-(void)navgationButtonPressed:(UIButton *)sender{
    if([sender isEqual:self.leftBtn1]){
        [self.navigationController popViewControllerAnimated:YES];
    }
}


//=========================================
//标签栏部分
//=========================================

//设置一个特殊的tabbarItem
-(void)setSpecialTabBarItem:(NSString *)img1 img2:(NSString *)img2 title:(NSString *)title color1:(UIColor *)color1 color2:(UIColor *)color2{
    
}

//设置底部一个大按钮
-(void)setToolBtnTitle:(NSString *)title{
    
    
    UIBarButtonItem *toolBarBtn = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(toolBarBtnClick)];
    toolBarBtn.tintColor = [UIColor whiteColor];
    
    // 空间延展控件
    UIBarButtonItem *flexibleItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    // 在工具栏上添加按钮  所有的按钮之间用延展控件隔开
    self.toolbarItems = @[flexibleItem,toolBarBtn,flexibleItem];
    
}


//底部两个按钮
-(void)setBottomBtnTwo:(NSArray *)array
{
    UIView *bottomView = [[UIView alloc]initWithFrame:makeRect(0, SCREEN_Height-44-SafeAreaTop_Height, SCREEN_Width, 44)];
    bottomView.backgroundColor = BackGroundColor;
    [self.view addSubview:bottomView];
    
    NSArray *colors = @[TitleColor,TitleColor];
    for(int i=0;i<2;++i){
        UIButton  *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = makeRect(i*bottomView.width/2,0 , bottomView.width/2, bottomView.height);
        btn.backgroundColor = colors[i];
        btn.tag = 10+i;
        [btn setTitle:array[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(bottomBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [bottomView addSubview:btn];
    }
    
}


-(void)toolBarBtnClick{
    
}

-(void)bottomBtnClick:(UIButton *)sender{
    
}

-(void)leftToolBarBtnClick{
    
}
-(void)rightToolBarBtnClick{
    
}




//打电话
-(void)callPhone:(NSString *)phone{
    
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        NSString* phoneStr = [NSString stringWithFormat:@"tel://%@",phone];
        if ([phoneStr hasPrefix:@"sms:"] || [phoneStr hasPrefix:@"tel:"]) {
            UIApplication * app = [UIApplication sharedApplication];
            if ([app canOpenURL:[NSURL URLWithString:phoneStr]]) {
                [app openURL:[NSURL URLWithString:phoneStr]];
            }
        }
        
    }];
    
}

-(void)method{
    self.view.userInteractionEnabled = YES;
}



//导航栏右侧按钮红点处理
-(void)setRedViewOnRightButton{
    self.redView = [[UIView alloc]initWithFrame:makeRect(25, 31+StatuBar_Height-20, 8, 8)];
    [self.rightBtn1 addSubview:self.redView];
    self.redView.backgroundColor = makeColorRgb(230, 35, 41);
    self.redView.clipsToBounds = YES;
    self.redView.layer.cornerRadius = 5;
}
//删除红色小圆点
-(void)deleteRedView{
    [self.redView removeFromSuperview];
    self.redView = nil;
}



//红色数字
-(void)setRedLab:(NSInteger)index{
    
    if(_redLabel == nil){
        _redLabel = [UILabel new];
    }
    
    if(index == 0){
        [_redLabel removeFromSuperview];
        _redLabel = nil;
        return;
    }
    
    _redLabel.bounds = makeRect(0, 0, 40, 20);
    _redLabel.text = makeStrWithInt(index);
    _redLabel.backgroundColor = [UIColor colorWithHexString:@"#E62255"];
    _redLabel.textColor = [UIColor whiteColor];
    _redLabel.font = [UIFont boldSystemFontOfSize:10];
    _redLabel.textAlignment = NSTextAlignmentCenter;
    _redLabel.clipsToBounds = YES;
    [_redLabel sizeToFit];
    _redLabel.width += 8;
    _redLabel.height = 13;
    _redLabel.layer.cornerRadius = _redLabel.height * 0.5;
    
}


//=========================================
//显示部分
//=========================================


//默认选择了系统的 时间为1秒
-(void)showTime:(NSString *)message{
    [self showTimeBlack:message];
    
}

//显示黑色半透明提示
-(void)showTimeBlack:(NSString *)string{
    [self.view showTimeBlack:string];
}


//显示一个提示信息 停留两秒
-(void)showTimeMsg:(NSString *)msg{
    CGFloat padding = 10;
    
    YYLabel *label = [YYLabel new];
    label.text = msg;
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor =  ButtonColor;
    label.width = self.view.width;
    label.textContainerInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    label.height = [msg heightForFont:label.font width:label.width] + 2*padding;
    label.numberOfLines = 0;
    
    label.bottom = (kiOS7Later ? 0 : 0);
    [self.view addSubview:label];
    [UIView animateWithDuration:0.3 animations:^{
        label.top = (kiOS7Later ? 0 : 0);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:1.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            label.bottom = (kiOS7Later ? 0 : 0);
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}


//添加加载指示器
-(void)addSysIndicatorView{
    
    if(self.indicatorView == nil){
        self.indicatorView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        [self.view addSubview:self.indicatorView];
    }
    //设置小菊花的frame
    self.indicatorView.bounds= CGRectMake(0, 0, 80, 80);
    self.indicatorView.centerY = SCREEN_Height * 0.5;
    self.indicatorView.centerX = SCREEN_Width * 0.5;
    self.indicatorView.clipsToBounds = YES;
    self.indicatorView.layer.cornerRadius = 5;
    //设置小菊花颜色
    self.indicatorView.color = [UIColor whiteColor];
    //设置背景颜色
    self.indicatorView.backgroundColor = makeColorHex(@"#333333");
   //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
    self.indicatorView.hidesWhenStopped = NO;
    [self.indicatorView startAnimating];
}

-(void)deleteSysIndicatorView{
    [self.indicatorView stopAnimating];
    [self.indicatorView removeFromSuperview];
    self.indicatorView = nil;
}



//网络加载指示器
-(void)initRequestLoadingStatus:(CGRect)frame superView:(UIView *)superView{
    self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:frame superView:superView];
}

//删除网络加载指示器
-(void)deleteLoadingStatus{
    
    [self.loadingStatus stopLoadingImageAnimation];
    [self.loadingStatus removeFromSuperview];
    self.loadingStatus = nil;
}



@end
