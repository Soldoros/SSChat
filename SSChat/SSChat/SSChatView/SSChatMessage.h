//
//  SSChatMessage.h
//  SSChatView
//
//  Created by soldoros on 2018/10/12.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSChatIMEmotionModel.h"
#import "NSTimer+SSAdd.h"
#import "UIImage+SSAdd.h"
#import "UIView+SSAdd.h"
#import "NSObject+SSAdd.h"




//cell的一些设置
#define SSChatTextCellId        @"SSChatTextCellId"
#define SSChatImageCellId       @"SSChatImageCellId"
#define SSChatVoiceCellId       @"SSChatVoiceCellId"
#define SSChatMapCellId         @"SSChatMapCellId"
#define SSChatVideoCellId       @"SSChatVideoCellId"




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
#define SSChatTextLRB           20           //文本左右长距离

//显示时间
#define SSChatTimeWidth         250          //时间宽度
#define SSChatTimeHeight        20           //时间高度
#define SSChatTimeTop           15           //时间距离顶部
#define SSChatTimeBottom        20           //时间距离底部


#define SSChatAirTop            35           //气泡距离详情顶部
#define SSChatAirLRS            10           //气泡左右短距离
#define SSChatAirBottom         10           //气泡距离详情底部
#define SSChatAirLRB            22           //气泡左右长距离
#define SSChatTimeFont          12           //时间字体
#define SSChatTextFont          17           //内容字号

#define SSChatTextLineSpacing   5            //文本行高
#define SSChatTextRowSpacing    0            //文本间距

//文本颜色
#define SSChatTextColor         [UIColor blackColor]

//右侧头像的X坐标
#define SSChatIcon_RX            SCREEN_Width-SSChatIconRight-SSChatIconWH

//文本自适应限制宽度
#define SSChatTextInitWidth    SCREEN_Width*0.7-SSChatTextLRS-SSChatTextLRB

//图片最大尺寸(正方形)
#define SSChatImageMaxSize    150

//音频的最小宽度  最大宽度   高度
#define SSChatVoiceMinWidth     100
#define SSChatVoiceMaxWidth        SCREEN_Width*2/3-SSChatTextLRS-SSChatTextLRB
#define SSChatVoiceHeight       45
//音频时间字体
#define SSChatVoiceTimeFont     14
//音频波浪图案尺寸
#define SSChatVoiceImgSize      20


//地图位置宽度 高度
#define SSChatMapWidth        240
#define SSChatMapHeight       150


//短视频位置宽度 高度
#define SSChatVideoWidth        200
#define SSChatVideoHeight       150



/**
 聊天类型
 
 - SSChatConversationTypeChat:      单聊
 - SSChatConversationTypeGroupChat: 群聊
 */
typedef NS_ENUM(NSInteger, SSChatConversationType) {
    SSChatConversationTypeChat    = 1,
    SSChatConversationTypeGroupChat = 2,
};


/**
 判断消息的发送者
 
 - SSChatMessageFromMe:     我发的
 - SSChatMessageFromOther:  对方发的(单聊群里同等对待)
 - SSChatMessageFromSystem: 系统消息(提示撤销删除、商品信息等)
 */
typedef NS_ENUM(NSInteger, SSChatMessageFrom) {
    SSChatMessageFromMe    = 1,
    SSChatMessageFromOther = 2,
    SSChatMessageFromSystem
};


/**
 判断发送消息所属的类型
 - SSChatMessageTypeText:        发送文本消息
 - SSChatMessageTypeImage:       发送图片消息
 - SSChatMessageTypeGif:         发送Gif图片消息
 - SSChatMessageTypeVoice:       发送语音消息
 - SSChatMessageTypeMap:         发送地图定位
 - SSChatMessageTypeVideo:       发送小视频
 - SSChatMessageTypeRedEnvelope: 发红包
 
 - SSChatMessageTypeUndo:        撤销的消息
 - SSChatMessageTypeDelete:      删除的消息
 */
typedef NS_ENUM(NSInteger, SSChatMessageType) {
    SSChatMessageTypeText = 1,
    SSChatMessageTypeImage = 2,
    SSChatMessageTypeGif = 3,
    SSChatMessageTypeVoice = 4,
    SSChatMessageTypeMap = 5,
    SSChatMessageTypeVideo = 6,
    SSChatMessageTypeRedEnvelope = 7,
    
    SSChatMessageTypeUndo = 50,
    SSChatMessageTypeDelete = 51,
};




@interface SSChatMessage : NSObject


/**
 判断当前时间是否展示
 
 @param lastTime 最后展示的时间
 @param currentTime 当前时间
 */
-(void)showTimeWithLastShowTime:(NSString *)lastTime currentTime:(NSString *)currentTime;



//消息发送方  消息类型  消息对应cell类型
@property (nonatomic, assign) SSChatMessageFrom messageFrom;
@property (nonatomic, assign) SSChatMessageType messageType;
@property (nonatomic, strong) NSString     *cellString;

//会话id
@property (nonatomic, strong) NSString    *sessionId;

//消息id   消息时间  是否显示时间 （这里需要什么就设置什么 不宜过多）
@property (nonatomic, strong) NSString    *messageId;
@property (nonatomic, strong) NSString    *messageTime;
@property (nonatomic, assign) BOOL        showTime;

//消息是否发送失败
@property (nonatomic, assign) BOOL sendError;

//头像
@property (nonatomic, strong) NSString    *headerImgurl;

//单条消息背景图
@property (nonatomic, strong) NSString    *backImgString;


//文本消息内容 颜色  消息转换可变字符串
@property (nonatomic, strong) NSString    *textString;
@property (nonatomic, strong) UIColor     *textColor;
@property (nonatomic, strong) NSMutableAttributedString  *attTextString;

//图片消息链接或者本地图片 图片展示格式
@property (nonatomic, strong) NSString    *imageString;
@property (nonatomic, strong) UIImage     *image;
@property (nonatomic, assign) UIViewContentMode contentMode;

//gif图片本地地址  图片的第一张图
@property (nonatomic, strong) NSString    *imageLocalPath;
@property (nonatomic, strong) NSArray     *imageArr;

//音频时长(单位：秒) 展示时长  音频网络路径  本地路径  音频
@property (nonatomic, assign) NSInteger   voiceDuration;
@property (nonatomic, strong) NSString    *voiceTime;
@property (nonatomic, strong) NSString    *voiceRemotePath;
@property (nonatomic, strong) NSString    *voiceLocalPath;
@property (nonatomic, strong) NSData      *voice;
//语音波浪图标及数组
@property (nonatomic, strong) UIImage     *voiceImg;
@property (nonatomic, strong) NSArray     *voiceImgs;


//地理位置纬度  经度   详细地址
@property (nonatomic, assign) double      latitude;
@property (nonatomic, assign) double      longitude;
@property (nonatomic, strong) NSString    *addressString;

//短视频缩略图网络路径 本地路径  视频图片 local路径
@property (nonatomic, strong) NSString    *videoRemotePath;
@property (nonatomic, strong) NSString    *videoLocalPath;
@property (nonatomic, strong) UIImage     *videoImage;
@property (nonatomic, assign) NSInteger   videodDration;


//拓展消息
@property(nonatomic,strong)NSDictionary *dict;





@end
