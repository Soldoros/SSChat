//
//  SSChatMessage.h
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import <Foundation/Foundation.h>

//文本cellId
#define SSChatTextCellId   @"SSChatTextCellId"

#define SSChatHeaderSize        50           //头像
#define SSChatTimeFont          12           //时间字号
#define SSChatTextFont          17           //内容字号

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

#define SSChatAirTop            35           //气泡距离详情顶部
#define SSChatAirLRS            10           //气泡左右短距离
#define SSChatAirBottom         10           //气泡距离详情底部
#define SSChatAirLRB            22           //气泡左右长距离
#define SSChatTimeFont          12           //时间字体
#define SSChatTextFont          17           //内容字号

#define SSChatTextLineSpacing   5            //文本行高
#define SSChatTextRowSpacing    0            //文本间距


//文本自适应限制宽度
#define SSChatTextInitWidth     (SCREEN_Width-128-32)


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



NS_ASSUME_NONNULL_BEGIN

@interface SSChatMessage : NSObject

-(instancetype)initWithDic:(NSDictionary *)dic;

//消息类型
@property (nonatomic, assign) SSChatMessageType messageType;
//消息发送方
@property (nonatomic, assign) SSChatMessageFrom messageFrom;
//消息类型对应cell
@property (nonatomic, strong) NSString      *cellId;
//气泡背景图片
@property (nonatomic, strong) NSString      *backGroundImg;
//消息发送方名字
@property (nonatomic, strong) NSString      *nameString;

//消息背景气泡frame
@property (nonatomic, assign) CGRect        backGroundRect;
//消息背景气泡拉伸保护区域
@property (nonatomic, assign) UIEdgeInsets  imgInsets;
//头像frame
@property (nonatomic, assign) CGRect        headerRect;
//消息cell总高度
@property (nonatomic, assign) CGFloat       cellHeight;





//文本消息内容 颜色  消息转换可变字符串  文字frame计算
@property (nonatomic, strong) NSString    *textString;
@property (nonatomic, strong) UIColor     *textColor;
@property (nonatomic, strong) NSMutableAttributedString  *attTextString;
@property (nonatomic, assign) CGRect      textRect;


@end

NS_ASSUME_NONNULL_END
