//
//  RootController.m
//  caigou
//  汪慧芬 420902199309126068
//
//  Created by soldoros on 2018/4/8.
//  Copyright © 2018年 soldoros. All rights reserved.
//




#import "RootController.h"
#import "SSChatController.h"



@interface RootController ()
    
@property(nonatomic,strong)NSUserDefaults *user;

@end

@implementation RootController
    
-(instancetype)init{
    if(self = [super init]){
        _user = [NSUserDefaults standardUserDefaults];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaionTitle:@"SSChat"];
    self.view.backgroundColor = [UIColor whiteColor];

    
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    SSChatController *vc = [SSChatController new];
    vc.userName = SSChatReceiveUserName;
    [self.navigationController pushViewController:vc animated:YES];
}




    
    

@end
