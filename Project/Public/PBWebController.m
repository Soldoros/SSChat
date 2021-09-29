//
//  PBWebController.m
//  DEShop
//
//  Created by soldoros on 2017/4/26.
//  Copyright © 2017年 soldoros. All rights reserved.


#import "PBWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SSShareViewController.h"

//WKScriptMessageHandler
@interface PBWebController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>

@end

@implementation PBWebController

-(instancetype)init{
    if(self = [super init]){
        self.webTitle = @"";
        _urlString = @"";
        _style = 1;
        _htmlString = @"";
    }
    return self;
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleDefault;
}

- (void)dealloc{
    [_webView removeObserver:self forKeyPath:@"title"];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setNavgationBarColorImg:[UIColor whiteColor]];
    [self setLeftOneBtnImg:@"return" color:[UIColor blackColor]];
    self.titleLab.textColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:self.webTitle];
    self.navLine.hidden = YES;
    
    //以下代码适配大小
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    
    
    //js调用oc方法 getAppUserToken 与js里面的函数名保持一致
    WKUserContentController* userController = [[WKUserContentController alloc]init];
    [userController addUserScript:wkUScript];
    
    WKWebViewConfiguration *_webConfig = [[WKWebViewConfiguration alloc]init];
    _webConfig.userContentController = userController;

    
    _webView = [[WKWebView alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewSub_Height) configuration:_webConfig];
    _webView.UIDelegate = self;
    _webView.navigationDelegate = self;
    _webView.backgroundColor = BackGroundColor;
    _webView.scrollView.backgroundColor = BackGroundColor;
    [self.view addSubview:_webView];
    _webView.opaque = NO;
     
    [_webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
    
//    NSString *string = [wself.rulesDic[@"content"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if(_htmlString.length != 0){
        
        cout(_htmlString);
        _htmlString = [_htmlString stringByReplacingOccurrencesOfString:@"\\n" withString:@"<br>"];
        
        cout(_htmlString);
        [_webView loadHTMLString:_htmlString baseURL:nil];
    }
     if(_urlString.length != 0 && _urlString != nil){
               NSString *string = [_urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
               NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:string]];
               [_webView loadRequest:request];
    }
        
    if(_loadPath.length != 0 && _loadPath != nil){
         NSString *path = [[NSBundle mainBundle] pathForResource:_loadPath ofType:@"html"];
         [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:path]]];
     }
    
}

//https://ds.alipay.com/?from=mobilecodec&scheme=alipays://platformapi/startapp?saId=10000007&clientVersion=3.7.0.0718&qrcode=https%253A%252F%252Fqr.alipay.com%252Fbax041244dd0qf8n6ras805b%253F_s%253Dweb-othe

// 在收到响应开始加载后，决定是否跳转
//alipay://platformapi/startapp?appId=20000067&url=
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler
{
    NSString *requestUrl = navigationAction.request.URL.absoluteString;
    cout(requestUrl);
   
    
//    NSArray *arr = [requestUrl componentsSeparatedByString:@"url="];
//    [[AlipaySDK defaultService] payInterceptorWithUrl:requestUrl fromScheme:@"Fuwan" callback:^(NSDictionary *resultDic) {
//        cout(resultDic);
//        NSString* urlStr = resultDic[@"returnUrl"];
//        [self loadWithUrlStr:urlStr];
//    }];
    
     //  则跳转到本地支付宝App
//    if ([requestUrl hasPrefix:@"alipays://"] || [requestUrl hasPrefix:@"alipay://"]) {
        // 跳转支付宝App
//        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[requestUrl URLEncodedString]] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @(NO)} completionHandler:^(BOOL success) {
//        }];
//
//        decisionHandler(WKNavigationActionPolicyCancel);
//    }
    
    decisionHandler(WKNavigationActionPolicyAllow);
}





- (void)loadWithUrlStr:(NSString*)urlStr
{
    if (urlStr.length > 0) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]
                                                        cachePolicy:NSURLRequestReturnCacheDataElseLoad
                                                    timeoutInterval:30];
            [self.webView loadRequest:webRequest];
        });
    }
}


//跟js交互
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    NSLog(@"didFinishNavigation");
    
    
}


#pragma mark KVO的监听代理
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"title"]){
        if (object == _webView){
            if(_style==2){
                [self setNavgaionTitle:_webView.title];
            }
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}


//分享
-(void)rightBtnClick{
    
    //分享普通商品和限时抢购商品
    dispatch_async(dispatch_get_main_queue(), ^{
      
      SSShareViewController *vc = [SSShareViewController new];
      self.definesPresentationContext = YES;
        vc.urlString = self.urlString;
      vc.modalPresentationStyle = UIModalPresentationOverCurrentContext;
      [self presentViewController:vc animated:NO completion:^{
          [vc setViewAnimation];
      }];
       vc.shareViewBlock = ^(UIButton *sender) {
           
           [self showTime:@"分享成功"];
       };
    });
    
}



-(NSString*)WebURLEncode:(NSString* )str{

    NSString*charactersToEscape =@"#[]@!$'()*+,;\"<>%{}|^~`";

    NSCharacterSet*allowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape]invertedSet];

    NSString *encodedUrl = [[str description] stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];

    return encodedUrl;
    
}

-(NSString*)WebURLDecodedString:(NSString* )str

{
     return [str stringByRemovingPercentEncoding];
    
}

@end
