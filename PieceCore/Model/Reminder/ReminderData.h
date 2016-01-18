//
//  ReminderData.h
//  pieceSample
//
//  Created by ハマモト  on 2016/01/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReminderData : NSObject
@property (nonatomic) NSDate *notiflcationDate;
@property (nonatomic) NSString *notiflcationDateName;
@property (nonatomic) bool isFatherDay;
@property (nonatomic) bool isMotherDay;
@property (nonatomic) bool isSeniorDay;
@property (nonatomic) bool isChildDay;
@property (nonatomic) bool isValentine;
-(void)saveDataForNSUserDefaults;
-(ReminderData *)getDataForNSUserDefaults;
@end
