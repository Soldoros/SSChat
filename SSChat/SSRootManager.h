//
//  SSRootManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSRootManager : NSObject<NIMLoginManagerDelegate>

+(SSRootManager *)shareRootManager;

@end

