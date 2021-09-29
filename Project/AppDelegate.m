//
//  AppDelegate.m
//  Project
//
//  Created by soldoros on 2021/9/5.
//
/*
 
 1.饮食清淡；主要食物范围包括：空心菜、土豆丝、番茄、鸡蛋、蘑菇、洋葱、排骨、
 瘦肉等蛋白质和蔬菜类。
 2.保持运动，每周跑步保持三次，每次至少1.5公里；
 步行至少5次，每次至少1.5公里；并保持其他有氧运动。
 3.每天晚上11点前休息。
 4.多看书，没两个月保持看完一本书。
 5.2022年元旦钱更新完ios社交系统，并发布上线。并在git更新一套ios库。
 6.提升技术栈；2021年过年前搞定安卓开发，2022年上半年搞定后台PHP开发，
 2022年下半年搞定前端开发。

 
 */


#import "AppDelegate.h"
#import "SSRootManager.h"
#import "SSFaceConfig.h"

@interface AppDelegate ()

@property(nonatomic,strong)SSConfigManager *config;

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        
    [SSFaceConfig shareFaceConfig];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = _config.backGroundColor;
    [self.window makeKeyAndVisible];
    _config = [SSConfigManager shareManager];
    [SSRootManager shareRootManager:ManagerTypePart].needIndexs = @[];
    
    return YES;
}



@end
