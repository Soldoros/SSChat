//
//  DEMake.h
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>



void cout(id _object);

// 返回字号
UIFont *makeFont(double _size);
UIFont *makeBlodFont(double _size);
UIFont *makeFontWithSystem(NSString *fontName,double _size);
UIFont *makeFont1(double _size);
UIFont *makeFont2(double _size);

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
UIColor *makeColorRgbAlpha(double _r,double _g,double _b,double alph);
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

//为同样的位置string设置颜色和中划线
NSMutableAttributedString *setLabColorCenterLine(NSString *string, NSInteger sta, NSInteger len, UIColor *color, CGFloat font);

//给文本添加阴影
NSMutableAttributedString *getShadowText(NSString *string, UIColor *color);

