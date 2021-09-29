//
//  PBGameWebController.h
//  FuWan
//
//  Created by soldoros on 2021/8/26.
//

#import "BaseViewController.h"
#import <WebKit/WebKit.h>

@interface PBGameWebController : BaseViewController

//自定义标题(默认)1  获取网页标题2
@property(nonatomic,assign)NSInteger style;

@property(nonatomic,strong)WKWebView *webView;
@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,strong)NSString *loadPath;

@property(nonatomic,strong)NSString *webTitle;

@property(nonatomic,strong)NSString *htmlString;

@end

