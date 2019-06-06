//
//  ContactSeniorTeamDetController.m
//  SSChat
//
//  Created by soldoros on 2019/6/6.
//  Copyright © 2019 soldoros. All rights reserved.
//

#import "ContactSeniorTeamDetController.h"
#import "ContactViews.h"
#import "ContactFriendDetController.h"

@interface ContactSeniorTeamDetController ()<ContactViewsDelegate>

@end

@implementation ContactSeniorTeamDetController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.datas = [NSMutableArray new];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavgaionTitle:@"高级群"];
    
    self.mCollectionView.height += SafeAreaBottom_Height;
    [self.mCollectionView registerClass:[ContactTeamDetTopCell class] forCellWithReuseIdentifier:ContactTeamDetTopCellId];
    [self.mCollectionView registerClass:[ContactTeamDetOtherCell class] forCellWithReuseIdentifier:ContactTeamDetOtherCellId];
    [self.mCollectionView registerClass:[ContactTeamDetBottomCell class] forCellWithReuseIdentifier:ContactTeamDetBottomCellId];
    self.mCollectionView.backgroundColor = BackGroundColor;
    self.mCollectionView.backgroundView.backgroundColor = BackGroundColor;
    
    [self netWorking];
}

-(void)netWorking{
    
    [[NIMSDK sharedSDK].teamManager fetchTeamMembers:_team.teamId completion:^(NSError * _Nullable error, NSArray<NIMTeamMember *> * _Nullable members) {
        if(error){
            [self showTime:@"获取群成员失败"];
        }else{
            [self.datas removeAllObjects];
            [self.datas addObjectsFromArray:members];
            [self.mCollectionView reloadData];
        }
    }];
}



//群成员  群主+群名称  群介绍+群公告  消息提醒+聊天置顶  清空+删除
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 5;
}

//header尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return CGSizeMake(0, 0);
    }else{
        return CGSizeMake(SCREEN_Width, 10);
    }
}

//footer尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0, 0);
}


//创建区头视图和区尾视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind == UICollectionElementKindSectionHeader){
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"headerId" forIndexPath:indexPath];
        return headerView;
    }else if(kind == UICollectionElementKindSectionFooter){
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footerId" forIndexPath:indexPath];
        return footerView;
    }
    return nil;
}


#pragma SSCollectionViewFlowLayoutDelegate  分组返回灰色
-(UIColor *)backgroundColorForSection:(NSInteger)section collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout{
    if(section == 0){
        return [UIColor whiteColor];
    }else{
        return BackGroundColor;
    }
}


//群成员  群主+群名称  群介绍+群公告  消息提醒+聊天置顶  清空+删除
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if(section == 0){
        return  self.datas.count;
    }else{
        return 2;
    }
}


//群成员  群主+群名称  群介绍+群公告  消息提醒+聊天置顶  清空+删除
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return CGSizeMake(ContactTeamDetTopCellW, ContactTeamDetTopCellH);
    }
    else if(indexPath.section == 4){
        return CGSizeMake(ContactTeamDetBottomCellW, ContactTeamDetBottomCellH);
    }
    else {
        return CGSizeMake(ContactTeamDetOtherCellW, ContactTeamDetOtherCellH);
    }
}

//每个分区的内边距（上左下右）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if(section == 0){
        return UIEdgeInsetsMake(15, 10, 0, 10);
    }else{
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
}


//分区内cell之间的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if(section == 0)return 0;
    else return 1;
}

//分区内cell之间的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}


//群成员  群主+群名称  群介绍+群公告  消息提醒+聊天置顶  清空+删除
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        ContactTeamDetTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetTopCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.member = self.datas[indexPath.row];
        return cell;
    }
    else if(indexPath.section == 4){
        ContactTeamDetBottomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetBottomCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        cell.delegate = self;
        [cell setSeniorTeamData:_team];
        return cell;
    }
    else{
        ContactTeamDetOtherCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ContactTeamDetOtherCellId forIndexPath:indexPath];
        cell.indexPath = indexPath;
        [cell setSeniorTeamData:_team];
        return cell;
    }
    
}


//点击cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    if(indexPath.section == 0){
        NIMTeamMember *member = self.datas[indexPath.row];
        ContactFriendDetController *vc = [ContactFriendDetController new];
        vc.user = [[NIMSDK sharedSDK].userManager userInfo:member.userId];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma arguments ContactViewsDelegate
-(void)ContactTeamDetBottomCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender{
    
    //清空当前会话
    if(indexPath.row == 0){
        [self deleteAllmessages];
    }
    //退群
    else{
        [self quitTeam];
    }
}

//清空当前会话
-(void)deleteAllmessages{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确认清空当前会话的聊天记录" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* outAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
        
        NIMSession *session = [NIMSession session:self.team.teamId type:NIMSessionTypeTeam];
        NIMDeleteMessagesOption *option = [[NIMDeleteMessagesOption alloc] init];
        option.removeSession = YES;
        option.removeTable = YES;
        [[NIMSDK sharedSDK].conversationManager deleteAllmessagesInSession:session option:option];
        [self showTime:@"已清空聊天记录"];
    }];
    
    [alert addAction:outAction];
    [alert addAction:deleteAction];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentViewController:alert animated:YES completion:nil];
    });
}

//退群
-(void)quitTeam{
    
    [[NIMSDK sharedSDK].teamManager quitTeam:_team.teamId completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"退群成功"];
            [self performSelector:@selector(jumoTo) withObject:nil afterDelay:1];
        }else{
            [self showTime:error.description];
        }
    }];
}

//解散群
-(void)dismissTeam{
    [[NIMSDK sharedSDK].teamManager dismissTeam:_team.teamId completion:^(NSError *error) {
        if (!error) {
            [self showTime:@"已解散该群"];
            [self performSelector:@selector(jumoTo) withObject:nil afterDelay:1];
        }else{
            [self showTime:error.description];
        }
    }];
}

-(void)jumoTo{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
