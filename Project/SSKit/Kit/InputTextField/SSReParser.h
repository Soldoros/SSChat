//
//  SSReParser.h
//  MECP
//
//  Created by soldoros on 2021/6/23.
//

#import <Foundation/Foundation.h>


#import <Foundation/Foundation.h>

@class SSReGroup;

@interface SSReParser : NSObject
{
    NSString *_pattern;
    BOOL _ignoreCase;
    SSReGroup *_node;
    BOOL _finished;
    NSRegularExpression *_exactQuantifierRegex;
    NSRegularExpression *_rangeQuantifierRegex;
}

- (id)initWithPattern:(NSString*)pattern;
- (id)initWithPattern:(NSString*)pattern ignoreCase:(BOOL)ignoreCase;
- (NSString*)reformatString:(NSString*)input;

@property (readonly, nonatomic) NSString *pattern;

@end

