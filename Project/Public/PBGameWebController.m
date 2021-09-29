//
//  PBGameWebController.m
//  FuWan
//
//  Created by soldoros on 2021/8/26.
//

#import "PBGameWebController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "SSShareViewController.h"
//#import "WebViewJavascriptBridge.h"

//WKScriptMessageHandler
@interface PBGameWebController ()<WKNavigationDelegate,WKUIDelegate>

//@property(nonatomic,strong)WebViewJavascriptBridge *bridge;

@end

@implementation PBGameWebController

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
    [self setNavgationBarColorImg:makeColorRgb(12, 4, 59)];
    [self setLeftOneBtnImg:@"return" color:[UIColor whiteColor]];
    self.titleLab.textColor = [UIColor blackColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:self.webTitle];
    self.navLine.hidden = YES;
   
    
    
    //onClick
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
    
    if(_htmlString.length != 0){
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
    
    
//    [WebViewJavascriptBridge enableLogging];
//    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
//    [_bridge setWebViewDelegate:self];
//
//    //web端获取APP端用户token
//    [_bridge registerHandler:@"onClick" handler:^(id data, WVJBResponseCallback responseCallback) {
//
//        cout(@"点击返回");
//    }];
    
}


- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {

}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation {

}

//跟js交互
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    
    //获取webview执行环境
//    JSContext *context  = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
//
//
//    //通过函数名 获取函数信息
//    context[@"onClick"] = ^() {
//
//        NSLog(@"拦截成功");
//        NSArray *args = [JSContext currentArguments];
//
//        for (JSValue *jsVal in args) {
//            NSLog(@"%@",jsVal);
//            //将js对象转换成字典   数组行不通
//            NSDictionary *arr = [jsVal toDictionary];
//            NSLog(@"%@", arr);
//
//        }
//
//        JSValue *this = [JSContext currentThis];
//        NSLog(@"通过webView获取到的js函数返回的对象数组:%@",this);
//
//    };
    
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




@end
