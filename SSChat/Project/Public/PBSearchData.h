//
//  PBSearchData.h
//  DEShop
//
//  Created by soldoros on 2017/5/4.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



/**
 搜索的类型

 - PBSearchDoctorType: 搜索医生
 - PBSearchDepartmentType: 搜索科室
 - PBSearchDiseaseType: 搜索疾病
 */
typedef NS_ENUM(NSInteger,PBSearchType) {
    PBSearchDoctorType=1,
    PBSearchDepartmentType,
    PBSearchDiseaseType,
};


/**
 搜索类型
 
 - PBSearchAllType1: 会话搜索
 - PBSearchAllType2: 添加好友搜索
 - PBSearchAllType3: 好友搜索
 - PBSearchAllType4: 黑名单搜索
 */
typedef NS_ENUM(NSInteger,PBSearchAllType) {
    PBSearchAllType1=1,
    PBSearchAllType2,
    PBSearchAllType3,
    PBSearchAllType4,
};



@interface PBSearchData : NSObject

@end
