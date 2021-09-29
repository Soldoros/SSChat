//
//  SSAddImgView.h
//  DEShop
//
//  Created by soldoros on 2017/5/18.
//  Copyright © 2017年 soldoros. All rights reserved.
//



/*
 
 
 _mImgView = [[SSAddImgView alloc]initWithFrame:makeRect(20, SafeAreaTop_Height + 20, SCREEN_Width - 40, 50)];
 [self.view addSubview:_mImgView];
 _mImgView.imgType = SSAddImgViewTypeVideo;
 [_mImgView setAddImgViewBlock:^(NSArray *imgPathDatas, CGFloat totalHeight) {
     
     cout(imgPathDatas);
     
 } clickBlock:^(NSArray *imgPathDatas, UIButton *sender) {
     
 }];
 
 
 */

#import <UIKit/UIKit.h>
#import "SSAddImage.h"


//添加block回调
typedef void (^SSAddImgViewBlock)(NSArray * imgPathDatas, CGFloat height);

//图片点击回调
typedef void (^SSAddImgClickBlock)(NSArray * imgPathDatas, UIImageView *imgView);


@interface SSAddImgView : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate>


@property(nonatomic,strong)UIImagePickerController *imagePickerController;

//媒体回调
@property(nonatomic,copy)SSAddImgViewBlock imgBlock;
@property(nonatomic,copy)SSAddImgClickBlock clickBlock;

-(void)setImgBlock:(SSAddImgViewBlock)imgBlock clickBlock:(SSAddImgClickBlock)clickBlock;

//相册  拍摄 视频
@property(nonatomic,strong)NSArray *controls;

@property(nonatomic,strong)NSString *type;

@property(nonatomic,assign)BOOL haveCover;

//控制器
@property(nonatomic,strong)UIViewController *mController;

//SSImageModelType
@property(nonatomic,assign)SSImageModelType modelType;

//视频数据
@property(nonatomic,strong)NSMutableArray *imgDatas;
//是否是键值对
@property(nonatomic,strong)NSString *keyword;


//添加按钮
@property(nonatomic,strong)UIButton *mButton;
//最大数量
@property(nonatomic,assign)NSInteger maxNumber;
//每行的数量
@property(nonatomic,assign)NSInteger rowNumber;

//显示的正方形尺寸
@property(nonatomic,assign)CGFloat size;
//列间距
@property(nonatomic,assign)CGFloat colSpace;
//行间距
@property(nonatomic,assign)CGFloat rowSpace;
//视图总高度
@property(nonatomic,assign)CGFloat totalHeight;


//获取图片/视频
@property(nonatomic,strong)SSAddImage *mAddImage;



@end
