//
//  Common.m
//  piece
//
//  Created by ハマモト  on 2014/09/24.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "Common.h"

@implementation Common
+ (NSString *)getUuid{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuidStr = [defaults stringForKey:@"uuid"];
    
    if ([uuidStr length] == 0) {
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(NULL, uuid);
        CFRelease(uuid);
        [defaults setObject:uuidStr forKey:@"uuid"];
    }

    return uuidStr;
}

+(bool)saveLoginDate{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    // NSDateの保存
    NSDate* date = [NSDate date];
    [defaults setObject:date forKey:@"LOGIN_DATE"];

    return [defaults synchronize];
}

+(NSDate *)loadLoginDate{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSDate* date = [defaults objectForKey:@"LOGIN_DATE"];
    return date;
}

+ (NSDate *)stringToDate:(NSString *)baseString
{
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    // iPhoneの現在の設定に合わせる
    [inputDateFormatter setLocale:[NSLocale currentLocale]];
    [inputDateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSDate *inputDate = [inputDateFormatter dateFromString:baseString];
    return inputDate;
}

+ (NSString*)dateToString:(NSDate *)baseDate formatString:(NSString *)formatString
{
    NSDateFormatter *inputDateFormatter = [[NSDateFormatter alloc] init];
    //24時間表示 & iPhoneの現在の設定に合わせる
    [inputDateFormatter setLocale:[NSLocale currentLocale]];
    [inputDateFormatter setDateFormat:formatString];
    NSString *str = [inputDateFormatter stringFromDate:baseDate];
    return str;
}
+ (NSString*)getMonthStartStrDate
{
    // 月初の日付のNSDateを作成する
    NSDate *today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components
    = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitWeekday
                  fromDate:today];
    components.day = 1;
    NSDate *firstDate = [calendar dateFromComponents:components];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    formatter.dateFormat  = @"yyyy/MM/dd";
    return [formatter stringFromDate:firstDate];
}

+(void)initUserDefaults{
    SettingData *setting = [[SettingData alloc]init];
    setting.sex = @"";
    setting.job = @"";
    setting.birthdayList = [NSMutableArray array];
    setting.kinenbiList = [NSMutableArray array];
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:setting];
    
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];  // 取得
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults setObject:data forKey:@"SETTING"];
    [ud registerDefaults:defaults];
}
+(bool)isNotEmptyString:(NSString *)string{
    if ([string isEqual:[NSNull null]]) {
        return NO;
    } else if (string == nil){
        return NO;
    } else if (string.length == 0) {
        return NO;
    } else {
        return YES;
    }
}

+ (UIImage*)resizeAspectFitWithSize:(UIImage *)srcImg size:(CGSize)size {
    
    CGFloat widthRatio  = size.width  / srcImg.size.width;
    CGFloat heightRatio = size.height / srcImg.size.height;
    CGFloat ratio = (widthRatio < heightRatio) ? widthRatio : heightRatio;
    
    CGSize resizedSize = CGSizeMake(srcImg.size.width*ratio, srcImg.size.height*ratio);
    
    UIGraphicsBeginImageContext(resizedSize);
    [srcImg drawInRect:CGRectMake(0, 0, resizedSize.width, resizedSize.height)];
    UIImage* resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}
@end
