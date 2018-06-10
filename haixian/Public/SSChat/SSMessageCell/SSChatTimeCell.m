//
//  SSChatTimeCell.m
//  haixian
//
//  Created by soldoros on 2017/11/13.
//  Copyright © 2017年 soldoros. All rights reserved.
//

#import "SSChatTimeCell.h"

@implementation SSChatTimeCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]){
        
        self.textLabel.font = makeFont(SSChatTimeFont);
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor grayColor];

    }
    return self;
}


-(void)setLayout:(SSChatModelLayout *)layout{

    self.textLabel.text   = [NSString stringWithFormat:@"%lld",layout.model.messageTime];
    
}






@end
