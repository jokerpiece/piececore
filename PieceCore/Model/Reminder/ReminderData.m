//
//  ReminderData.m
//  pieceSample
//
//  Created by ハマモト  on 2016/01/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ReminderData.h"
#import "Common.h"

@implementation ReminderData

-(void)saveDataForNSUserDefaults
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary* notiflcationData = [NSMutableDictionary dictionary];
    if (self.notiflcationDate != nil) {
        [notiflcationData setObject:self.notiflcationDate forKey:@"NOTIFLCATION_DATE"];
    }
    if ([Common isNotEmptyString:self.notiflcationDateName]) {
        [notiflcationData setValue:self.notiflcationDateName forKey:@"NOTIFLCATION_DATE_NAME"];
    }
    
    
    [notiflcationData setObject:[NSNumber numberWithBool:self.isFatherDay] forKey:@"IS_FATHER"];
    [notiflcationData setObject:[NSNumber numberWithBool:self.isMotherDay] forKey: @"IS_MOTHER"];
    [notiflcationData setObject:[NSNumber numberWithBool:self.isSeniorDay] forKey: @"IS_SENIOR"];
    [notiflcationData setObject:[NSNumber numberWithBool:self.isChildDay] forKey: @"IS_CHILDE"];
    [notiflcationData setObject:[NSNumber numberWithBool:self.isValentine] forKey: @"IS_VALENTINE"];
    [ud setObject:notiflcationData forKey:@"NOTIFLCATION"];
    [ud synchronize];
    
}
-(ReminderData *)getDataForNSUserDefaults
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* notiflcationData = [ud dictionaryForKey:@"NOTIFLCATION"];
    self.notiflcationDate =[notiflcationData objectForKey:@"NOTIFLCATION_DATE"];
    self.notiflcationDateName =[notiflcationData objectForKey:@"NOTIFLCATION_DATE_NAME"];
    self.isFatherDay = [[notiflcationData objectForKey:@"IS_FATHER"]boolValue];
    self.isMotherDay =[[notiflcationData objectForKey:@"IS_MOTHER"]boolValue];
    self.isSeniorDay =[[notiflcationData objectForKey:@"IS_SENIOR"]boolValue];
    self.isChildDay =[[notiflcationData objectForKey:@"IS_CHILDE"]boolValue];
    self.isValentine =[[notiflcationData objectForKey:@"IS_VALENTINE"]boolValue];
    return self;
    
}

@end
