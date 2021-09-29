//
//  NSObject+DEAdd.m
//  Project
//
//  Created by soldoros on 16/6/27.
//  Copyright © 2016年 soldoros. All rights reserved.


#import "NSObject+SSAdd.h"



@implementation NSObject (DEAdd)

//随机数
+(NSInteger)getRandom:(NSInteger)max{
    return  random() % max;
}

//输出对象
-(void)cout{
    NSLog(@"%@",self);
}


//判断字符串是否是整型
+ (BOOL)isPureInt:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    int val;
    
    return[scan scanInt:&val] && [scan isAtEnd];
    
}
//判断是否为浮点形：
+ (BOOL)isPureFloat:(NSString*)string{
    
    NSScanner* scan = [NSScanner scannerWithString:string];
    
    float val;
    
    return[scan scanFloat:&val] && [scan isAtEnd];
    
}

//判断字符串长度是否为0
-(BOOL)isEmptyStr{
    if([(NSString *)self isEqualToString:@""])return YES;
    else return NO;
}

//判断对象是否为null
-(BOOL)isNUllStr{
    if(self==nil || [self isEqual:[NSNull null]] || [self isEqual:@"<null>"]){
        return YES;
    }
    else return NO;
}

-(NSString *)emptyStr{
    if([self isNUllStr]){
        return @"";
    }else return (NSString *)self;
}


+(NSInteger)getMaxNum:(NSInteger)one other:(NSInteger)two{
    return one>=two?one:two;
}

+(NSInteger)getMinNum:(NSInteger)one other:(NSInteger)two{
    return one<=two?one:two;
}

//发送不带参数的通知
-(void)sendNotifCation:(NSString *)key{
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:nil];
}

//发送带参数的通知
-(void)sendNotifCation:(NSString *)key data:(id)data{
    [[NSNotificationCenter defaultCenter] postNotificationName:key object:data];
}

//移除通知
-(void)deleteNotifCation{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


//返回日期的时间差 (单位:天)
+(double)FromTheNumberOfDaysOne:(NSString *)string1
                        daysTwo:(NSString *)string2
{
    //截取年月日
    NSString *str1 = [string1 substringToIndex:11];
    NSString *str2 = [string2 substringToIndex:11];
    NSArray *stringArr = @[str1,str2];
    NSDate *date1,*date2;
    for(int i = 0; i < 2; ++ i)
    {
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd"];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [df setLocale:locale];
        
        if(i == 0)  date1 = [df dateFromString:stringArr[i]];
        else      date2 = [df dateFromString:stringArr[i]];
        
    }
    
    NSTimeInterval timeBetween = [date1 timeIntervalSinceDate:date2];
    
    return timeBetween/(3600*24);
    
}



//根据字符串 限制宽度 字号 行距  纵间距 得到自适应面积
+(CGRect)getRectWith:(NSString *)string width:(CGFloat)width font:(UIFont *)font spacing:(CGFloat)spacing Row:(CGFloat)row{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = spacing;
    
    CGSize constraintSize = CGSizeMake(width, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesFontLeading |
    NSStringDrawingUsesLineFragmentOrigin;
    
    NSDictionary *attributes = @{NSFontAttributeName: font ,NSParagraphStyleAttributeName:paragraphStyle,NSKernAttributeName:@(row)};
    
    CGRect rect = [string boundingRectWithSize:constraintSize options:options attributes:attributes context:NULL];
    
    
    return rect;
}


//根据可变字符串 限制宽度 字号 行距  纵间距 得到自适应面积
+(CGRect)getRectWith:(NSMutableAttributedString *)string width:(CGFloat)width{
    
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingTruncatesLastVisibleLine;
    
    CGRect rect = [string boundingRectWithSize:size options:options context:NULL];
    
    return rect;
}


//获取可变字体
+(NSAttributedString *)getAtString:(NSString *)string Spacing:(CGFloat)spacing Row:(CGFloat)row Font:(CGFloat)font{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = spacing;
    
    NSDictionary *dic = @{NSFontAttributeName : [UIFont systemFontOfSize:font],NSParagraphStyleAttributeName : paragraphStyle,NSKernAttributeName:@(row)};
    
    NSAttributedString *atString = [[NSAttributedString alloc]initWithString:string attributes:dic];
    return atString;
}

//根据经纬度计算距离
+(double) LantitudeLongitudeDist:(double)lon1 other_Lat:(double)lat1 self_Lon:(double)lon2 self_Lat:(double)lat2{
    double er = 6378137; // 6378700.0f;
    //ave. radius = 6371.315 (someone said more accurate is 6366.707)
    //equatorial radius = 6378.388
    //nautical mile = 1.15078
    
    double PI = 3.141592653;
    
    double radlat1 = PI*lat1/180.0f;
    double radlat2 = PI*lat2/180.0f;
    //now long.
    double radlong1 = PI*lon1/180.0f;
    double radlong2 = PI*lon2/180.0f;
    if( radlat1 < 0 ) radlat1 = PI/2 + fabs(radlat1);// south
    if( radlat1 > 0 ) radlat1 = PI/2 - fabs(radlat1);// north
    if( radlong1 < 0 ) radlong1 = PI*2 - fabs(radlong1);//west
    if( radlat2 < 0 ) radlat2 = PI/2 + fabs(radlat2);// south
    if( radlat2 > 0 ) radlat2 = PI/2 - fabs(radlat2);// north
    if( radlong2 < 0 ) radlong2 = PI*2 - fabs(radlong2);// west
    //spherical coordinates x=r*cos(ag)sin(at), y=r*sin(ag)*sin(at), z=r*cos(at)
    //zero ag is up so reverse lat
    double x1 = er * cos(radlong1) * sin(radlat1);
    double y1 = er * sin(radlong1) * sin(radlat1);
    double z1 = er * cos(radlat1);
    double x2 = er * cos(radlong2) * sin(radlat2);
    double y2 = er * sin(radlong2) * sin(radlat2);
    double z2 = er * cos(radlat2);
    double d = sqrt((x1-x2)*(x1-x2)+(y1-y2)*(y1-y2)+(z1-z2)*(z1-z2));
    //side, side, side, law of cosines and arccos
    double theta = acos((er*er+er*er-d*d)/(2*er*er));
    double dist  = theta*er;
    return dist;
}


@end
