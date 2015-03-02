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
-(void)sendActionSendId:(NSString *)sendId param:(NSDictionary*)param;
@end
