//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleNameData.h"

@interface PieceCoreConfig : NSObject
extern NSString * const ServerUrl;
extern NSString * const OsType;
extern NSString * const SendTokenUrl;
extern NSString * const SendIdHome;
extern NSString * const SendIdCategory;
extern NSString * const SendIdItem;
extern NSString * const SendIdItemCoupon;
extern NSString * const SendIdItemBarcode;
extern NSString * const SendIdNewsList;
extern NSString * const SendIdFlyerList;
extern NSString * const SendIdSpotList;
extern NSString * const SendIdCouponGive;
extern NSString * const SendIdCouponTake;
extern NSString * const SendIdCouponExchange;
extern NSString * const SendIdGetCoupon;
extern NSString * const SendIdFitting;
extern NSString * const SendIdNews;
extern NSString * const SendIdGetSurvey;
extern NSString * const SendIdSendSurvey;
extern NSString * const SendIdCheckin;
extern NSString * const SendIdPushNews;
extern NSString * const SendIdStamp;
extern NSString * const SendIdDeliverList;
extern NSString * const SendIdGetProfile;
extern NSString * const SendIdSendProfile;
extern NSString * const SendIdLinePay;
extern NSString * const SendIdDeterminedLinePay;
extern NSString * const SendIdRegistPay;
extern NSString * const SendIdGetOrderId;
extern NSString * const SendIdGetYoutubeToken;
extern NSString * const SendIdPostYoutubeMovie;
extern NSString * const SendIdPostMovieOrMessage;

extern NSString * const UrlYamatoDeliver;
extern NSString * const UrlSagawaDeliver;
extern NSString * const UrlYubinDeliver;

extern const int DispSurveyDate;
extern const float TimeSlidershow;
extern const float NavigationHight;
extern const float TabbarHight;
extern NSString * const nex8Key;


extern NSString * const UrlSchemeHostUploadYoutube;
extern NSString * const UrlSchemeHostPlayYoutube;
extern NSString * const UrlSchemeHostInputMessage;
extern NSString * const UrlSchemeHostShowMessage;

+ (NSNumber *)tabnumberFlyer;
+ (NSNumber *)tabnumberInfo;
+ (NSNumber *)tabnumberCoupon;
+ (NSNumber *)tabnumberShopping;
+ (NSString *)appId;
+ (NSString *)shopId;
+ (NSString *)appKey;
+ (NSNumber *)splashInterval;
+ (NSString *)useCouponNum;
+ (TitleNameData *)titleNameData;
+ (NSString *)nex8Key;
+ (void)setTabnumberFlyer:(NSNumber *)tabnumberFlyer;
+ (void)setTabnumberInfo:(NSNumber *)tabnumberInfo;
+ (void)setTabnumberCoupon:(NSNumber *)tabnumberCoupon;
+ (void)setTabnumberShopping:(NSNumber *)tabnumberShopping;
+ (void)setAppId:(NSString *)appId;
+ (void)setShopId:(NSString *)shopId;
+ (void)setAppKey:(NSString *)appKey;
+ (void)setSplashInterval:(NSNumber *)interval;
+ (void)setTitleNameData:(TitleNameData *)titleNameData;
+ (void)setUseCouponNum:(NSString *)useCouponNum;
+ (void)setNex8Key:(NSString *)nex8Key;

+ (void)setLinePay:(bool)linePay;
+ (bool)isLinePay;

+ (void)setLinePayConfirmUrl:(NSString *)linePayConfirmUrl;
+ (NSString *)linePayConfirmUrl;

+ (void)setCookieDomainName:(NSString *)cookieDomainName;
+ (NSString *)cookieDomainName;
@end
