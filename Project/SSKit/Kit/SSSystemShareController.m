//
//  SSSystemShareController.m
//  htcm
//
//  Created by soldoros on 2018/9/29.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSSystemShareController.h"

@implementation SSSystemShareController

+(void)shareWithSystemController:(NSString *)code{
    
    
    NSString *url = makeString(@"https://www.fusneaker.com/fuapp/downapp/index.html#/?code=", code);
    NSString *title = @"福APP | 开启潮流生活";
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    [items addObject:title];
    [items addObject:[NSURL URLWithString:url]];
    [items addObject:[UIImage imageNamed:@"LOGO"]];
    
    
    NSArray *excludedActivities = @[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:@[[UIActivity new]]];
    activityVC.excludedActivityTypes = excludedActivities;
    
    [[UIViewController getCurrentController] presentViewController:activityVC animated:YES completion:nil];
    
}


+(void)shareController:(UIViewController *)controller code:(NSString *)code{
    
    //http://quzhaofang.sccxbe.com/AppDownload
    //https://apps.apple.com/cn/app/%E4%B9%90%E8%B6%A3%E7%A7%9F%E7%94%9F%E6%B4%BB%E5%B9%B3%E5%8F%B0/id1530505915
//    NSString *url = makeString(@"http://quzhaofang.sccxbe.com/register?sharecode=", code);
//    NSString *title = @"趣找房";
    
}

@end
