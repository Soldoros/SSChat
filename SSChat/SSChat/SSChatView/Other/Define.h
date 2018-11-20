//
//  Define.h
//  SSChatView
//
//  Created by soldoros on 2018/9/25.
//  Copyright © 2018年 soldoros. All rights reserved.
//

#import "SSDeviceDefault.h"

#ifndef Define_h
#define Define_h

 
//当前窗口的高度 宽度
#define SCREEN_Height [[UIScreen mainScreen] bounds].size.height
#define SCREEN_Width  [[UIScreen mainScreen] bounds].size.width


#define makeColorRgb(_r, _g, _b)   [UIColor colorWithRed:_r / 255.0f green: _g / 255.0f blue:_b / 255.0f alpha:1]

#define SSChatCellColor  makeColorRgb(250, 250, 250)

//普通的灰色背景
#define BackGroundColor  makeColorRgb(246, 247, 248)
//cell线条颜色
#define CellLineColor  makeColorRgb(200, 200, 200)


//安全区域顶部
#define SafeAreaTop_Height  [SSDeviceDefault shareCKDeviceDefault].safeAreaTopHeight
//安全区域底部（iPhone X有）
#define SafeAreaBottom_Height  [SSDeviceDefault shareCKDeviceDefault].safeAreaBottomHeight

//状态栏
#define StatuBar_Height  [SSDeviceDefault shareCKDeviceDefault].statuBarHeight


#endif
