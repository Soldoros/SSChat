//
//  RootTabBarController.m
//  SSChat
//
//  Created by soldoros on 2019/5/12.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "RootTabBarController.h"
#import "RootNavigationController.h"
#import "ConversationController.h"
#import "ContactController.h"
#import "MineController.h"

@interface RootTabBarController ()<UITabBarControllerDelegate,NIMConversationManagerDelegate,NIMSystemNotificationManagerDelegate>

@property(nonatomic,assign) NSInteger sessionUnreadCount;
@property(nonatomic,assign) NSInteger systemUnreadCount;

@end

@implementation RootTabBarController


-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.selectedViewController;
}

-(void)dealloc{
    [[NIMSDK sharedSDK].systemNotificationManager removeDelegate:self];
    [[NIMSDK sharedSDK].conversationManager removeDelegate:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initalizeUserInterface];
    
    [[NIMSDK sharedSDK].systemNotificationManager addDelegate:self];
    [[NIMSDK sharedSDK].conversationManager addDelegate:self];
    _sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    _systemUnreadCount = [NIMSDK sharedSDK].systemNotificationManager.allUnreadCount;
    
    [self refreshSessionBadge];
    [self refreshContactBadge];
}


-(void)initalizeUserInterface{
    
    ConversationController *vc1 = [[ConversationController alloc]initWithRoot:YES title:@"消息"];
    ContactController *vc2 = [[ContactController alloc]initWithRoot:YES title:@"通讯录"];
    MineController *vc3 = [[MineController alloc]initWithRoot:YES title:@"我的"];
    
    RootNavigationController *nav1 = [self setNav:vc1 title:@"消息" nomImg:@"Tab_message_nol" selImg:@"Tab_message_sel"];
    RootNavigationController *nav2 = [self setNav:vc2 title:@"通讯录" nomImg:@"Tab_contact_nol" selImg:@"Tab_contact_sel"];
    RootNavigationController *nav3 = [self setNav:vc3 title:@"我的" nomImg:@"Tab_wode_nol" selImg:@"Tab_wode_sel"];
    
    self.delegate = self;
    self.viewControllers = @[nav1,nav2,nav3];
    [AppDelegate sharedAppDelegate].window.rootViewController = self;
}


-(RootNavigationController *)setNav:(BaseVirtualController *)vc title:(NSString *)title nomImg:(NSString *)img1 selImg:(NSString *)img2{
    [vc setItemImg1:img1 img2:img2 title:title color1:TabBarTintDefaultColor color2:TabBarTintSelectColor];
    RootNavigationController *nav = [[RootNavigationController alloc]initWithRootViewController:vc];
    return nav;
}


#pragma mark - NIMConversationManagerDelegate
-(void)didAddRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    _sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}

-(void)didUpdateRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    _sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}

-(void)didRemoveRecentSession:(NIMRecentSession *)recentSession totalUnreadCount:(NSInteger)totalUnreadCount{
    _sessionUnreadCount = totalUnreadCount;
    [self refreshSessionBadge];
}

-(void)messagesDeletedInSession:(NIMSession *)session{
    _sessionUnreadCount = [NIMSDK sharedSDK].conversationManager.allUnreadCount;
    [self refreshSessionBadge];
}

-(void)allMessagesDeleted{
    _sessionUnreadCount = 0;
    [self refreshSessionBadge];
}

-(void)allMessagesRead{
    _sessionUnreadCount = 0;
    [self refreshSessionBadge];
}

#pragma mark - NIMSystemNotificationManagerDelegate
-(void)onSystemNotificationCountChanged:(NSInteger)unreadCount{
    _systemUnreadCount = unreadCount;
    [self refreshContactBadge];
}

//刷新会话tabBarItem
-(void)refreshSessionBadge{
    UINavigationController *nav = self.viewControllers[0];
    nav.tabBarItem.badgeValue = _sessionUnreadCount ? @(_sessionUnreadCount).stringValue : nil;
}

//刷新好友tabBarItem
- (void)refreshContactBadge{
    UINavigationController *nav = self.viewControllers[1];
    nav.tabBarItem.badgeValue = _systemUnreadCount ? @(_systemUnreadCount).stringValue : nil;
}

@end
