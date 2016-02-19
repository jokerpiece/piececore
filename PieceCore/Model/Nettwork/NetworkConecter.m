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
    //[param setObject:[PieceCoreConfig appKey] forKey:@"app_key"];
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
              DLog(@"url: %@ \n responseObject: %@", sendId, responseObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              [self.delegate receiveError:error sendId:sendId];
          }];
}
-(void)sendActionUrl:(NSString *)url param:(NSMutableDictionary*)param{
    if (param == nil) {
        param = [NSMutableDictionary dictionary];
    }
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [param setObject:[PieceCoreConfig shopId] forKey:@"app_id"];
    //[param setObject:[PieceCoreConfig appKey] forKey:@"app_key"];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    //SN 新しいAPIを受け取るため追加
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/html", nil]];
    DLog(@"API通信　%@: param%@",url,param);
    [manager POST:url
       parameters:param
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [self.delegate receiveSucceed:responseObject sendId:url];
              // 通信に成功した場合の処理
              DLog(@"url: %@ \n responseObject: %@", url, responseObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              [self.delegate receiveError:error sendId:url];
          }];
    
    
}
-(void)sendActionWithAFHTTPSessionManager:(AFHTTPSessionManager *)manager url:(NSString *)url  param:(NSMutableDictionary*)param{
    [manager POST:url
       parameters:param
          success:^(NSURLSessionDataTask *task, id responseObject) {
              [self.delegate receiveSucceed:responseObject sendId:url];
              // 通信に成功した場合の処理
              DLog(@"responseObject: %@", responseObject);
          } failure:^(NSURLSessionDataTask *task, NSError *error) {
              [self.delegate receiveError:error sendId:url];
          }];
}

-(void)uploadActionUrl:(NSString *)url
           headerParam:(NSMutableDictionary*)headerParam
                 param:(NSMutableDictionary*)param
              fileData:(NSData *)fileData
              pramName:(NSString *)parmName
              fileName:(NSString *)fileName
              mineTipe:(NSString *)mineTipe{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    for (id key in headerParam) {
        DLog(@"Key:%@ Value:%@", key, [headerParam valueForKey:key]);
        [manager.requestSerializer setValue:[headerParam valueForKey:key] forHTTPHeaderField:key];
    }
    [manager POST:url
       parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
     {
         [formData appendPartWithFileData:fileData name:parmName fileName:fileName mimeType:mineTipe];
         
     }
          success:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [self.delegate receiveSucceed:responseObject sendId:url];
         DLog(@"response is :  %@",responseObject);
     }
          failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
        [self.delegate receiveError:error sendId:url];
     }];
}


@end
