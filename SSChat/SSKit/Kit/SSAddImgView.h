//
//  SSAddImgView.h
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSAddImage.h"

//视图宽度
#define AddImgWidth     SCREEN_Width

//左右留白
#define AddLRSpace     15
//顶部底部留白
#define AddTBSpace     15
//图片间左右留白
#define AddImgLRSpace  15
//图片间上下留白
#define AddImgTBSpace  15

//每一行4张图
#define AddImgNum       4
//最大图片数目
#define AddImgMaxNum    5
//按钮、图片的尺寸
#define BtnSize      (AddImgWidth-2*AddLRSpace-(AddImgNum-1)*AddImgLRSpace)/AddImgNum
//视图初始化的总高度
#define AddimgViewH  BtnSize+2*AddTBSpace



@interface SSAddImgView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//获取图片
@property(nonatomic,strong)SSAddImage *mAddImage;


@property(nonatomic,strong)UIButton *mAddBtn;
@property(nonatomic,strong)NSMutableArray *images;
@property(nonatomic,strong)UIViewController *mController;
@property(nonatomic,assign)CGFloat imgheight;





@end
