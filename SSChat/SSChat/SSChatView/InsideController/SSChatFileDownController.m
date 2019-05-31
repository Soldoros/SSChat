//
//  SSChatFileDownController.m
//  SSChat
//
//  Created by soldoros on 2019/5/30.
//  Copyright © 2019 soldoros. All rights reserved.
//

//文件详情
#import "SSChatFileDownController.h"

@interface SSChatFileDownController ()

@end

@implementation SSChatFileDownController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"文件详情"];
    
    UIImageView *imageView = [UIImageView new];
    imageView.bounds = CGRectMake(0, 0, 80, 100);
    imageView.centerX = SCREEN_Width * 0.5;
    imageView.top = SafeAreaTop_Height + 100;
    imageView.image = [UIImage imageNamed:@"icon_file"];
    [self.view addSubview:imageView];
    
    UILabel *label = [UILabel new];
    label.bounds = CGRectMake(0, 0, SCREEN_Width - 100, 50);
    label.numberOfLines = 4;
    label.font = [UIFont systemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.text = _fileObject.displayName;
    [label sizeToFit];
    label.top = imageView.bottom + 40;
    label.centerX = SCREEN_Width * 0.5;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.bounds = CGRectMake(0, 0, SCREEN_Width * 0.5, 45);
    button.centerX = SCREEN_Width * 0.5;
    button.top = label.bottom + 80;
    [self.view addSubview:button];
    button.backgroundColor = TitleColor;
    button.clipsToBounds = YES;
    button.layer.cornerRadius = 3;
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button setTitle:@"用其他应用打开" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)buttonPressed:(UIButton *)sender{
    
    NSURL *url = [NSURL fileURLWithPath:_fileObject.path];
    NSArray *items = @[url];
    
    NSArray *excludedActivities = @[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
    
    UIActivityViewController *activityViewController =
    [[UIActivityViewController alloc] initWithActivityItems:items applicationActivities:nil];
    activityViewController.excludedActivityTypes = excludedActivities;
    [self presentViewController:activityViewController animated:YES completion:nil];
    
}


@end
