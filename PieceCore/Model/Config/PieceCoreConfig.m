//
//  PieceCoreConfig.m
//  piece
//
//  Created by ハマモト  on 2015/02/13.
//  Copyright (c) 2015年 ハマモト . All rights reserved.
//

#import "PieceCoreConfig.h"

@implementation PieceCoreConfig
static NSNumber *_tabnumberFlyer = nil;
static NSNumber *_tabnumberInfo = nil;
static NSNumber *_tabnumberCoupon = nil;
static NSNumber *_tabnumberShopping = nil;
static NSString *_appId = @"";
static NSString *_shopId = @"";

NSString * const  ServerUrl= @"http://jokapi.jp/manager/html/xml/";
NSString * const  OsType= @"1";
NSString * const  SendTokenUrl= @"http://jokapi.jp/manager/html/xml/device_token";
NSString * const  SendIdCategory= @"category/";
NSString * const  SendIdItem= @"item/index.php?Action=itemList";
NSString * const  SendIdItemCoupon= @"item/";
NSString * const  SendIdItemBarcode= @"item/index.php?Action=itemListBarcode";
NSString * const  SendIdNewsList= @"news/";
NSString * const  SendIdFlyerList= @"flyer/";
NSString * const  SendIdSpotList= @"spotList/";
NSString * const  SendIdCouponGive= @"coupon/index.php?Action=giveList";
NSString * const  SendIdCouponTake= @"coupon/index.php?Action=takedList";
NSString * const  SendIdGetCoupon= @"coupon/index.php?Action=get";
NSString * const  SendIdFitting= @"fitting";
NSString * const  SendIdNews= @"news/index.php?Action=newsDetail";
NSString * const  SendIdGetSurvey= @"get_survey";
NSString * const  SendIdSendSurvey= @"send_survey";
NSString * const  SendIdCheckin= @"checkin/";
NSString * const  SendIdPushNews= @"news/index.php?Action=newsList";
const int DispSurveyDate = 90;
const float TimeSlidershow = 5.5;
const float NavigationHight = 65;
const float TabbarHight = 49;

+ (void)setTabnumberFlyer:(NSNumber *)tabnumberFlyer {
    _tabnumberFlyer = tabnumberFlyer;
}

+ (NSNumber *)tabnumberFlyer {
    return _tabnumberFlyer;
}

+ (void)setTabnumberInfo:(NSNumber *)tabnumberInfo {
    _tabnumberInfo = tabnumberInfo;
}

+ (NSNumber *)tabnumberInfo {
    return _tabnumberInfo;
}

+ (void)setTabnumberCoupon:(NSNumber *)tabnumberCoupon {
    _tabnumberCoupon = tabnumberCoupon;
}

+ (NSNumber *)tabnumberCoupon {
    return _tabnumberCoupon;
}

+ (void)setTabnumberShopping:(NSNumber *)tabnumberShopping {
    _tabnumberShopping = tabnumberShopping;
}

+ (NSNumber *)tabnumberShopping {
    return _tabnumberShopping;
}

+ (void)setAppId:(NSString *)appId {
    _appId = appId;
}

+ (NSString *)appId {
    return _appId;
}

+ (void)setShopId:(NSString *)shopId {
    _shopId = shopId;
}

+ (NSString *)shopId {
    return _shopId;
}
@end
