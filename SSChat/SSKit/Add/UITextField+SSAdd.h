//
//  UITextField+SSAdd.h
//  caigou
//
//  Created by soldoros on 2018/1/31.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (SSAdd)

+(BOOL)textF:(UITextField *)textField shouldChangeRange:(NSRange)range replacementString:(NSString *)string;

@end
