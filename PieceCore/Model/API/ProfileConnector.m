//
//  ProfileConnector.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileConnector.h"

@implementation ProfileConnector
-(void)setData{
    self.user_id = [self.resultset valueForKey:@"user_id"];
    self.password = [self.resultset valueForKey:@"password"];
    self.sei = [self.resultset valueForKey:@"sei"];
    self.mei = [self.resultset valueForKey:@"mei"];
    self.berth_day = [self.resultset valueForKey:@"berth_day"];
    self.post = [self.resultset valueForKey:@"post"];
    self.address = [self.resultset valueForKey:@"address"];
    self.sex = [self.resultset valueForKey:@"sex"];
    self.mail_address = [self.resultset valueForKey:@"mail_address"];
    self.tel = [self.resultset valueForKey:@"tel"];
    self.anniversary_name = [self.resultset valueForKey:@"anniversary_name"];
    self.anniversary = [self.resultset valueForKey:@"anniversary"];
}
@end
