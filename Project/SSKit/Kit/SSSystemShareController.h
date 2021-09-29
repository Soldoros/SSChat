//
//  SSSystemShareController.h
//  htcm
//
//  Created by soldoros on 2018/9/29.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSSystemShareController : NSObject

+(void)shareWithSystemController:(NSString *)code;

+(void)shareController:(UIViewController *)controller code:(NSString *)code;

@end
