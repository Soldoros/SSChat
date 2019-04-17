//
//  SSRootManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSRootManager : NSObject<UITabBarControllerDelegate>

//管理登陆状态和根控制器的加载
@property(nonatomic,strong)NSUserDefaults      *user;

+(SSRootManager *)shareRootManager;

@end

