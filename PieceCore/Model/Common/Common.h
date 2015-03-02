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
+(SettingData *)getSettingModel;
+(void)saveSettingModel:(SettingData*)settingModel;
@end
