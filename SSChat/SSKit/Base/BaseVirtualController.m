//
//  BaseVirtualController.m
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseVirtualController.h"


@implementation BaseVirtualController


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
    self.navLine.backgroundColor = CellLineColor;
}

//删除导航栏
-(void)setNavgationNil{
    if(self.navtionBar){
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
        [self.navtionImgView addSubview:self.titleLab];
        self.titleLab.userInteractionEnabled = YES;
    }
    self.titleLab.font = font;
    self.titleLab.textColor = color;
}

//给导航栏标题赋值
-(void)setNavgaionTitle:(NSString *)str{
    if(!self.titleLab)return;
    self.titleLab.text = str;
    [self.titleLab sizeToFit];
    self.titleLab.width = self.titleLab.width>SCREEN_Width-100?SCREEN_Width-100:self.titleLab.width;
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
        self.rightBtn1.selected = NO;
        [self.leftBtn1 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
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
        self.leftBtn1.selected = NO;
        [self.leftBtn1 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    [self.leftBtn1 setImage:img forState:UIControlStateNormal];
    
}

//左侧文字按钮
-(void)setLeftOneBtnTitle :(NSString *)str{
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(10, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.left = 15;
        self.leftBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        [self.leftBtn1 setTitleColor:TitleColor forState:UIControlStateNormal];
        self.leftBtn1.titleLabel.font = makeFont(16);
        [self.leftBtn1 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    [self.leftBtn1 setTitle:str forState:UIControlStateNormal];
}

//右侧图片按钮
-(void)setRightOneBtnImg:(NSString *)str{
    
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height+5, NavBar_Height);
        self.rightBtn1.right = self.navtionImgView.width;
        self.rightBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        [self.rightBtn1 addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
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
        [self.rightBtn1 addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
    }
    [self.rightBtn1 setImage:img forState:UIControlStateNormal];
    
}

//右侧文字按钮
-(void)setRightOneBtnTitle:(NSString *)str{
    
    if(!self.rightBtn1){
        self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn1.showsTouchWhenHighlighted=YES;
        self.rightBtn1.contentHorizontalAlignment= UIControlContentHorizontalAlignmentRight;
        self.rightBtn1.right = self.navtionImgView.width-15;
        self.rightBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        [self.rightBtn1 addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
        self.rightBtn1.titleLabel.font = makeFont(16);
        self.rightBtn1.titleLabel.textAlignment = NSTextAlignmentRight;
        [self.rightBtn1 setTitleColor:TitleColor forState:UIControlStateNormal];
        [self.rightBtn1 setTitleColor:TitleColor forState:UIControlStateSelected];
        
    }
    
    [self.rightBtn1 setTitle:str forState:UIControlStateNormal];
    
}

//左侧两个图片按钮
-(void)setLeftBtnImg:(NSString *)str1 str2:(NSString *)str2{
    
    if(!self.leftBtn1){
        self.leftBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn1.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn1.left = 0;
        self.leftBtn1.top = StatuBar_Height;
        self.rightBtn1.selected = NO;
        [self.leftBtn1 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.leftBtn1];
    }
    
    if(!self.leftBtn2){
        self.leftBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.leftBtn2.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.leftBtn2.left = self.leftBtn1.right;
        self.leftBtn2.top = StatuBar_Height;
        self.leftBtn2.selected = NO;
        [self.leftBtn2 addTarget:self action:@selector(leftBtnCLick) forControlEvents:UIControlEventTouchUpInside];
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
        self.rightBtn1.tag = 10;
        [self.rightBtn1 addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.navtionBar addSubview:self.rightBtn1];
    }
    
    
    if(!self.rightBtn2){
        self.rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn2.bounds = CGRectMake(0, StatuBar_Height, NavBar_Height, NavBar_Height);
        self.rightBtn2.right = self.rightBtn1.left;
        self.rightBtn2.top = StatuBar_Height;
        self.rightBtn2.selected = NO;
        self.rightBtn2.tag = 11;
        [self.rightBtn2 addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(rightBtnClick:)];
    refreshItem.tag = 12;
    
    // 分享
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(rightBtnClick:)];
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
    btn1.tag = 10;
    [btn1 addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc] initWithCustomView:btn1];
    
    // 分享
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn2 setTitle:arr[1] forState:UIControlStateNormal];
    btn2.bounds = CGRectMake(0, 0, 40, 35);
    btn2.titleLabel.font = makeFont(18);
    btn2.tag = 11;
    [btn2 addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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

-(void)leftBtnCLick{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)rightBtnClick{
    
}

-(void)leftBtnCLick:(UIButton *)sender{
    
}

-(void)rightBtnClick:(UIButton *)sender{
    
}


//=========================================
//标签栏部分
//=========================================

-(void)setItemImg1:(NSString *)imgStr1 img2:(NSString *)imgStr2 title:(NSString *)titleStr color1:(UIColor *)color1 color2:(UIColor *)color2{
    
    UIImage *nomImg = [UIImage imageNamed:imgStr1];
    UIImage *secImg = [UIImage imageNamed:imgStr2];
    secImg = [secImg imageWithColor:color2];
    
    nomImg = [nomImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    secImg = [secImg imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:titleStr image:nomImg  selectedImage:secImg];
    self.tabBarItem = item;
    
    //    //tabBar图片居中显示，显示文字的坐标
    //    CGFloat offset = 5.0;
    //    //tabBar图片居中显示，不显示文字
    //    self.tabBarItem.imageInsets = UIEdgeInsetsMake(offset, 0, -offset, 0);
    
    //配置tabBarItem文字在普通状态和选中状态下的颜色
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:color1} forState:UIControlStateNormal];
    [UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName:color2} forState:UIControlStateSelected];
    
}

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
    
    NSArray *colors = @[BlueTitleColor,RedTitleColor];
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
    self.redView.backgroundColor = RoundViewColor;
    self.redView.clipsToBounds = YES;
    self.redView.layer.cornerRadius = 5;
}
//删除红色小圆点
-(void)deleteRedView{
    [self.redView removeFromSuperview];
    self.redView = nil;
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
    
    UIImageView *imgView = [UIImageView new];
    imgView.bounds = makeRect(0, 0, SCREEN_Width*0.66, SCREEN_Width*0.66*0.3);
    imgView.centerX = SCREEN_Width * 0.5;
    imgView.bottom = self.view.height * 0.5;
    imgView.image = [UIImage imageNamed:@"showtime"];
    [self.view addSubview:imgView];
    
    UILabel *lab = [UILabel new];
    lab.frame = imgView.bounds;
    lab.width = imgView.width - 20;
    lab.centerX = imgView.width*0.5;
    [imgView addSubview:lab];
    lab.font = makeFont(14);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor whiteColor];
    lab.numberOfLines = 2;
    lab.text = string;
    
    [UIView animateIn:imgView];
    
    double time = 1.5;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC));
    
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.3 animations:^{
            imgView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        } completion:^(BOOL finished) {
            [imgView removeFromSuperview];
        }];
        
    });
    
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



//系统提示弹窗
-(void)systemAlert:(NSString *)title msg:(NSString *)msg okButton:(NSString *)ok cancelButton:(NSString *)cancel  alertBlock:(AlertBlock)alertBlock{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        alertBlock(action);
        
    }];
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
        alertBlock(action);
    }];
    
    [defaultAction setValue:TitleColor forKey:@"_titleTextColor"];
    [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
    
    [alert addAction:defaultAction];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
}







@end
