//
//  PBDatas.h
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>



#define USER_Serchhistory    @"USER_Serchhistory"

/**
 搜索类型
 
 - PBSearchAllType1: 藏品
 - PBSearchAllType2: 圈子
 - PBSearchAllType3: 医院
 - PBSearchAllType4: 科室
 */
typedef NS_ENUM(NSInteger,PBSearchAllType) {
    PBSearchAllType1=1,
    PBSearchAllType2,
    PBSearchAllType3,
    PBSearchAllType4,
};


@interface PBDatas : NSObject



/// 保存搜索记录
/// @param string 传入搜索记录给本地单例
+(void)saveSearchHistory:(NSString *)string;


/// 删除某个搜索记录
/// @param string 传入要删除的搜索记录对象
+(void)deleteSearchHistory:(NSString *)string;

/// 获取搜索记录 返回数组
+(NSArray *)getSearchHistory;


//获取图片的数组json
+(NSMutableArray *)getImgJsonWithImgs:(NSArray *)imgs  key:(NSString *)key;

//播放视频
+(void)playVideo:(NSString *)urlString controller:(UIViewController *)controller;

@end



