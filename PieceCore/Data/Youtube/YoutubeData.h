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
@property (nonatomic,strong) NSString *update_token;
@property (nonatomic,strong) NSString *order_num;
@property (nonatomic,strong) NSString *scheme_str_flg;
@property (nonatomic,strong) NSString *type;

-(id)init;
+ (void)setToken:(NSString*)str;
+ (NSString *)getToken;
+ (void)setUpdateToken:(NSString*)str;
+ (NSString *)getUpdateToken;
+ (void)setSchemeStrFlg:(NSString*)str;
+ (NSString *)getSchemeStrFlg;
+ (void)setOrderNum:(NSString*)str;
+ (NSString *)getOrderNum;
+ (void)setType:(NSString*)str;
+ (NSString *)getType;
@end
