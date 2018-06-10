//
//  SSChatModelLayout.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.


#import <Foundation/Foundation.h>
#import "SSChatModel.h"


//环信登录账号
#define SSChatSendUserName     @"13540033103"
//环信接收账号
#define SSChatReceiveUserName  @"13438530193"


#define SSChatCellColor  makeColorRgb(250, 250, 250)


//订单的类型判断  文本1  预购2  直接购买2
#define OrderType  @"type"


//好友添加的通知
#define NotiAddFriend           @"NotiAddFriend"
//收到普通消息通知
#define NotiReceiveMessages     @"NotiReceiveMessages"
//收到透传消息通知
#define NotiReceiveCMDMessages  @"NotiReceiveCMDMessages"

//透传消息的key
#define REVOKE_FLAG             @"REVOKE_FLAG"

//输入框文字发生变化
#define NotiTextChange          @"NotiTextChange"


//顶部商品部分
#define SSChatViewH  70



//多功能视图和表情视图的设置
#define SSChatKeyBordHeight     220          //多功能视图的高度

//输入框的一些设置 backview的高
#define SSChatBackViewHeight    SCREEN_Height-SSChatBotomHeight-SafeAreaTop_Height-SafeAreaBottom_Height
//backview的高 弹出了多功能视图
#define SSChatBackViewHeight2   SCREEN_Height-SSChatBotomHeight-SafeAreaTop_Height-SafeAreaBottom_Height-SSChatKeyBordHeight
#define SSChatBackViewTop       0            //backview的top
#define SSChatLineHeight        0.5          //线条高度
#define SSChatBotomHeight       49           //底部视图的高度
#define SSChatBotomTop          SCREEN_Height-SSChatBotomHeight-SafeAreaBottom_Height                    //底部视图的顶部
#define SSChatBtnSize           30           //按钮的大小
#define SSChatLeftDistence      5            //左边间隙
#define SSChatRightDistence     5            //左边间隙
#define SSChatBtnDistence       10           //控件之间的间隙
#define SSChatTextHeight        33           //输入框的高度
#define SSChatTextMaxHeight     83           //输入框的最大高度
#define SSChatTextWidth      SCREEN_Width - (3*SSChatBtnSize + 5* SSChatBtnDistence)                       //输入框的宽度

#define SSChatTBottomDistence   8            //输入框上下间隙
#define SSChatBBottomDistence   8.5          //按钮上下间隙




//cell的一些设置
#define SSChatCellTop           15           //顶部距离cell
#define SSChatCellBottom        15           //底部距离cell
#define SSChatIconWH            44           //原型头像尺寸
#define SSChatIconLeft          10           //头像与左边距离
#define SSChatIconRight         10           //头像与右边距离
#define SSChatDetailLeft        10           //详情与左边距离
#define SSChatDetailRight       10           //详情与右边距离
#define SSChatTextTop           12           //文本距离详情顶部
#define SSChatTextBottom        12           //文本距离详情底部
#define SSChatTextLRS           12           //文本左右短距离
#define SSChatTextLRB           25           //文本左右长距离

//显示时间
#define SSChatTimeWidth         180          //时间宽度
#define SSChatTimeHeight        20           //时间高度
#define SSChatTimeTop           10           //时间距离顶部
#define SSChatTimeBottom        25           //时间距离底部


#define SSChatAirTop            35           //气泡距离详情顶部
#define SSChatAirLRS            10           //气泡左右短距离
#define SSChatAirBottom         10           //气泡距离详情底部
#define SSChatAirLRB            22           //气泡左右长距离
#define SSChatTimeFont          12           //时间字体
#define SSChatTextFont          17           //内容字体
//右侧头像的X坐标
#define SSChatIcon_RX            SCREEN_Width-SSChatIconRight-SSChatIconWH



//文本自适应限制宽度
#define SSChatTextInitWidth    SCREEN_Width*0.68-SSChatTextLRS-SSChatTextLRB

//订单的宽度
#define SSChatOrderInitWidth   SCREEN_Width*2/3


#define SSChatTextLineSpacing   0            //文本行高
#define SSChatTextRowSpacing    0            //文本间距


//图片宽度 高度
#define SSChatImageWidth        150
#define SSChatImageHeight       150

//音频的最小宽度  最大宽度   高度
#define SSChatVoiceMinWidth     100
#define SSChatVoiceMaxWidth        SCREEN_Width*2/3-SSChatTextLRS-SSChatTextLRB
#define SSChatVoiceHeight       45
//音频时间字体
#define SSChatVoiceTimeFont     14
//音频波浪图案尺寸
#define SSChatVoiceImgSize      20


//地图位置宽度 高度
#define SSChatMapWidth        150
#define SSChatMapHeight       150


//短视频位置宽度 高度
#define SSChatVideoWidth        150
#define SSChatVideoHeight       150


//预购订单cell
#define SSChatOrderValue1CellH   100         //文本行高
//直接购买订单cell
#define SSChatOrderValue2CellH   100         //文本行高






@interface SSChatModelLayout : NSObject


//跟网络请求一起执行
- (instancetype)initWithModel:(SSChatModel *)model;


//cell的类数组
@property (nonatomic, strong) NSArray      *cells;
@property (nonatomic, strong) NSString     *cellString;

//消息模型
@property (nonatomic, strong) SSChatModel  *model;

//消息布局到CELL的总高度
@property (nonatomic, assign) CGFloat      height;

//时间
@property (nonatomic, assign) CGRect       timeLabelRect;

//头像
@property (nonatomic, assign) CGRect       headerImgRect;

//背景按钮
@property (nonatomic, assign) CGRect       btnRect;
@property (nonatomic, strong) UIImage      *btnImage;

//文本的处理
@property (nonatomic, assign) UIEdgeInsets btnInsets;

//语音时间字符串 显示尺寸坐标
@property (nonatomic, strong) NSString *timeString;
@property (nonatomic, assign) CGRect timeLabRect;
//语音波浪第一张 图片数组  图片尺寸位置
@property (nonatomic, strong) UIImage *voiceImg;
@property (nonatomic, strong) NSArray *voiceImgs;
@property (nonatomic, assign) CGRect voiceRect;


//订单处理
@property (nonatomic, assign) CGRect goodsImgRect;
@property (nonatomic, strong) UIColor *titleColor;



@end
