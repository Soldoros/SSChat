//
//  SSChatDefault.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.


#import <Foundation/Foundation.h>

#import "SSChatModelLayout.h"


//环信 测试key
//#define EMAPPKey       @"1165171110115166#h5"
//#define APNSKey        @"xiandayang"
//#define ClientID       @"YXA647eycMXsEeeI3pV0J4EA_Q"
//#define ClientSecret   @"YXA6grnjJdjCoRKAB8Aq"
//#define OrgName        @"1165171110115166"

//环信 正式key
#define EMAPPKey       @"1165171110115166#xiandayang"
#define APNSKey        @"xiandayang"
#define ClientID       @"YXA6s93LoM3IEeeL4Jn45pzAmQ"
#define ClientSecret   @"YXA6Ykf_scxzI_tlrAcJEBNS5PQy8ec"
#define OrgName        @"1165171110115166"



@interface SSChatDefault : NSObject<EMClientDelegate,EMContactManagerDelegate,EMChatManagerDelegate>


/**
 返回单例

 @return 返回当前对象
 */
+(SSChatDefault *)shareSSChatDefault;

//初始化
-(void)initSSChat;

//注册
-(void)sschatRegister;








@end
