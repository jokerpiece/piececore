//
//  YoutubeData.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "YoutubeData.h"
static NSString *_token;
static NSString *_update_token;
static NSString *_order_num;
static NSString *_scheme_str_flg;
static NSString *_type;
@implementation YoutubeData

-(id)init
{
    if(self = [super init]){
    }
    return self;
}


+ (void)setToken:(NSString*)str{
    _token = str;
}


+ (NSString *)getToken
{
    
    return _token;
    
}

+ (void)setUpdateToken:(NSString*)str{
    _update_token = str;
}


+ (NSString *)getUpdateToken
{
    
    return _update_token;
    
}


+ (void)setSchemeStrFlg:(NSString*)str{
    _scheme_str_flg = str;
}


+ (NSString *)getSchemeStrFlg
{
    
    return _scheme_str_flg;
    
}

+ (void)setOrderNum:(NSString *)str{
    _order_num = str;
}

+ (NSString *)getOrderNum
{
    
    return _order_num;
    
}

+ (void)setType:(NSString *)str{
    _type = str;
}

+ (NSString *)getType
{
    
    return _type;
    
}



@end
