//
//  SSImageGroupData.h
//  SSChatView
//
//  Created by soldoros on 2018/11/8.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#import <Foundation/Foundation.h>


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

//图片
@property(nonatomic,strong)NSString   *imgPath;

//视频
@property(nonatomic,strong)NSString   *videoPath;
@property(nonatomic,strong)NSString   *videoLocPath;

//图类型
@property(nonatomic,assign)SSImageGroupType   imageType;
//图片格式
@property (nonatomic, assign) UIViewContentMode contentMode;
//标签
@property(nonatomic,assign)NSInteger  itemTag;

//需要展示的图片/gif图片数组 图片视图
@property(nonatomic,strong)NSArray      *fromImages;
@property(nonatomic,strong)UIImageView  *fromImgView;


@end


