//
//  ProfileConnector.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface ProfileRecipient : BaseRecipient
@property (nonatomic,strong) NSString *user_id;
@property (nonatomic,strong) NSString *password;
@property (nonatomic,strong) NSString *sei;
@property (nonatomic,strong) NSString *mei;
@property (nonatomic,strong) NSString *berth_day;
@property (nonatomic,strong) NSString *post;
@property (nonatomic,strong) NSString *address1;
@property (nonatomic,strong) NSString *address2;
@property (nonatomic,strong) NSString *address3;
@property (nonatomic,strong) NSString *sex;
@property (nonatomic,strong) NSString *mail_address;
@property (nonatomic,strong) NSString *tel;
@property (nonatomic,strong) NSString *anniversary_name;
@property (nonatomic,strong) NSString *anniversary;
@end
