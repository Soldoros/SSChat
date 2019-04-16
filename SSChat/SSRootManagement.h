//
//  SSRootManagement.h
//  SSChat
//
//  Created by soldoros on 2019/4/13.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SSRootManagement : NSObject<UITabBarControllerDelegate>

//管理登陆状态和根控制器的加载
@property(nonatomic,strong)NSUserDefaults      *user;

+(SSRootManagement *)shareRootManagement;

@end

