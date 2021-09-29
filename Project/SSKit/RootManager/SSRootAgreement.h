//
//  SSRootAgreement.h
//  FuWan
//
//  Created by soldoros on 2021/8/4.
//

/*
 
 回调遵循的协议
 
 
 */


//View按钮点击回调
typedef void(^SSViewBtnClickBlock)(NSDictionary *dic, UIButton *sender);
//ViewCell按钮点击回调
typedef void(^SSViewCellClickBlock)(NSDictionary *dic, NSIndexPath *indexPath);
//header-Footer按钮点击回调
typedef void(^SSHeaderFooterBtnClickBlock)(NSInteger section, NSDictionary *dic, UIButton *sender);
//cell按钮点击回调
typedef void(^SSCellBtnClickBlock)(NSIndexPath *indexPath, NSDictionary *dic, UIButton *sender);
//cell按钮点击回调
typedef void(^SSCellBtnObjClickBlock)(NSIndexPath *indexPath, id object, UIButton *sender);
//cellt图片点击回调
typedef void(^SSCellImgClickBlock)(NSIndexPath *indexPath, NSArray *array, UIImageView *image);
//cell输入回调
typedef void(^SSCellEditChangeBlock)(NSIndexPath *indexPath, id object, NSString *string);
//cell图片上传回调
typedef void(^SSCellImageChangeBlock)(NSIndexPath *indexPath, NSArray *array);
//控制器对象回调
typedef void(^SSControllerDicBlock)(UIViewController *controller, NSDictionary *dic);
//控制器数组回调
typedef void(^SSControllerArrBlock)(UIViewController *controller, NSArray *arr);

//控制器对象回调 传分组
typedef void(^SSControllerObjectBlock)(NSIndexPath *indexPath,UIViewController *controller, id object);


//cell输入框输入回调
typedef void(^SSCellTextViewChangeBlock)(NSIndexPath *indexPath, id object, NSString *string, NSString *currrentStr);





@protocol PubilcDelegate <NSObject>

//列表点击回调
-(void)PubilcTableViewCellClick:(NSIndexPath *)indexPath dic:(NSDictionary *)dic;

//控制器按钮点击回调
-(void)PubilcControllerButtonClick:(UIViewController *)controller dic:(NSDictionary *)dic;

//控制器按钮点击回调
-(void)PubilcControllerButtonClick:(UIViewController *)controller indexPath:(NSIndexPath *)indexPath dic:(NSDictionary *)dic;


//view按钮点击回调
-(void)PubilcViewBtnClick:(UIButton *)sender dic:(NSDictionary *)dic;

//view按钮点击回调
-(void)PubilcViewCellBtnClick:(NSIndexPath *)indexPath sender:(id)sender dic:(NSDictionary *)dic;

//header按钮点击回调
-(void)PubilcTableHeaderBtnClick:(NSInteger)section sender:(UIButton *)sender dic:(NSDictionary *)dic;

//Footer按钮点击回调
-(void)PubilcTableFooterBtnClick:(NSInteger)section sender:(UIButton *)sender dic:(NSDictionary *)dic;

//cell按钮点击回调
-(void)PubilcCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender dic:(NSDictionary *)dic;

//cell图片更新
-(void)PubilcCellImageUpdata:(NSIndexPath *)indexPath sender:(UIButton *)sender object:(id)object;


//cell图片点击回调
-(void)PubilcCellImgBtnClick:(NSIndexPath *)indexPath imgView:(UIImageView *)imgView object:(id)object;

//cell按钮点击回调
-(void)PubilcTableCellBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender object:(id)object;


//cell输入框编辑回调
-(void)PubilcCellEdit:(NSIndexPath*)indexPath textF:(UITextField *)textF string:(NSString *)string;

//cell输入框编辑回调
-(void)PubilcViewEdit:(NSIndexPath*)indexPath textF:(id)object string:(NSString *)string;

//Collection header按钮点击回调
-(void)PubilcCollectionHeaderBtnClick:(NSIndexPath *)indexPath sender:(UIButton *)sender dic:(NSDictionary *)dic;


//Collection header按钮点击回调
-(void)PubilcWindowBtnClick:(UIButton *)sender object:(id)object view:(UIView *)view index:(NSInteger)index;


@end
