//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

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
extern NSString * const SendIdGetCoupon;
extern NSString * const SendIdFitting;
extern NSString * const SendIdNews;
extern NSString * const SendIdGetSurvey;
extern NSString * const SendIdSendSurvey;
extern NSString * const SendIdCheckin;
extern NSString * const SendIdPushNews;
extern const int DispSurveyDate;
extern const float TimeSlidershow;
extern const float NavigationHight;
extern const float TabbarHight;

+ (NSNumber *)tabnumberFlyer;
+ (NSNumber *)tabnumberInfo;
+ (NSNumber *)tabnumberCoupon;
+ (NSNumber *)tabnumberShopping;
+ (NSString *)appId;
+ (NSString *)shopId;
+ (void)setTabnumberFlyer:(NSNumber *)tabnumberFlyer;
+ (void)setTabnumberInfo:(NSNumber *)tabnumberInfo;
+ (void)setTabnumberCoupon:(NSNumber *)tabnumberCoupon;
+ (void)setTabnumberShopping:(NSNumber *)tabnumberShopping;
+ (void)setAppId:(NSString *)appId;
+ (void)setShopId:(NSString *)shopId;
@end
