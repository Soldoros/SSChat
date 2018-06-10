//
//  SSChatModel.h
//  haixian
//
//  Created by soldoros on 2017/11/10.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "BaseModel.h"


/**
 聊天类型
 
 - SSChatMessageTypeChat:      单聊
 - SSChatMessageTypeGroupChat: 群聊
 - SSChatMessageTypeChatRoom:  聊天室
 */
typedef NS_ENUM(NSInteger, SSChatConversationType) {
    SSChatConversationTypeChat    = EMConversationTypeChat,
    SSChatConversationTypeGroupChat = EMConversationTypeGroupChat,
    SSChatConversationTypeChatRoom = EMConversationTypeChatRoom
};



/**
 判断消息的发送者
 
 - SSChatMessageFromMe: 我发的
 - SSChatMessageFromMe: 朋友发的
 - SSChatMessageFromSystem: 系统消息
 */
typedef NS_ENUM(NSInteger, SSChatMessageFrom) {
    SSChatMessageFromMe    = 1,
    SSChatMessageFromOther = 2,
    SSChatMessageFromSystem
};

/**
 判断发送消息所属的类型
 - SSChatMessageTypeTime: 显示系统时间
 - SSChatMessageTypeMessage: 显示系统消息
 - SSChatMessageTypeText: 发送文本消息
 - SSChatMessageTypeImage: 发送图片消息
 - SSChatMessageTypeVoice: 发送语音消息
 - SSChatMessageTypeMap: 发送地图定位
 - SSChatMessageTypeVideo: 发送小视频
 - SSChatMessageTypeOrderValue1: 支付定金订单
 - SSChatMessageTypeOrderValue2: 直接购买下单
 - SSChatMessageTypeRecallMsg: 撤销的消息
 - SSChatMessageTypeRemoveMsg: 删除的消息
 */
typedef NS_ENUM(NSInteger, SSChatMessageType) {
    SSChatMessageTypeTime = 1,
    SSChatMessageTypeMessage ,
    SSChatMessageTypeText ,
    SSChatMessageTypeImage,
    SSChatMessageTypeVoice,
    SSChatMessageTypeMap,
    SSChatMessageTypeVideo,
    SSChatMessageTypeOrderValue1,
    SSChatMessageTypeOrderValue2,
    
    SSChatMessageTypeRecallMsg,
    SSChatMessageTypeRemoveMsg,
};




@interface SSChatModel : BaseModel

//消息发送方  消息类型
@property (nonatomic, assign) SSChatMessageFrom messageFrom;
@property (nonatomic, assign) SSChatMessageType messageType;

//消息
@property (nonatomic, strong) EMMessage *message;
@property (nonatomic, strong) NSString  *messageId;

//消息ID   消息时间  是否显示时间 （这里需要什么就设置什么 不宜过多）
@property (nonatomic, strong) NSString    *conversationId;
@property (nonatomic, assign) long long   messageTime;
@property (nonatomic, assign) BOOL        showTime;

//发送方是否失败
@property (nonatomic, assign) BOOL sendError;

//头像
@property (nonatomic, strong) UIImage     *headerImg;
@property (nonatomic, strong) NSString    *headerImgurl;

//消息的背景图
@property (nonatomic, strong) NSString    *imgString;

//文本消息内容 颜色
@property (nonatomic, strong) NSString         *textString;
@property (nonatomic, strong) NSMutableAttributedString  *attTextString;
@property (nonatomic, strong) UIColor          *textColor;

//图片消息链接
@property (nonatomic, strong) NSString    *imageUrl;

//音频时长(单位：秒)  音频网络路径  本地路径
@property (nonatomic, assign) NSInteger duration;
@property (nonatomic, strong) NSString *remotePath;
@property (nonatomic, strong) NSString *localPath;

//地理位置纬度  经度   详细地址
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@property (nonatomic, strong) NSString *addressString;


//短视频缩略图网络路径 本地路径  视频remote路径 local路径   市场
@property (nonatomic, strong) NSString *thumbnailRemotePath;
@property (nonatomic, strong) NSString *thumbnailLocalPath;
@property (nonatomic, strong) NSString *videoRemotePath;
@property (nonatomic, strong) NSString *videoLocalPath;
@property (nonatomic, assign) NSInteger  videodDration;


//拓展消息
@property(nonatomic,strong)NSDictionary *dict;





@end
