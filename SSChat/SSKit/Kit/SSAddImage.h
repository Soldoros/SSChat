//
//  SSAddImage.h
//  DEShop
//
//  Created by soldoros on 2017/5/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//



#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>



//通过UIAlertController 来确定获取方式的时候需要传入键值对
//一下为键值对的key值 目前只提供三种 (相册 图库 摄像头)
#define SSPickerWayFormIpc   @"SSPickerWayFormIpc"
#define SSPickerWayGallery   @"SSPickerWayGallery"
#define SSPickerWayCamer     @"SSPickerWayCamer"


/**
 访问方式

 - SSImagePickerWayFormIpc: 访问相册
 - SSImagePickerWayGallery: 访问图库
 - SSImagePickerWayCamer: 访问摄像头
 */
typedef NS_ENUM(NSInteger,SSImagePickerWayStyle) {
    SSImagePickerWayFormIpc=1,
    SSImagePickerWayGallery,
    SSImagePickerWayCamer,
};



/**
 获取资源类型

 - SSImagePickerModelImage: 获取图片
 - SSImagePickerModelVideo: 获取视频
 - SSImagePickerModelAll: 全部获取
 */
typedef NS_ENUM(NSInteger,SSImagePickerModelType) {
    SSImagePickerModelImage=1,
    SSImagePickerModelGif=2,
    SSImagePickerModelVideo,
    SSImagePickerModelAll,
};



/**
 获取资源后的回调代码块

 @param wayStyle 获取资源的方式
 @param modelType 获取到的资源类型（图片 视频）
 @param object 返回的资源数据 图片直接返回UIImage对象 视频返回本地视频链接
 */
typedef void (^SSAddImagePicekerBlock)(SSImagePickerWayStyle wayStyle,SSImagePickerModelType modelType,id object);


@interface SSAddImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//访问方式
@property(nonatomic,assign)SSImagePickerWayStyle wayStyle;
//获取资源类型
@property(nonatomic,assign)SSImagePickerModelType modelType;
//传入的控制器
@property(nonatomic,strong)UIViewController *controller;
//图片视频控制器核心对象
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
//获取资源后的回调代码块
@property(nonatomic,copy)SSAddImagePicekerBlock pickerBlock;




/**
 默认访问通过相册方位 获取图片类型

 @param controller 传入的控制器对象
 @param pickerBlock 资源回调代码块
 */
-(void)pickerWithController:(UIViewController *)controller pickerBlock:(SSAddImagePicekerBlock)pickerBlock;



/**
 通过相册和摄像头访问获取图片和视频资源

 @param controller 控制器对象
 @param wayStyle 访问方式
 @param modelType 资源类型
 @param pickerBlock 资源回调代码块
 */
-(void)pickerWithController:(UIViewController *)controller wayStyle:(SSImagePickerWayStyle)wayStyle modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock;


/**
 直接加载系统的Alert弹窗来判断获取资源的方式 (相册 拍照)

 @param controller 控制器对象
 @param modelType 资源类型
 @param pickerBlock 资源回调代码块
 */
-(void)getImagePickerWithAlertController:(UIViewController *)controller modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock;




/**
 直接加载系统的Alert弹窗来判断获取资源的方式 (相册 拍照...)

 @param controller 控制器对象
 @param alerts 系统Alert对象
 @param modelType 资源类型
 @param pickerBlock 资源回调代码块
 */
-(void)getImagePickerWithAlertController:(UIViewController *)controller alerts:(NSArray *)alerts modelType:(SSImagePickerModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock;






@end
