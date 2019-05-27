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
        [defaultAction setValue:TitleColor forKey:@"_titleTextColor"];
        [alert addAction:defaultAction];
    }
    if(cancel){
        cancelAction = [UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
            if(alertBlock){
                alertBlock(action);
            }
        }];
        [cancelAction setValue:TitleColor forKey:@"_titleTextColor"];
        [alert addAction:cancelAction];
    }
    
    UIViewController *controller = [AppDelegate sharedAppDelegate].window.rootViewController;
    [controller presentViewController:alert animated:YES completion:nil];
}


@end
