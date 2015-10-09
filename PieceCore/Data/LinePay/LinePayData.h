//
//  setData.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LinePayData : NSObject

@property (nonatomic, strong) NSString *item_name;
@property (nonatomic, strong) NSString *item_price;

-(id)init;

+ (void)setOrderId:(NSString*)str;
+ (NSString *)getOrderId;
+ (void)setItemName:(NSString*)str;
+ (NSString *)getItemName;

+ (void)setItemPrice:(NSString*)str;
+ (NSString *)getItemPrice;
+ (void)setPostage:(NSString*)str;
+ (NSString *)getPostage;
+ (void)setTransaction:(NSString*)str;
+(NSString *)getTransaction;
+ (void)setProductId:(NSString*)str;
+ (NSString *)getProductId;
@end
