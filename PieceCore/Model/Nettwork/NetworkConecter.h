//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "DLog.h"

@protocol NetworkDelegate
-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId;
-(void)receiveError:(NSError *)error sendId:(NSString *)sendId;
@end

@interface NetworkConecter : NSObject
@property (nonatomic,weak) id delegate;
@property (nonatomic) NSDictionary *headerParam;

-(void)sendActionSendId:(NSString *)sendId param:(NSDictionary*)param;
-(void)sendActionUrl:(NSString *)url param:(NSMutableDictionary*)param;
-(void)sendActionWithAFHTTPSessionManager:(AFHTTPSessionManager *)manager url:(NSString *)url  param:(NSMutableDictionary*)param;
-(void)uploadActionUrl:(NSString *)url
           headerParam:(NSMutableDictionary*)headerParam
                 param:(NSMutableDictionary*)param
              fileData:(NSData *)fileData
              pramName:(NSString *)parmName
              fileName:(NSString *)fileName
              mineTipe:(NSString *)mineTipe;

@end
