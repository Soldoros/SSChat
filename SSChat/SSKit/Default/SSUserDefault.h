//
//  SSUserDefault.h
//  2048
//
//  Created by soldoros on 2017/3/25.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface SSUserDefault : NSObject


+(SSUserDefault *)shareCKUserDefault;
-(void)initData;

//登录信息
@property(nonatomic,strong)NSDictionary *userDic;

//家人关系
@property(nonatomic,strong)NSDictionary *owner_relationship;

//主题色
@property(nonatomic, strong)UIColor   *titleColor;
@property(nonatomic, strong)UIColor   *tabBarColor;
//首页性别选择
@property(nonatomic, assign)NSInteger sex;
//网络状态
@property(nonatomic, assign)NSInteger netStatus;
@property(nonatomic, assign)BOOL      canNetWorking;
//购物车数量
@property(nonatomic, strong)NSString   *cartNumber;
//未读消息数量
@property(nonatomic, strong)NSString   *msgNumber;

@property(nonatomic, strong)UIImage   *userImage;

//强制更新 非强制更新的状态
@property(nonatomic,assign)BOOL   mustUpdate;
@property(nonatomic,assign)BOOL   notMustUpdate;

//售后申请弹出红色提示条
@property(nonatomic,assign)BOOL       showChance;
//售后详情弹出红色提示条
@property(nonatomic,strong)NSMutableDictionary   *showRedDict;




@end
