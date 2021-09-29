//
//  SSRootManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>



/**
 区分最外层框架使用哪种类型

 - ManagerTypePart: 部分页面需要登录展示的
 - ManagerTypeAll: 全部界面需要登录展示的
 */
typedef NS_ENUM(NSInteger,SSRootManagerType) {
    ManagerTypePart = 1,
    ManagerTypeAll,
};




/**
 以类族的模式管理 SSRootPartOfManager + SSRootAllOfManager
 */
@interface SSRootManager : NSObject

+(instancetype)shareRootManager:(SSRootManagerType)type;

//需要登录的页面下标
@property(nonatomic,strong)NSArray *needIndexs;

@end




/**
 部分界面需要登录显示
 */
@interface SSRootPartOfManager : SSRootManager <UITabBarControllerDelegate>

+(SSRootPartOfManager *)shareRootPartOfManager;

@end





/**
 全部界面需要登录显示
 */
@interface SSRootAllOfManager : SSRootManager

+(SSRootAllOfManager *)shareSSRootAllOfManager;

@end


