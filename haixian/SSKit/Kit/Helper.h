//
//  Helper.h
//  EVNCustomSearchBar
//
//  Created by developer on 2017/9/28.
//  Copyright © 2017年 仁伯安. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Helper : NSObject

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIImage *)imagesNamedFromCustomBundle:(NSString *)imgName;

+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

@end
