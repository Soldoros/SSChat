




#import "AppDelegate.h"
#import "RootController.h"
#import "SSChatDefault.h"

#import <AMapFoundationKit/AMapFoundationKit.h>
#define GaodeKey @"7fc6ef907cf94f1748039415ca1adad2"


@interface AppDelegate ()<UITabBarControllerDelegate,CLLocationManagerDelegate,UIApplicationDelegate,NSURLConnectionDataDelegate>

@end


@implementation AppDelegate{
    
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [AMapServices sharedServices].apiKey = GaodeKey;
    [[SSChatDefault shareSSChatDefault]initSSChat];
    
    RootController *vc = [[RootController alloc]initWithRoot:YES];
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:vc];
    [self.window makeKeyAndVisible];
    return YES;
    
}


//app进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

//app返回前台
- (void)applicationWillEnterForeground:(UIApplication *)application {
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}


//当app从后台切到前台时调用的方法
- (void)applicationDidBecomeActive:(UIApplication * )application{
  
}




@end

