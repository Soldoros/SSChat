//
//  SSImageGroupData.h
//  SSChatView
//
//  Created by soldoros on 2018/11/8.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>



/**
 展示图类型
 
 - SSImageGroupImage: 图片
 - SSImageGroupGif: Gif图片
 - SSImageGroupVideo: 短视频
 */
typedef NS_ENUM(NSInteger, SSImageGroupType) {
    SSImageGroupImage = 1,
    SSImageGroupGif = 2,
    SSImageGroupVideo,
};



/**
 图片展示状态

 - SSImageShowValue1: 未展示
 - SSImageShowValue2: 放大展示
 - SSImageShowValue3: 滚动展示
 - SSImageShowValue4: 滚动隐藏
 */
typedef NS_ENUM(NSInteger, SSImageShowType) {
    SSImageShowValue1 = 1,
    SSImageShowValue2,
    SSImageShowValue3,
    SSImageShowValue4,
};




/**
 图片视图的cell 适用于 gif和普通图片
 */
@interface SSImageGroupItem : NSObject

//图类型
@property(nonatomic,assign)SSImageGroupType   imageType;

//需要展示的图片/gif图片数组 图片视图
@property(nonatomic,strong)UIImage      *fromImage;
@property(nonatomic,strong)NSArray      *fromImages;
@property(nonatomic,strong)UIImageView  *fromImgView;

//图片格式
@property (nonatomic, assign) UIViewContentMode contentMode;

//短视频路径
@property(nonatomic,strong)NSString      *videoPath;

//标签
@property(nonatomic,assign)NSInteger  itemTag;


@end


