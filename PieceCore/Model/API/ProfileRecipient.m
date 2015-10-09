//
//  ProfileConnector.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileRecipient.h"

@implementation ProfileRecipient
-(void)setData{
    self.user_id = [self.resultset valueForKey:@"user_id"];
    self.password = [self.resultset valueForKey:@"Password"];
    self.sei = [self.resultset valueForKey:@"Sei"];
    self.mei = [self.resultset valueForKey:@"Mei"];
    self.berth_day = [self.resultset valueForKey:@"Birthday"];
    self.post = [self.resultset valueForKey:@"Post"];
    self.address1 = [self.resultset valueForKey:@"Address_tdfk"];
    self.address2 = [self.resultset valueForKey:@"Address_city"];
    self.address3 = [self.resultset valueForKey:@"Address_street"];
    self.sex = [self.resultset valueForKey:@"Sex"];
    self.mail_address = [self.resultset valueForKey:@"mail_address"];
    self.tel = [self.resultset valueForKey:@"Tel"];
    self.anniversary_name = [self.resultset valueForKey:@"anniversary_name"];
    self.anniversary = [self.resultset valueForKey:@"anniversary"];
}
@end
