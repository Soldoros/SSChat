//
//  PBDatas.m
//  QuFound
//
//  Created by soldoros on 2020/3/12.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "PBDatas.h"

@implementation PBDatas

/// 保存搜索记录
/// @param string 传入搜索记录给本地单例
+(void)saveSearchHistory:(NSString *)string{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *array = [NSMutableArray new];
    NSArray *arr = [user arrayForKey:USER_Serchhistory];
    if(arr==nil){
        [array addObject:string];
        [user setObject:array forKey:USER_Serchhistory];
        return;
    }
    [array addObjectsFromArray:arr];
    
    BOOL bu = NO;
    for(NSString *str in arr){
        if([str isEqualToString:string]){
            bu = YES;
            break;
        }
    }
    if(bu==NO){
        [array addObject:string];
    }
    if(array.count<8){
        [user setObject:array forKey:USER_Serchhistory];
        return;
    }
    for(int i=0;i<array.count-8;++i){
        [array removeObjectAtIndex:i];
    }
    [user setObject:array forKey:USER_Serchhistory];
}

/// 删除某个搜索记录
/// @param string 传入要删除的搜索记录对象
+(void)deleteSearchHistory:(NSString *)string{
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [NSMutableArray new];
    [array addObjectsFromArray:[user objectForKey:USER_Serchhistory]];
    [array removeObject:string];
    [user setObject:array forKey:USER_Serchhistory];
}


/// 获取搜索记录 返回数组
+(NSArray *)getSearchHistory{
    
    NSArray *_datas;
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if([user arrayForKey:USER_Serchhistory]){
        _datas = [user arrayForKey:USER_Serchhistory];
        NSArray *reversedArray = [[_datas reverseObjectEnumerator] allObjects];
        _datas = reversedArray;
    }
    return _datas;
}


//获取图片的数组json
+(NSMutableArray *)getImgJsonWithImgs:(NSArray *)imgs  key:(NSString *)key{
    
    NSMutableArray *arr = [NSMutableArray new];
    for(int i=0;i<imgs.count;++i){
        NSDictionary *dic = imgs[i];
        [arr addObject:[dic[key] imageString]];
    }
    
    return arr;
    
//    NSString *string = makeJsonWithArr(arr);
//
//    //去除掉首尾的空白字符和换行字符
//    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//    string = [string stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
//    string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//
//    return string;
}


//播放视频
+(void)playVideo:(NSString *)urlString controller:(UIViewController *)controller{
    
    if([urlString isEqual:@"[]"] || [urlString hasSuffix:@"]"] ||
       urlString.length == 0){
        [controller.view showTime:makeString(@"错误的媒体地址 ", urlString)];
        return;
    }
//    if([urlString hasSuffix:@"]"]){
//        urlString  = [urlString substringFromIndex:1];
//        urlString = [urlString substringToIndex:urlString.length-1];
//    }
    
    AVPlayerViewController *playerViewController =  [[AVPlayerViewController alloc] init];
    
    // 试图的填充模式
    playerViewController.videoGravity =  AVLayerVideoGravityResizeAspect;
    // 是否显示播放控制条
    playerViewController.showsPlaybackControls = YES;
    // 设置显示的Frame
    playerViewController.view.frame = controller.view.bounds;
    [controller.navigationController presentViewController:playerViewController animated:YES completion:^{
        
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        indicator.size = CGSizeMake(60, 60);
        indicator.center = CGPointMake(controller.view.width / 2, controller.view.height / 2);
        indicator.backgroundColor = [UIColor grayColor];
        indicator.clipsToBounds = YES;
        indicator.layer.cornerRadius = 6;
        [indicator startAnimating];
        [playerViewController.view addSubview:indicator];
        
        
        [SSAFRequest downloadWithUrlString:urlString progressBlock:^(NSProgress *progress) {
            cout(progress);
        } downloadBlock:^(NSString *filePath) {
            [indicator removeFromSuperview];
            
            [self playPath:filePath vc:controller playerViewController:playerViewController];
        }];
        
    }];
    
}

+(void)playPath:(NSString *)path vc:(UIViewController *)vc playerViewController:(AVPlayerViewController *)playerViewController{
    
    NSURL *url = [NSURL fileURLWithPath:path];
    AVPlayer *avPlayer= [AVPlayer playerWithURL:url];
    // 控制器的player播放器
    playerViewController.player = avPlayer;
    // player的控制器对象
    [playerViewController.player play];
}


@end
