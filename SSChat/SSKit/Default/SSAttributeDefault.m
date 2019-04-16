//
//  SSAttributeDefault.m
//  caigou
//
//  Created by soldoros on 2018/4/9.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSAttributeDefault.h"

static SSAttributeDefault* attribute = nil;

@implementation SSAttributeDefault

+(SSAttributeDefault *)shareCKAttributeDefault
{
    static dispatch_once_t once;
    dispatch_once(&once,^{
        
        attribute = [[SSAttributeDefault alloc]init];
        [attribute initData];
        
    });
    return attribute;
}


-(void)initData{
    
    
    //主题色
    attribute.titleColor = makeColorHex(@"20D3B3");
    //导航栏
    attribute.navBarColor = makeColorHex(@"20D3B3");
    //标签栏
    attribute.tabBarColor = makeColorHex(@"20D3B3");
    attribute.navTintColor = makeColorHex(@"");
    attribute.tabBarTintDefaultColor = makeColorHex(@"989C9E");
    attribute.tabBarTintSelectColor = makeColorHex(@"20D3B3");
    attribute.backGroundColor = makeColorHex(@"");
    attribute.lineColor = makeColorHex(@"");
    
}





@end
