//
//  StampConnector.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/11.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "StampRecipient.h"

@implementation StampRecipient
-(void)setData{
    self.start_date = [self.resultset valueForKey:@"start_date"];
    self.end_date = [self.resultset valueForKey:@"end_date"];
    self.stamp_id = [self.resultset valueForKey:@"stamp_id"];
    self.get_point = [self.resultset valueForKey:@"get_point"];
    self.total_point = [self.resultset valueForKey:@"total_point"];
    self.title = [self.resultset valueForKey:@"title"];
    self.message = [self.resultset valueForKey:@"message"];
    if ([self.resultset valueForKey:@"regist_date_list"] != nil) {
        self.regist_date_list = [self.resultset valueForKey:@"regist_date_list"];
    }
    
}
@end
