//
//  PBEditController.h
//  SSChat
//
//  Created by soldoros on 2019/6/5.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "BaseController.h"
#import "PBData.h"

@interface PBEditController : BaseController


/**
 通过编辑类型和编辑结果回调初始化编辑器

 @param type 编辑类型
 @param user 传入用户
 @return 返回编辑器对象
 */
-(instancetype)initWithType:(PBEditType)type user:(NIMUser *)user;


/**
 用户
 */
@property(nonatomic, assign)NIMUser *user;


/**
 编辑类型
 */
@property(nonatomic, assign)PBEditType type;


/**
 编辑结果回调代码块
 */
@property(nonatomic, copy)  PBEditHandle handle;


@end


