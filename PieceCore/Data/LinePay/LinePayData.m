//
//  setData.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "LinePayData.h"

static NSString *get_iteme_name;
static NSString *get_iteme_price;
static NSString *get_address;
static NSString *get_sei;
static NSString *get_mei;
static NSString *get_mail;
static NSString *get_postage;
static NSString *get_transaction;
static NSString *get_lineurl;

@implementation LinePayData

@synthesize item_name;
@synthesize item_price;

-(id)init
{
    if(self = [super init]){
    }
    return self;
}

//商品名を格納
+(NSString *)getname:(NSString *)str
{
    if(str != NULL)
    {
        get_iteme_name = str;
        return get_iteme_name;
        
    }else{
        return get_iteme_name;
    }
    
}

//商品価格を格納
+(NSString *)getprice:(NSString *)str
{
    if(str != NULL)
    {
        get_iteme_price = str;
        return get_iteme_price;
    }else{
        return get_iteme_price;
    }
}

//送料
+(NSString *)getpostage:(NSString *)str
{
    if(str != NULL)
    {
        get_postage = str;
        return get_postage;
    }else{
        return get_postage;
    }
}

//LinePay取引番号
+(NSString *)gettransaction:(NSString *)str
{
    if(str != NULL)
    {
        get_transaction = str;
        return get_transaction;
    }else{
        return get_transaction;
    }
}

//LineUrl
+(NSString *)getlineurl:(NSString *)str
{
    if(str != NULL)
    {
        get_lineurl = str;
        return get_lineurl;
    }else{
        return get_lineurl;
    }

}

+(NSString *)getaddress:(NSString *)str
{
    if(str != NULL)
    {
        get_address = str;
        return get_address;
    }else{
        return get_address;
    }
}

+(NSString *)getmail:(NSString *)str
{
    if(str != NULL)
    {
        return 0;
    }else{
        return 0;
    }
}

+(NSString *)getsei:(NSString *)str
{
    return 0;
}

+(NSString *)getmei:(NSString *)str
{
    return 0;
}




@end