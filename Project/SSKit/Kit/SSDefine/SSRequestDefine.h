//
//  SSRequestDefine.h
//  htcm
//
//  Created by soldoros on 2018/7/2.
//  Copyright © 2018年 soldoros. All rights reserved.
//


#ifndef SSRequestDefine_h
#define SSRequestDefine_h


//app跳转配置
#define webLink     @"petun.com"
#define bundleID    @"com.petun1.storeDev"
#define teamID      @"petun.com"


//网络请求加密参数
#define URL_Key      @"mYSyUR9DzHg5DiAj"
#define URL_Iv       @"6RZPsf2XENKpR5TY"

//网络请求头
#define URLHeaderUrl           [[NSUserDefaults standardUserDefaults] valueForKey:USER_HeaderUrl]


//开发服+测试服+正式服
#define URLTestStr1            @"https://se8228.bleege.com/"
#define URLTestStr2            @"https://se8228.bleege.com/"
#define URLFormalStr           @"https://test.fusneaker.com/"
#define URLContentString       URLFormalStr


//上传文件地址
#define URLFileStr             @"http://124.161.16.163:8780"
//获取最新版本
#define URLCheckVersion           @"/mecp/sys/api/mecp/checkVersion.json"


//客服电话
#define  KefuDianhua              @"028-8080-0013"
//登录发送短信验证码
#define URLSMSLogin               @"fuapp/api/v1.0/login/authCode"
//验证码登录
#define URLUserLogin              @"fuapp/api/v1.0/login/phoneLogin"
//获取用户信息
#define URLApiUserInfo            @"fuapp/api/v1.0/user/center"

//绑定手机号
#define URLGetWxBindPhone              @"fuapp/api/v1.0/login/getWxBindPhone"

//微信登录
#define URLappLogin               @"fuapp/api/v1.0/login/appLogin"

//用户协议
#define URRule                     @"fuapp/api/v1.0/rule"

//地址列表
#define URLAddressUrl          @"fuapp/api/v1.0/user/address"
//添加地址
#define URLAddressAddUrl          @"fuapp/api/v1.0/user/address?action=add"
//编辑地址
#define URLAddressUpdateUrl          @"fuapp/api/v1.0/user/address?action=update"


//收藏列表
#define URLCollectList         @"fuapp/api/v1.0/user/collectList"
//订单列表
#define URLOrderList           @"fuapp/api/v1.0/order/orderList"
//订单详情
#define URLOrderDet            @"fuapp/api/v1.0/order/orderDetail"
//取消交易
#define URLOrderCancel         @"fuapp/api/v1.0/order/cancel"
//取消订单
#define URLOrderDel            @"fuapp/api/v1.0/order/del"
//确认收货
#define URLOrderConfirm        @"fuapp/api/v1.0/order/confirm"
//交易行列表
#define URLAuctionList         @"fuapp/api/v1.0/auction/list"
//我的仓库
#define URLMyWarehouse         @"fuapp/api/v1.0/user/myWarehouse"
//查看物流
#define URLLogistics           @"fuapp/api/v1.0/order/logistics"


//我的碎片
#define URLSellList            @"fuapp/api/v1.0/auction/sellList"
//出售碎片+商品+道具
#define URLOnSell              @"fuapp/api/v1.0/auction/onSell"
//搜索推荐商品
#define URLGoodsSearch         @"fuapp/api/v1.0/mall/search"
//购买兑换碎片
#define URLCoinToFragment      @"fuapp/api/v1.0/auction/coinToFragment"



//商城列表顶部分类
#define URLMallCategory        @"fuapp/api/v1.0/mall/category"
//商城分类页面
#define URLGoodsCategory       @"fuapp/api/v1.0/goods/category"
//商品详情
#define URLGoodsDet            @"fuapp/api/v1.0/goods/"


//下单
#define URLPayPrepay           @"fuapp/api/v1.0/pay/order"
//支付方式
#define URLPayWayList          @"fuapp/api/v1.0/pay/payWayList"
//支付
#define URLPayMoney            @"fuapp/api/v1.0/pay/pay"


//首页福袋
#define URLBagInfo             @"fuapp/api/v1.0/bagInfo"
//更多福袋
#define URLMoreBags            @"fuapp/api/v1.0/moreBags"
//开启或试玩
#define URLopenBag             @"fuapp/api/v1.0/jackpot/openBag"
//查看规则
#define URRule                 @"fuapp/api/v1.0/rule"
//收藏+取消收藏
#define URCollect              @"fuapp/api/v1.0/user/collect"


//仓库商品提取页面
#define URGoodsSimple          @"fuapp/api/v1.0/goods/simple/"
//生成赠送记录
#define URCreatePresent        @"fuapp/api/v1.0/user/createPresent2"



//游戏列表
#define URGameList             @"fuapp/api/v1.0/game/center/list"
//摇杆机碎片列表
#define URUsefragment             @"fuapp/api/v1.0/game/usefragment/lobby"
//摇杆机页面
#define URUsefragmentDet             @"fuapp/api/v1.0/game/usefragment/index"
//摇杆机开始摇
#define URUsefragmentPlay            @"fuapp/api/v1.0/game/usefragment/do/v2"



//拉新
#define URInviteCode             @"fuapp/api/v1.0/activity/inviteCode"
//兑换
#define URCdKey             @"fuapp/api/v1.0/user/cdKey"


//新邮件数量
#define URMailUnread           @"fuapp/api/v1.0/mail/unread"
//邮件列表
#define URMailList             @"fuapp/api/v1.0/mail/list"
//邮件详情 id
#define URMailInfo             @"fuapp/api/v1.0/mail/info"
//客服列表
#define URKfList               @"fuapp/api/v1.0/kfList"


//综合配置
#define URLShareInfo               @"fuapp/api/v1.0/shareInfo"


#endif

