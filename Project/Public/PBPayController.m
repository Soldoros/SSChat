//
//  PBPayController.m
//  LiangCang
//
//  Created by soldoros on 2020/3/21.
//  Copyright © 2020 soldoros. All rights reserved.
//

//支付界面
#import "PBPayController.h"
#import "PBViews.h"
#import "PBPayOverController.h"
#import "PBPayOverController.h"

#import "PBWebController.h"

@interface PBPayController ()<PBViewsDelegate>

@property(nonatomic,strong)PBPayTopView *topView;

@property(nonatomic,strong)UIButton *mButton;

//当前支付方式
@property(nonatomic,strong)NSDictionary *payDic;

@end

@implementation PBPayController


-(instancetype)init{
    if(self = [super init]){
        
        _orderDic = @{};
        self.dicts = [NSMutableDictionary new];
        self.datas = [NSMutableArray new];
        _payDic = @{};
    }
    return self;
}



-(void)registerNoti{
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ALiPayOver:) name:NotiALiPayOver object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WXPayOver:) name:NotiWXPayOver object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(yinlianPayOver:) name:NotiYinlianPayOver object:nil];
    
}

-(void)ALiPayOver:(NSNotification *)noti{
    NSDictionary *dic = noti.object;
    if([dic[@"resultStatus"] integerValue] == 9000){
        [self jumpTo];
    }else{
        [self showTime:dic[@"memo"]];
    }
}

//成功0  失败
-(void)WXPayOver:(NSNotification *)noti{
    
    cout(noti.object);
    NSDictionary *dic = noti.object;
    NSInteger code = [dic[@"code"]intValue];
    if(code == 0){
        [self jumpTo];
    }else{
        if([dic[@"code"]integerValue] == -2){
            [self showTime:@"已取消支付"];
        }else{
            [self showTime:@"支付失败"];
        }
    }
}

//银联支付完成
-(void)yinlianPayOver:(NSNotification *)noti{
    NSString *code = noti.object;
    
    if([code isEqualToString:@"success"]) {
        PBPayOverController *vc = [PBPayOverController new];
        vc.type = 0;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if([code isEqualToString:@"fail"]) {
        [self showTime:@"支付失败"];
    }
    else if([code isEqualToString:@"cancel"]) {
        [self showTime:@"取消支付"];
    }
}

-(void)jumpTo{
    
    [self sendNotifCation:NotiCartChange];
    [self sendNotifCation:NotiBoxChange];
    PBPayOverController *vc = [PBPayOverController new];
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)jumpToOrderListController{
    
    self.tabBarController.selectedIndex = 3;
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerNoti];
    self.view.backgroundColor = BackGroundColor;
    [self setNavgaionTitle:@"订单支付"];
    self.navLine.hidden = YES;
    
    _mButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:_mButton];
    _mButton.bounds = makeRect(0, 0, SCREEN_Width * 0.5, 44);
    _mButton.bottom = SCREEN_Height - SafeAreaBottom_Height - 15;
    _mButton.centerX = SCREEN_Width * 0.5;
    _mButton.layer.cornerRadius = 5;
    [_mButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    _mButton.backgroundColor = makeColorRgb(93, 163, 13);
    [_mButton setTitle:@"确认付款" forState:UIControlStateNormal];
    _mButton.titleLabel.font = makeBlodFont(16);
    _mButton.titleLabel.textColor = [UIColor whiteColor];
    
    
    self.mTableView.height -= 60;
    self.mTableView.backgroundColor = BackGroundColor;
    self.mTableView.backgroundView.backgroundColor = BackGroundColor;

    self.mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    _topView = [[PBPayTopView  alloc]initWithFrame:makeRect(0, 0, SCREEN_Width, PBPayTopViewH)];
    _topView.delegate = self;
    self.mTableView.tableHeaderView = _topView;
    _topView.dataDic = _orderDic;
    

    [self.mTableView registerClass:@"PBPayCell" andCellId:PBPayCellId];

    self.mTableView.mj_header= [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         [self netWorking];
    }];
    
    [self setLoadingStatus];

}

-(void)setLoadingStatus{
    
    [self deleteLoadingStatus];
    [self netWorking];
    self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.mTableView.frame superView:self.view statusCode:SSRequestStatusVaule11 loadingBlock:nil];
}

-(void)deleteLoadingStatus{
    
    [self.loadingStatus.mActivityImg.layer removeAllAnimations];
    [self.loadingStatus removeFromSuperview];
    self.loadingStatus = nil;
}


//支付方式
-(void)netWorking{
    
    NSDictionary *dic = @{@"prepayNo":[_orderDic[@"prepayNo"]description]};
    
    cout(dic);
    [SSAFRequest RequestNetWorking:SSRequestGetHeader parameters:dic method:URLPayWayList requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [self deleteLoadingStatus];
        [self.mTableView.mj_header endRefreshing];

        if(error){
            
            self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.mTableView.frame superView:self.view loadingBlock:^(SSRequestStatusCode statusCode) {
                [self setLoadingStatus];
            }];
           }else{
               
               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);
               
               if([dict[@"code"] integerValue] != 0){
                   NSString *message = dict[@"msg"];
                   self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:makeRect(0, SafeAreaTop_Height, SCREEN_Width, MainViewRoot_Height) superView:self.view message:message loadingBlock:^(SSRequestStatusCode statusCode) {
                       [self setLoadingStatus];
                   }];
               }
               else{
                   
                   [self.datas removeAllObjects];
                   [self.datas addObjectsFromArray:dict[@"data"][@"payWayList"][0]];
                   [self setDataChoice];
                   [self.mTableView reloadData];
                   
                   if(self.datas.count == 0){
                       self.loadingStatus = [[SSRequestLoadingStatus alloc]initWithFrame:self.mTableView.frame superView:self.view statusCode:SSRequestStatusVaule12 loadingBlock:^(SSRequestStatusCode statusCode) {
                           [self setLoadingStatus];
                       }];
                   }
               }
           }
        
   }];
   
}

-(void)setDataChoice{
    for(int i=0;i<self.datas.count;++i){
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.datas[i]];
        if(i==0){
            [dic setValue:@"1" forKey:@"choice"];
            _payDic = dic;
        }else{
            [dic setValue:@"0" forKey:@"choice"];
        }
        self.datas[i] = dic;
    }
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return PBPayCellH;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PBPayCell *cell = [tableView dequeueReusableCellWithIdentifier:PBPayCellId];
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.count = self.datas.count;
    cell.dataDic = self.datas[indexPath.row];
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    for(int i=0;i<self.datas.count;++i){
        NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:self.datas[i]];
        [dd setValue:@"0" forKey:@"choice"];
        self.datas[i] = dd;
    }
    
    NSMutableDictionary *dd = [NSMutableDictionary dictionaryWithDictionary:self.datas[indexPath.row]];
    [dd setValue:@"1" forKey:@"choice"];
    self.datas[indexPath.row] = dd;
    _payDic = dd;
    
    [self.mTableView reloadData];
    
}

//确认付款
-(void)buttonPressed:(UIButton *)sender{
    
    if(_payDic.count == 0){
        [self showTime:@"请选择支付方式"];
        return;
    }
    
    //支付方式id
    NSDictionary *dic = @{@"id":[_payDic[@"id"]description],
                          @"prepayNo":[_orderDic[@"prepayNo"]description]};

    
    cout(dic);
    [sender addActivityOnBtn];
    [SSAFRequest RequestNetWorking:SSRequestPostHeader parameters:dic method:URLPayMoney requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        [sender closeActivityByBtn:@"确认付款"];

        if(error){
            [self showTime:@"网络或服务器异常"];
           }else{

               NSDictionary *dict = makeDicWithJsonStr(object);
               cout(dict);

               if([dict[@"code"] integerValue] != 0){
                   NSString *message = dict[@"msg"];
                   [self showTime:message];
               }
               else{
                   
                   [self jumpToPay:dict];
               }
           }
       }];
}

//云闪付7  支付宝4  银联支付宝6  衫德支付宝5
-(void)jumpToPay:(NSDictionary *)dict{
    
    
    //云闪付
    if([dict[@"data"][@"payWay"] integerValue] == 7){
        
        
    }
    
    
    //银联支付宝payWay=6  2021002124697529  20000067 10000007
    if([dict[@"data"][@"payWay"] integerValue] == 6){
        NSString *header = @"alipay://platformapi/startapp?saId=10000007&qrcode=";
        
        NSString *aliPay = dict[@"data"][@"uniAliPay"];
        NSString *string = makeString(header, aliPay);
        cout(string);
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:string] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
             cout(@(success));
         }];
    }
    
    //衫德支付宝payWay=5
    if([dict[@"data"][@"payWay"] integerValue] ==5){
        
        NSString *shandeAliPay = dict[@"data"][@"sandAliPay"];
        
         [[UIApplication sharedApplication] openURL:[NSURL URLWithString:shandeAliPay] options:@{UIApplicationOpenURLOptionUniversalLinksOnly: @NO} completionHandler:^(BOOL success) {
             cout(@(success));
         }];
    }
    
}




@end
