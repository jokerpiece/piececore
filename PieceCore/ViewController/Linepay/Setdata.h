//
//  setData.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Setdata : NSObject

@property (nonatomic, strong) NSString *item_name;
@property (nonatomic, strong) NSString *item_price;

-(id)init;

+ (NSString *)getname:(NSString *)str;
+ (NSString *)getprice:(NSString *)str;
+ (NSString *)getaddress:(NSString *)str;
+ (NSString *)getsei:(NSString *)str;
+ (NSString *)getmei:(NSString *)str;
+ (NSString *)getmail:(NSString *)str;
+ (NSString *)getpostage:(NSString *)str;
+ (NSString *)gettransaction:(NSString *)str;
+ (NSString *)getlineurl:(NSString*)str;
@end
