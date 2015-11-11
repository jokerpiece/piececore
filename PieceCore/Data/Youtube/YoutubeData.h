//
//  YoutubeData.h
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YoutubeData : NSObject
@property (nonatomic,strong) NSString *token;
@property (nonatomic,strong) NSString *order_id;
@property (nonatomic,strong) NSString *scheme_str_flg;
@property (nonatomic,strong) NSString *type;

-(id)init;
+ (void)setToken:(NSString*)str;
+ (NSString *)getToken;
+ (void)setSchemeStrFlg:(NSString*)str;
+ (NSString *)getSchemeStrFlg;
+ (void)setOrderId:(NSString*)str;
+ (NSString *)getOrderId;
+ (void)setType:(NSString*)str;
+ (NSString *)getType;
@end
