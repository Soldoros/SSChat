//
//  SSAlert.m
//  SSChat
//
//  Created by soldoros on 2019/4/14.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "SSAlert.h"

@implementation SSAlert

+(void)pressentAlertControllerWithTitle:(NSString *)title message:(NSString *)message okButton:(NSString *)ok cancelButton:(NSString *)cancel alertBlock:(AlertBlock)alertBlock{
    
    UIAlertAction* defaultAction,*cancelAction;
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if(ok){
        defaultAction = [UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            if(alertBlock){
                alertBlock(action);
            }
        }];
//        [defaultAction setValue:TitleColor forKey:@"_titleTextColor"];
        [alert addAction:defaultAction];
    }
    if(cancel){
        cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            if(alertBlock){
                alertBlock(action);
            }
        }];
//        [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
        [alert addAction:cancelAction];
    }
    
    UIViewController *controller = [UIViewController getCurrentController];
    dispatch_async(dispatch_get_main_queue(), ^{
        [controller presentViewController:alert animated:YES completion:nil];
    });
    
}


//带输入框的弹窗
+(void)pressentAlertWithTextPlaceHoder:(NSString *)placeholder title:(NSString *)title textBlock:(AlertTextBlock)textBlock{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        UITextField *textF = alert.textFields[0];
        
        textBlock(action, textF.text);
    }];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = placeholder;
    }];
    
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    UIViewController *controller = [UIViewController getCurrentController];
    [controller presentViewController:alert animated:YES completion:nil];
}


//返回一个红色小圆点
+(UIView *)redRoundView:(CGFloat)size{
    
    UIView *view = [UIView new];
    view.bounds = makeRect(0, 0, size, size);
    view.clipsToBounds = YES;
    view.layer.cornerRadius = size * 0.5;
    view.backgroundColor = TitleColor;
    return view;
}

//返回一个红色数字圆点
+(UILabel *)redNumber:(NSInteger)number{
    UILabel *label = [UILabel new];
    label.bounds = makeRect(0, 0, 10, 10);
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor redColor];
    label.text = makeStrWithInt(number);
    label.font = [UIFont systemFontOfSize:10];
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.width += 10;
    label.height = 14;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = label.height * 0.5;
    return label;
    
}


//系统分享
+(void)shareWithSystemController:(UIViewController *)controller url:(NSString *)url{
    
    NSString *string = makeString(@"http://barktv.cn/share.html?couponId=", url) ;
    
    NSMutableArray *items = [[NSMutableArray alloc] init];
    if(url != nil){
        [items addObject:[NSURL URLWithString:string]];
    }else{
        [items addObject:[UIImage imageNamed:@"fenxaingtu.jpg"]];
    }
    
    [self shareWithSystemController:controller array:items];
    
}


+(void)shareWithSystemController:(UIViewController *)controller array:(NSArray *)array{
    NSArray *excludedActivities = @[ UIActivityTypePostToFacebook,UIActivityTypePostToTwitter, UIActivityTypePostToWeibo, UIActivityTypeMessage,UIActivityTypeMail,UIActivityTypePrint,UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypeSaveToCameraRoll,UIActivityTypeAddToReadingList,UIActivityTypePostToFlickr,UIActivityTypePostToVimeo,UIActivityTypePostToTencentWeibo,UIActivityTypeOpenInIBooks];
    
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:array applicationActivities:@[[UIActivity new]]];
    activityVC.excludedActivityTypes = excludedActivities;
    
    [controller presentViewController:activityVC animated:YES completion:nil];
}

@end


