//
//  MineViews.h
//  SSChat
//
//  Created by soldoros on 2019/4/10.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MineData.h"

@protocol MineViewsDelegate <NSObject>

-(void)MineSwitchCellBtnClick:(UISwitch *)sender indexPath:(NSIndexPath *)indexPath;

@end




//顶部个人信息
#define MineTopCellId  @"MineTopCellId"
#define MineTopCellH   80

@interface MineTopCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NIMUser *user;

@property(nonatomic,strong)UIImageView *mLeftImgView;
@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mDetailLab;


@end


//中间cell
#define MineCenterCellId  @"MineCenterCellId"
#define MineCenterCellH   55

@interface MineCenterCell : UITableViewCell

@property(nonatomic,strong)UILabel *mTitleLab;
@property(nonatomic,strong)UILabel *mDetailLab;

@end



//退出登录
#define MineLogOutCellId  @"MineLogOutCellId"
#define MineLogOutCellH   55

@interface MineLogOutCell : UITableViewCell

@end



//个人信息cell
#define MineInformationCellId   @"MineInformationCellId"
#define MineInformationCellH    80
#define MineInformationCellH2   60

@interface MineInformationCell : UITableViewCell

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)NSDictionary *dataDic;

@property(nonatomic,strong)UIImageView *mRightImgView;

@end




/**
 系统设置cell
 */
#define MineSwitchCellId   @"AccountSwitchCellId"
#define MineSwitchCellH    55

@interface MineSwitchCell : UITableViewCell

@property(nonatomic,assign)id<MineViewsDelegate>delegate;

@property(nonatomic,strong)NSIndexPath *indexPath;
@property(nonatomic,strong)UISwitch *mSwitch;

@property(nonatomic,strong)NSDictionary *dataDic;

@end
