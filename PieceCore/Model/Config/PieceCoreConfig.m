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
static NSString *_appId = @"pieceSample";
static NSString *_shopId = @"pieceSample";
static NSString *_appKey = @"jokerpiece_appKey";
static TitleNameData *_titleNameData = nil;
static TitleNameData * _pageCodeData = nil;
static NSNumber *_splashIntarval = nil;
static NSString *_useCouponNum = @"";
static NSString *_nex8Key = @"";
static bool _linePay = NO;
static NSString *_linePayConfirmUrl = @"";
static NSString *_cookieDomainName = @"";

static NSString *_cartUrl = @"";
static bool _dispSearchBar = NO;
static bool _googleAnalitics = NO;

static bool _paypal = NO;

static NSString *_payPalEnvironment = nil;
static NSString *_paypal_bncode = @"";
static NSString *_PayPalEnvironmentProductionClientId = @"YOUR_CLIENT_ID_FOR_PRODUCTION";
static NSString *_PayPalEnvironmentSandboxClientId = @"YOUR_CLIENT_ID_FOR_SANDBOX";

NSString * const  ServerUrl= @"https://jokapi.jp/manager/html/xml/";
//NSString * const  ServerUrl= @"http://192.168.77.200/piece_dev/manager/html/xml/";
NSString * const  OsType= @"1";
NSString * const  SendTokenUrl= @"https://jokapi.jp/manager/html/xml/device_token/";
NSString * const  SendIdLogin= @"login/";
NSString * const  SendIdCategory= @"category/";
NSString * const  SendIdItem= @"item/index.php?Action=itemList";
NSString * const  SendIdItemCoupon= @"item/";
NSString * const  SendIdItemBarcode= @"item/index.php?Action=itemListBarcode";
NSString * const  SendIdNewsList= @"news/";
NSString * const  SendIdFlyerList= @"flyer/";
NSString * const  SendIdSpotList= @"shop/";
NSString * const  SendIdCouponGive= @"coupon/index.php?Action=giveList";
NSString * const  SendIdCouponTake= @"coupon/index.php?Action=takedList";
NSString * const  SendIdCouponExchange= @"coupon_list_exchange/";
NSString * const  SendIdGetCoupon= @"coupon/index.php?Action=get";
NSString * const  SendIdFitting= @"fitting/";
NSString * const  SendIdNews= @"news/index.php?Action=newsDetail";
NSString * const  SendIdGetSurvey= @"get_survey/";
NSString * const  SendIdSendSurvey= @"send_survey/";
NSString * const  SendIdCheckin= @"checkin/";
NSString * const  SendIdPushNews= @"news/index.php?Action=newsList";
NSString * const  SendIdStamp= @"stamp/";
NSString * const  SendIdDeliverList= @"deliver_list/";
NSString * const  SendIdGetDeliveryPrice = @"delivery_price/";
NSString * const  SendIdGetProfile= @"get_profile/";
NSString * const  SendIdSendProfile= @"send_profile/";
NSString * const  SendIdLinePay = @"linepay/index.php?Action=reserve";
NSString * const  SendIdDeterminedLinePay = @"linepay/index.php?Action=confirm";
NSString * const  SendIdRegistPay = @"regist_app_payment/";
NSString * const  SendIdGetOrderId = @"order_id/";
NSString * const  SendIdGetYoutubeToken = @"order/?Action=check";
NSString * const  SendIdPostYoutubeMovie = @"https://www.googleapis.com/upload/youtube/v3/videos?part=snippet,status";
NSString * const  SendIdPostMovieOrMessage = @"order/?Action=upload";
NSString * const  SendIdGetPlaydata = @"order/?Action=getFileData";
NSString * const  SendIdRegistQuestion = @"order/?Action=registQuestion";
NSString * const  SentIdGetItemDetail = @"item_detail/";
NSString * const  SendIdGetQuizedata = @"order/?Action=getQuestion";
NSString * const  SendIdGetLocation = @"order/?Action=getLocation";
NSString * const  SendIdGetCalendarEventList = @"reserve/?Action=eventList";
NSString * const  SendIdPostCalendarReserve = @"reserve/?Action=registReserve";

NSString * const  UrlYamatoDeliver= @"http://jizen.kuronekoyamato.co.jp/jizen/servlet/crjz.b.NQ0010?id=";
NSString * const  UrlSagawaDeliver= @"http://k2k.sagawa-exp.co.jp/p/web/okurijosearch.do?okurijoNo=";
NSString * const  UrlYubinDeliver= @"http://tracking.post.japanpost.jp/service/singleSearch.do?org.apache.struts.taglib.html.TOKEN=&searchKind=S002&locale=ja&SVID=&reqCodeNo1=";

NSString * const  UrlSchemeHostUploadYoutube= @"videoupload";
NSString * const  UrlSchemeHostPlayYoutube= @"videoplay";
NSString * const  UrlSchemeHostInputMessage= @"message";
NSString * const  UrlSchemeHostShowMessage= @"messageshow";
NSString * const  UrlSchemeHostRapping= @"rapping";
NSString * const  UrlSchemeHostQuestion= @"padlock";

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

+ (void)setAppKey:(NSString *)appKey {
    _appKey = appKey;
}

+ (NSString *)appKey {
    return _appKey;
}

+ (void)setTitleNameData:(TitleNameData *)titleNameData {
    _titleNameData = titleNameData;
}

+ (TitleNameData *)titleNameData {
    return _titleNameData;
}

+ (void)setPageCodeData:(TitleNameData *)pageCodeData {
    _pageCodeData = pageCodeData;
}

+ (TitleNameData *)pageCodeData {
    return _pageCodeData;
}

+ (void)setSplashInterval:(NSNumber *)interval{
    _splashIntarval = interval;
}
+ (NSNumber *)splashInterval{
    return _splashIntarval;
}

+ (void)setUseCouponNum:(NSString *)useCouponNum{
    _useCouponNum = useCouponNum;
}
+ (NSString *)useCouponNum{
    return _useCouponNum;
}
+ (void)setNex8Key:(NSString *)nex8Key{
    _nex8Key = nex8Key;
}
+ (NSString *)nex8Key{
    return _nex8Key;
}
+ (void)setLinePay:(bool)linePay{
    _linePay = linePay;
}
+ (bool)isLinePay{
    return _linePay;
}
+ (void)setLinePayConfirmUrl:(NSString *)linePayConfirmUrl{
    _linePayConfirmUrl = linePayConfirmUrl;
}
+ (NSString *)linePayConfirmUrl{
    return _linePayConfirmUrl;
}

+ (void)setCookieDomainName:(NSString *)cookieDomainName{
    _cookieDomainName = cookieDomainName;
}
+ (NSString *)cookieDomainName{
    return _cookieDomainName;
}


+ (void)setCartUrl:(NSString *)cartUrl{
    _cartUrl = cartUrl;
}
+ (NSString *)cartUrl{
    return _cartUrl;
}


+ (void)setDispSearchBar:(bool)searchBar{
    _dispSearchBar = searchBar;

}
+ (bool)isDispSearchBar{
    return _dispSearchBar;
}

+ (void)setGoogleAnalitics:(bool)isGoogleAnalitics{
    _googleAnalitics = isGoogleAnalitics;
    
}
+ (bool)isGoogleAnalitics{
    return _googleAnalitics;
}
+ (void)setPayPal:(bool)payPal{
    _paypal = payPal;
}
+ (bool)isPayPal{
    return _paypal;
}
+ (NSString*)payPalBnCode{
    return _paypal_bncode;
}

+ (void)setPayPalEnvironment:(NSString *)PayPalEnvironment{
    _payPalEnvironment = PayPalEnvironment;
}
+ (NSString *)payPalEnvironment{
    return _payPalEnvironment;
}

+ (void)setPayPalEnvironmentProductionClientId:(NSString *)PayPalEnvironmentProductionClientId{
    _PayPalEnvironmentProductionClientId = PayPalEnvironmentProductionClientId;
}
+ (NSString *)payPalEnvironmentProductionClientId{
    return _PayPalEnvironmentProductionClientId;
}
+ (void)setPayPalEnvironmentSandboxClientId:(NSString *)PayPalEnvironmentSandboxClientId{
    _PayPalEnvironmentSandboxClientId = PayPalEnvironmentSandboxClientId;
}
+ (NSString *)payPalEnvironmentSandboxClientId{
    return _PayPalEnvironmentSandboxClientId;
    
}
@end
