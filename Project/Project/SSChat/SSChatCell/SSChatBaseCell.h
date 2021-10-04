//
//  SSChatBaseCell.h
//  Project
//
//  Created by soldoros on 2021/9/29.
//

#import <UIKit/UIKit.h>
#import "SSChatMessage.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSChatBaseCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)SSChatMessage *message;

@end

NS_ASSUME_NONNULL_END
