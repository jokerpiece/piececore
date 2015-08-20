//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BaseRecipient : NSObject
@property (nonatomic, strong)NSDictionary *resultset;
@property (nonatomic, strong)NSString *error_code;
@property (nonatomic, strong)NSString *error_message;
-(id)initWithResponseData:(NSDictionary *)data;
-(void)setData;
-(NSString *)valueForKey:(NSString *)key dec:(NSDictionary *)dec;

@end
