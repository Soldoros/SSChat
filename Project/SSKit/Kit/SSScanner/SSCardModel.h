//
//  SSCardModel.h
//  SSScanningCard
//
//  Created by soldoros on 2018/9/19.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SSCardModel : NSObject

//正面1  反面2
@property (nonatomic,assign) int type;
//身份证号
@property (nonatomic,copy) NSString *num;
//姓名
@property (nonatomic,copy) NSString *name;
//性别
@property (nonatomic,copy) NSString *gender;
//民族
@property (nonatomic,copy) NSString *nation;
//地址
@property (nonatomic,copy) NSString *address;
//签发机关
@property (nonatomic,copy) NSString *issue;
//有效期
@property (nonatomic,copy) NSString *valid;
//身份证图像
@property (nonatomic,strong) UIImage *image;



@end
