//
//
//  Copyright(c) JokerPiece Co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "SettingData.h"

@interface Common : NSObject
+ (NSString *)getUuid;
+(bool)saveLoginDate;
+(NSDate *)loadLoginDate;
+ (NSDate *)stringToDate:(NSString *)baseString;
+ (NSString *)dateToString:(NSDate *)baseDate formatString:(NSString *)formatString;
+ (NSString*)getMonthStartStrDate;
+(void)initUserDefaults;
+(bool)isNotEmptyString:(NSString *)string;
+ (UIImage*)resizeAspectFitWithSize:(UIImage *)srcImg size:(CGSize)size;
+ (NSString *)formatOfCurrencyWithString:(NSString*)str;
+(float)getOrignYWidhUiView:(UIView *)view margin:(float)magin;
+ (void)setDeviceToken:(NSString *)deviceToken;
+ (NSString *)deviceToken;
+ (NSDictionary*)dictionaryFromQueryString:(NSString *)query;
@end
