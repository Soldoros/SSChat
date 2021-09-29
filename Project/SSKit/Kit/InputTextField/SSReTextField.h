//
//  SSReTextField.h
//  MECP
//
//  Created by soldoros on 2021/6/23.
//


#import <UIKit/UIKit.h>

@class SSReParser;


@protocol SSReTextFieldDelegate <NSObject>

-(void)TextKeyBordDelete;

@end


@interface SSReTextField : UITextField
{
    NSString *_lastAcceptedValue;
    SSReParser *_parser;
}


@property(nonatomic,assign)id<SSReTextFieldDelegate>ssdelegate;
@property (strong, nonatomic) NSString *pattern;





@end
