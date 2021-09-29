//
//  SSGuideController.h
//  htcm
//
//  Created by soldoros on 2018/8/22.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "BaseViewController.h"



/**
 设置图片展示类型

 - SSScrollViewImageValue1: 普通图
 - SSScrollViewImageValue2: gif图片
 */
typedef NS_ENUM(NSInteger,SSScrollViewImageType) {
    SSScrollViewImageValue1 = 1,
    SSScrollViewImageValue2,
};



/**
 图片展开类型

 - SSScrollViewImageModel1: 展开占满屏幕
 - SSScrollViewImageModel2: 图片不拉伸显示在屏幕中间
 */
typedef NS_ENUM(NSInteger,SSScrollViewImageModel) {
    SSScrollViewImageModel1 = 1,
    SSScrollViewImageModel2,
};

/**
 图片来源

 - SSImageFromeUrl: 来源于网络
 - SSImageFromeLoacation: 来源于本地
 */
typedef NS_ENUM(NSInteger,SSImageFrome) {
    SSImageFromeUrl = 1,
    SSImageFromeLoacation,
};



@interface SSGuideController : BaseViewController



//图片展示类型
@property(nonatomic,assign)SSScrollViewImageType type;

//图片展开类型
@property(nonatomic,assign)SSScrollViewImageModel imageModel;

//数据源
@property(nonatomic,strong)NSArray *images;
//网络图片 本地图片
@property(nonatomic,assign)SSImageFrome frome;

@end






