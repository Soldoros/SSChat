//
//  DEMake.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.
//

#import "SSMake.h"

void cout(id _object){
    NSLog(@"%@",_object);
}


//token_type
void makeUserTokenType(NSString *tokenType){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:tokenType forKey:USER_TokenType];
}
//access_token
void makeUserAccessToken(NSString *accessToken){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:accessToken forKey:USER_AccessToken];
}
// 请求头 headerUrl=token_type+access_token
void makeUserHeaderUrl(NSString *headerUrl){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:headerUrl forKey:USER_HeaderUrl];
}

//设置用户id
void makeUserId(NSString *userId){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:userId forKey:USER_Id];
}

//操作用户
void makeUserLogin(BOOL userLogin){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:userLogin forKey:USER_Login];
}

void makeUserName(NSString *userName){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userName forKey:USER_Name];
}
void makeUserMobile(NSString *userMobile){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userMobile forKey:USER_Mobile];
}
void makeUserPassWord(NSString *userPassWord){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userPassWord forKey:USER_Password];
}
void makeUserSex(NSString *userSex){
    cout(userSex);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userSex forKey:USER_Sex];
    SSUserDefault *udf = [SSUserDefault shareCKUserDefault];
    udf.sex = userSex.integerValue;
}

void makeUserImg(NSString *userImg){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userImg forKey:USER_Img];
}

void makeUser(NSString *userName,NSString *userMobile,NSString *userPassWord){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:userName forKey:USER_Name];
    [user setValue:userMobile forKey:USER_Mobile];
    [user setValue:userPassWord forKey:USER_Password];
}


//地区
void makeUserAddress(NSString *address){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:address forKey:USER_Address];
}

//环信账号
void makeUserHxPhone(NSString *hxPhone){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setValue:hxPhone forKey:USER_Img];
}

//登录
void makeUserLoginYes(){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:YES forKey:USER_Login];
}

//退出登录
void makeUserLoginNo(){
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setBool:NO forKey:USER_Login];
    
    makeUserMobile(@"");
    makeUserName(@"");
    makeUserPassWord(@"");
    makeUserImg(@"");
    makeUserHxPhone(@"");
    makeUserTokenType(@"");
    makeUserAccessToken(@"");
    makeUserHeaderUrl(@"");
    makeUserAddress(@"");
    makeUserSex(@"");
}


//判断字符串是否为空
BOOL isEmptyStr(NSString *string)
{
    if([string isEqualToString:@""])return YES;
    else return NO;
}

BOOL isNUllStr(NSString *string){
    if([string isEqual:[NSNull null]] || string==nil){
        return YES;
    }
    else return NO;
}




#pragma mark - 设置字体
UIFont *makeFont(double _size)
{
    return  [UIFont systemFontOfSize:_size];
}

UIFont *makeBlodFont(double _size)
{
    return [UIFont boldSystemFontOfSize:_size];
    
    
}

UIFont *makeFontWithSystem(NSString *fontName,double _size){
    return  [UIFont fontWithName:fontName size:_size];
}



#pragma  mark - 字符串

NSString *makeStrWithInt(NSInteger index)
{
    return [NSString stringWithFormat:@"%ld",index];
}

NSString *makeString(id _value1,id _value2)
{
    return [NSString stringWithFormat:@"%@%@",_value1,_value2];
}

NSString *makeMoreStr(id _value,...)
{
    NSString *string = @"";
    va_list arg_ptr;
    va_start(arg_ptr, _value);
    
    id current = _value;
    
    while (current)
    {
        string = makeString(string, current);
        current = va_arg(arg_ptr, id);
    }
    
    return string;
}

NSString *makeStringWithArr(NSArray *array)
{
    NSMutableString *string = [NSMutableString string];
    NSString *str1 = @",";
    for(int i=0;i<array.count;++i)
    {
        if(i<array.count-1) [string appendFormat:@"%@%@",array[i],str1];
        else [string appendFormat:@"%@",array[i]];
    }
    return string;
}

NSMutableString *makeStringWithDic(NSDictionary *dictionary)
{
    NSMutableString *bodyString = [NSMutableString string];
    [bodyString appendString:@"?"];
    for (NSString *key in dictionary)
    {
        [bodyString appendFormat:@"%@=%@&", key, dictionary[key]];
    }
    
    return bodyString;
}


#pragma  mark - json 与 dic  arr  str 之间的转换
NSString *makeJsonWithDic(NSDictionary *dictionary){
    NSError *parseError = nil;
    
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

NSString *makeJsonWithArr(NSArray *array){
    NSError *parseError = nil;
    
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

NSDictionary *makeDicWithJsonStr(id jsonString){
    NSDictionary *dic = nil;
    NSData *jsonData = nil;
    if ([jsonString isKindOfClass:[NSDictionary class]]) {
        dic = jsonString;
    } else if ([jsonString isKindOfClass:[NSString class]]) {
        jsonData = [(NSString *)jsonString dataUsingEncoding : NSUTF8StringEncoding];
    } else if ([jsonString isKindOfClass:[NSData class]]) {
        jsonData = jsonString;
    }
    if (jsonData) {
        dic = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:NULL];
        if (![dic isKindOfClass:[NSDictionary class]]) dic = nil;
    }
    return dic;
}

NSArray *makeArrWithJsonStr(NSString *jsonString){
    
    if (jsonString == nil)
    {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                                                   options:NSJSONReadingMutableContainers
                                                     error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}



#pragma   mark -   对颜色值获取颜色
UIColor *makeColorRgb(double _r,double _g,double _b){
    
    return [UIColor colorWithRed:_r / 255.0f green: _g / 255.0f blue:_b / 255.0f alpha:1];
}

#pragma   mark -   对颜色值获取颜色
UIColor *makeColorRgbAlpha(double _r,double _g,double _b,double alpha){
    
    return [UIColor colorWithRed:_r / 255.0f green: _g / 255.0f blue:_b / 255.0f alpha:alpha];
}


UIColor *makeColorHex(NSString * _hexStr){
    
    NSString *cString = [[_hexStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}

#pragma   mark -    时间戳转换成时间
NSString *makeTime(NSString *timeStr){
    
    NSString *str = timeStr;
    NSTimeInterval time=[str doubleValue]+28800;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSLog(@"date:%@",[detaildate description]);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate: detaildate];
    
}








#pragma mark - 尺寸
CGPoint makePoint(double _x,double _y){
    return CGPointMake(_x, _y);
}

CGSize makeSize (double _w,double _h){
    return CGSizeMake(_w, _h);
}

CGRect  makeRect (double _x,double _y,double _w,double _h){
    return CGRectMake(_x, _y, _w, _h);
}

//布局
#pragma  默认在  iPhone5/5S 上面布局  不针对4S优化
CGRect autoRect(double _x,double _y,double _width,double _height){
    double w = 320, h = 568;
    return CGRectMake( SCREEN_Width*_x/w,SCREEN_Height*_y/h,
                      SCREEN_Width*_width/w,SCREEN_Height*_height/h);
}

CGFloat autoWidth(double _width){
    return _width * SCREEN_Width/320;
}

CGFloat autoHeight(double _height){
    return _height * SCREEN_Height/568;
}




#pragma mark - 图片
UIImage *makeImage(NSString *_image){
    return [UIImage imageNamed:_image];
}

UIImage *makeBigImage(NSString *_image)
{
    return  [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForAuxiliaryExecutable:_image]];
}


#pragma mark - 显示信息
void makeAlertMsg(NSString *msg){
    
}

void makeAlertTitleMsg(NSString *title,NSString *msg){
    
}



//刷新第几行
void reloadTableViewRow(NSInteger row,NSInteger section,UITableView *tableView)
{
    
    NSIndexPath *indexPath_1=[NSIndexPath indexPathForRow:row
                                                inSection:section];
    NSArray *indexArray=[NSArray  arrayWithObject:indexPath_1];
    [tableView  reloadRowsAtIndexPaths:indexArray withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


//设置lab行距
void setLabHeight(UILabel *label,NSString *string,double hi)
{
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:string];
    
    NSMutableParagraphStyle *paragraphString = [[NSMutableParagraphStyle alloc] init];
    [paragraphString setLineSpacing:hi];
    [mutableString addAttribute:NSParagraphStyleAttributeName value:paragraphString range:NSMakeRange(0, mutableString.length)];
    label.attributedText = mutableString;
    [label sizeToFit];
}

//设置lab字体颜色
void setLabColor(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIColor *color)
{
    NSDictionary *dic1 = @{NSForegroundColorAttributeName:color};
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:string];
    [mutableString addAttributes:dic1 range:NSMakeRange(sta,len)];
    label.attributedText = mutableString;
    
}

//设置lab字体大小
void setLabFont(UILabel *label,NSString *string,NSInteger sta,NSInteger len,double font)
{
    NSDictionary *dic3 = @{NSFontAttributeName:makeFont(font)};
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [mutableString addAttributes:dic3 range:NSMakeRange(sta,len)];
    label.attributedText = mutableString;
    
}

//设置lab字体大小
void setLabFont2(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIFont *font)
{
    NSDictionary *dic3 = @{NSFontAttributeName:font};
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [mutableString addAttributes:dic3 range:NSMakeRange(sta,len)];
    label.attributedText = mutableString;
    
}

//设置字体颜色 大小
void setLabFontColor(UILabel *label,NSString *string,NSInteger sta,NSInteger len,UIFont *font,UIColor *color){
    NSDictionary *dic = @{NSFontAttributeName:font,NSForegroundColorAttributeName:color};
    
    NSMutableAttributedString *mutableString = [[NSMutableAttributedString alloc]initWithString:string];
    
    [mutableString addAttributes:dic range:NSMakeRange(sta,len)];
    label.attributedText = mutableString;
}





