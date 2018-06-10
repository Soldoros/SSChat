//
//  DEMake.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



void cout(id _object);

//登录状态
void makeUserLoginYes();
void makeUserLoginNo();


//token_type
void makeUserTokenType(NSString *tokenType);
//access_token
void makeUserAccessToken(NSString *accessToken);
// 请求头 headerUrl=token_type+access_token
void makeUserHeaderUrl(NSString *headerUrl);


//操作用户
void makeUserLogin(BOOL userLogin);
void makeUserToken(NSString *userToken);
void makeUserDevice(NSString *userDevice);
void makeUserName(NSString *userName);
void makeUserMobile(NSString *userMobile);
void makeUserPassWord(NSString *userPassWord);
void makeUserSex(NSString *userSex);
void makeUserImg(NSString *userImg);
void makeUser(NSString *userName,NSString *userMobile,NSString *userPassWord);
//客服
void makeUserKefu(NSString *userKefu);


//企业名称
void makeUserCPName(NSString *cpName);
//联系人
void makeUserCPPerson(NSString *cpPerson);
//联系电话
void makeUserCPPhone(NSString *cpPhone);
//所属行业
void makeUserCPIndustry(NSString *cpIndustry);
//企业地址
void makeUserCPAddress(NSString *cpAddress);
//详细地址
void makeUserCPDetAddress(NSString *DetAddress);



//环信账号
void makeUserHxPhone(NSString *hxPhone);

//用户类型 1个人用户 2普通企业用户 3授信企业用户
void makeUserMemberType(NSString *memberType);

//授信状态 0未设置 1已设置
void makeUserIsSet(NSString *isSet);
//企业申请通过 未通过
void makeUserCpApproved(NSString *approved);



// 返回字号
UIFont *makeFont(double _size);
UIFont *makeBlodFont(double _size);
UIFont *makeFontWithSystem(NSString *fontName,double _size);

// 操作字符串
BOOL isEmptyStr(NSString *string);
BOOL isNUllStr(NSString *string);
NSString *makeStrWithInt(NSInteger index);
NSString *makeString(id _value1,id _value2);
NSString *makeMoreStr(id _value,...);
NSString *makeStringWithArr(NSArray *array);

NSMutableString *makeStringWithDic(NSDictionary *dictionary);

// json 与 dic  arr  str 之间的转换
NSString *makeJsonWithDic(NSDictionary *dictionary);
NSString *makeJsonWithArr(NSArray *array);
NSDictionary *makeDicWithJsonStr(id jsonString);
NSArray *makeArrWithJsonStr(NSString *jsonString);

// 对颜色值获取颜色
UIColor *makeColorRgb(double _r,double _g,double _b);
UIColor *makeColorHex(NSString * _hexStr);

// 时间戳转换成时间
NSString *makeTime(NSString *timeStr);







#pragma mark - 尺寸

CGPoint makePoint(double _x,double _y);
CGSize  makeSize (double _w,double _h);
CGRect  makeRect (double _x,double _y,double _w,double _h);

CGRect  autoRect(double _x,double _y,double _width,double _height);


CGFloat autoWidth(double _width);
CGFloat autoHeight(double _height);


#pragma mark - 图片
UIImage *makeImage(NSString *_image);
UIImage *makeBigImage(NSString *_image);

//刷新表单
void reloadTableViewRow(NSInteger row,NSInteger section,UITableView *tableView);

//设置lab字体行距
void setLabHeight(UILabel *label,NSString *string,double hi);
//设置lab字体颜色
void setLabColor(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIColor *color);
//设置lab字体大小
void setLabFont(UILabel *label,NSString *string,NSInteger sta,NSInteger len,double font);
//设置lab字体大小 可以设置粗体
void setLabFont2(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIFont *font);
//设置字体颜色 大小
void setLabFontColor(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIFont *font,UIColor *color);


