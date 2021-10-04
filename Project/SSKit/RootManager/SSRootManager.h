//
//  SSRootManager.h
//  SSChat
//
//  Created by soldoros on 2019/4/17.
//  Copyright © 2019 soldoros. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 以类族的模式管理 SSRootPartOfManager + SSRootAllOfManager
 */
@interface SSRootManager : NSObject

+(instancetype)shareRootManager;


@end
