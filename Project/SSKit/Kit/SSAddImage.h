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


/**
 获取资源类型

 - SSImageModelImage: 获取图片
 - SSImageModelGif: 获取gif
 - SSImageModelVideo: 获取视频
 - SSImageModelAll: 全部获取
 */
typedef NS_ENUM(NSInteger,SSImageModelType) {
    SSImageModelImage=1,
    SSImageModelGif=2,
    SSImageModelVideo=3,
    SSImageModelAll=4,
};


typedef void (^SSAddImagePicekerBlock)(SSImageModelType modelType,id object);


@interface SSAddImage : NSObject<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//获取资源类型
@property(nonatomic,assign)SSImageModelType modelType;
//控制器
@property(nonatomic,strong)UIViewController *mController;
//图片视频控制器核心对象
@property(nonatomic,strong)UIImagePickerController *imagePickerController;
//获取资源后的回调代码块
@property(nonatomic,copy)SSAddImagePicekerBlock pickerBlock;


-(void)getImgWithModelType:(SSImageModelType)modelType pickerBlock:(SSAddImagePicekerBlock)pickerBlock;

@end



