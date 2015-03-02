//
//  NetworkConecter.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NetworkConecter.h"
#import "PieceCoreConfig.h"

@implementation NetworkConecter
-(void)sendActionSendId:(NSString *)sendId param:(NSMutableDictionary*)param{
    
    if (param == nil) {
        param = [NSMutableDictionary dictionary];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [param setObject:[PieceCoreConfig shopId] forKey:@"app_id"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //SN 新しいAPIを受け取るため追加
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    DLog(@"API通信　%@%@: param%@",ServerUrl,sendId,param);
    [manager POST:[NSString stringWithFormat:@"%@%@",ServerUrl,sendId]
      parameters:param
         success:^(NSURLSessionDataTask *task, id responseObject) {
             [self.delegate receiveSucceed:responseObject sendId:sendId];
             // 通信に成功した場合の処理
             DLog(@"responseObject: %@", responseObject);
         } failure:^(NSURLSessionDataTask *task, NSError *error) {
             [self.delegate receiveError:error sendId:sendId];
         }];
    
    
}
@end
