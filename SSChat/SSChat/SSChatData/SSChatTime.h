//
//  SSChatTime.h
//  SSChat
//
//  Created by soldoros on 2019/4/16.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR      3600
#define D_DAY       86400
#define D_WEEK      604800
#define D_YEAR      31556926

@interface SSChatTime : NSObject

+ (instancetype)shareSSChatTime;

+ (NSDate *)dateWithTimeIntervalInMilliSecondSince1970:(double)aMilliSecond;

+ (NSString *)formattedTimeFromTimeInterval:(long long)aTimeInterval;

+ (NSString *)formattedTime:(NSDate *)aDate;


@end



