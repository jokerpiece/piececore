//
//  setData.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "LinePayData.h"

static NSString *_itemName;
static NSString *_itemPrice;
static NSString *_postage;
static NSString *_transaction;
static NSString *_productId;
static NSString *_orderId;
static NSString *_itemNumber;
static NSString *_fee;
static NSString *_getTootalPrice;
static NSString *_moveTagName;
static NSString *_kikakuName;


@implementation LinePayData

@synthesize item_name;
@synthesize item_price;

-(id)init
{
    if(self = [super init]){
    }
    return self;
}

+ (void)setOrderId:(NSString*)str{
    _orderId = str;
}

//商品名を格納
+ (NSString *)getOrderId
{
    
    return _orderId;
    
}


+ (void)setItemName:(NSString*)str{
    _itemName = str;
}

//商品名を格納
+ (NSString *)getItemName
{
    
    return _itemName;
    
}

+ (void)setItemPrice:(NSString*)str{
    _itemPrice = str;
}

//商品価格
+(NSString *)getItemPrice
{
    return _itemPrice;
}

+ (void)setPostage:(NSString*)str{
    _postage = str;
}

//商品個数
+ (NSString *)getItemNumber
{
    return _itemNumber;
}

+ (void)setItemNumber:(NSString*)str
{
    _itemNumber = str;
}

//送料
+(NSString *)getPostage{
    return _postage;
}
+ (void)setTransaction:(NSString*)str{
    _transaction = str;
}

//商品価格と送料を合算した金額
+(NSString *)getTootalPrice
{
    return _getTootalPrice;
}
+ (void)setTootalPrice:(NSString *)str
{
    _getTootalPrice = str;
}

//LinePay取引番号
+(NSString *)getTransaction{
    return _transaction;
}

+ (void)setProductId:(NSString*)str{
    _productId = str;
}
+(NSString *)getProductId
{
    return _productId;
}


//手数料
+(void)setFee:(NSString*)str{
    _fee = str;
}
+(NSString *)getFee{
    return _fee;

}

//画面遷移元ViewController
+(void)setMoveTagFlag:(NSString *)str{
     _moveTagName = str;
}
+(NSString *)getMoveTagName{
    return _moveTagName;
}
//規格名称
+(void)setKikakuName:(NSString *)str{
    _kikakuName = str;
}
+(NSString *)getKikakuName{
    return _kikakuName;
}







@end
