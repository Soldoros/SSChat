//
//  AccountData.m
//  QuFound
//
//  Created by soldoros on 2020/5/13.
//  Copyright © 2020 soldoros. All rights reserved.
//

#import "AccountData.h"
#import <CommonCrypto/CommonDigest.h>

@implementation AccountData


//{
//   appPayWay = 4;
//   appUpdate = 0;
//   appUpdateContent = "1\Uff0c\U4f18\U5316\U62bd\U5956\U4f53\U9a8c\U4f18\U5316\U62bd\U5956\U4f53\U9a8c\U4f18\U5316\U62bd\U5956\U4f53\U9a8c\U4f18\U5316\U62bd\U5956\U4f53\U9a8c\U4f18\U5316\U62bd\U5956\U4f53\U9a8c\\n2,\U589e\U52a0\U788e\U7247\U76f2\U76d2agaghaersaa";
//   appVer = "1.1.8";
//   appleNoticeShow = 1;
//   shareInfo =         {
//       bagShare =             {
//           imgUrl = "https://fuapp-1259063781.file.myqcloud.com/shareImages/shareBag_#.jpg";
//           jumpPath = "";
//           sharePosition = bagShare;
//           text = "\U5f00\U542f\U6f6e\U798f\U888b\Uff0cIPHONE\U3001YEEZY\U5f00\U4e0d\U505c";
//       };
//       fragShare =             {
//           imgUrl = "https://fuapp-1259063781.file.myqcloud.com/shareImages/frag_#.jpg";
//           jumpPath = "";
//           sharePosition = fragShare;
//           text = "\U5f00\U542f\U6f6e\U798f\U888b\Uff0cIPHONE\U3001YEEZY\U5f00\U4e0d\U505c";
//       };
//       inviteShare =             {
//           imgUrl = "https://fuapp-1259063781.file.myqcloud.com/shareImages/share_61.jpeg ";
//           jumpPath = "";
//           sharePosition = inviteShare;
//           text = "\U5f00\U542f\U6f6e\U798f\U888b\Uff0cIPHONE\U3001YEEZY\U5f00\U4e0d\U505c";
//       };
//       luckyDrawFiveTen =             {
//           imgUrl = "";
//           jumpPath = "";
//           sharePosition = luckyDrawFiveTen;
//           text = "[0.035,0.050]";
//       };
//       mainShare =             {
//           imgUrl = "https://fuapp-1259063781.file.myqcloud.com/shareImages/share_61.jpeg ";
//           jumpPath = "";
//           sharePosition = mainShare;
//           text = "\U5f00\U542f\U6f6e\U798f\U888b\Uff0cIPHONE\U3001YEEZY\U5f00\U4e0d\U505c";
//       };
//       payError =             {
//           imgUrl = "";
//           jumpPath = "https://mp.weixin.qq.com/s/sK5LSaM5fJ5c-eAUXuUhJQ";
//           sharePosition = payError;
//           text = "";
//       };
//       presentShare =             {
//           imgUrl = "https://fuapp-1259063781.file.myqcloud.com/shareImages/share_61.jpeg ";
//           jumpPath = "";
//           sharePosition = presentShare;
//           text = "\U5f00\U542f\U6f6e\U798f\U888b\Uff0cIPHONE\U3001YEEZY\U5f00\U4e0d\U505c";
//       };
//   };
//综合接口
+(void)shareInfoNetWorking{
    
    [SSAFRequest RequestNetWorking:SSRequestGetHeader parameters:@{} method:URLShareInfo requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        
        if(error){
            cout(error.domain);
        }
        else{
        
           NSDictionary *dict = makeDicWithJsonStr(object);
           cout(dict);
           
           if([dict[@"code"] integerValue] != 0){
               NSString *message = dict[@"msg"];
               cout(message);
           }
           else{
               
               
               [SSRootAccount setShareInfo:dict[@"data"]];
           }
        }
     
    }];
}





-(void)upload:(NSData *)data{
    
    NSString *md5 = [data md5String];
    NSDictionary *dic = @{@"md5":md5};
    
    cout(dic);
    [SSAFRequest PostWithFile:dic method:makeString(URLContentString, @"") imgData:data name:@"file" requestHeader:@{} result:^(id object, NSError *error, NSURLSessionDataTask *task) {
        
        if(error){
            
            
        }else{
            NSDictionary *dict = makeDicWithJsonStr(object);
            cout(dict);
            
            if([dict[@"code"]integerValue] != 0){
                
            }
        }
    }];
}





@end
