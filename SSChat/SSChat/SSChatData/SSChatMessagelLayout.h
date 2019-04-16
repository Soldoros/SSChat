//
//  SSChatMessagelLayout.h
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

/*======================================
 
 说实在的 这样写布局真麻烦  建议大家用三方布局或者系统自动布局
 个人在项目中用的是 UITableView+FDTemplateLayoutCell
 这个自适应的比系统自动布局快  代码量都差不多 控件不用自动布局是
 因为自动布局代码多  demo直接用常规frame设置间距和比例来搞定 习惯了
 
 //======================================*/

#import <Foundation/Foundation.h>
#import "SSChatMessage.h"


@interface SSChatMessagelLayout : NSObject


/**
 根据模型生成布局
 
 @param message 传入消息模型
 @return 返回布局对象
 */
-(instancetype)initWithMessage:(SSChatMessage *)message;


//消息模型
@property (nonatomic, strong) SSChatMessage  *message;

//消息布局到CELL的总高度
@property (nonatomic, assign) CGFloat      cellHeight;

//时间控件的frame
@property (nonatomic, assign) CGRect       timeLabRect;
//头像控件的frame
@property (nonatomic, assign) CGRect       headerImgRect;
//背景按钮的frame
@property (nonatomic, assign) CGRect       backImgButtonRect;
//背景按钮图片的拉伸膜是和保护区域
@property (nonatomic, assign) UIEdgeInsets imageInsets;

//文本间隙的处理
@property (nonatomic, assign) UIEdgeInsets textInsets;
//文本控件的frame
@property (nonatomic, assign) CGRect       textLabRect;

//语音时长控件的frame
@property (nonatomic, assign) CGRect       voiceTimeLabRect;
//语音波浪图标控件的frame
@property (nonatomic, assign) CGRect       voiceImgRect;


//视频控件的frame
@property (nonatomic, assign) CGRect       videoImgRect;



@end
