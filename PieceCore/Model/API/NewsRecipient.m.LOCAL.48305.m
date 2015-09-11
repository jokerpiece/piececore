//
//  NewsData.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NewsRecipient.h"

@implementation NewsRecipient
-(void)setData{
    self.news_id = [self.resultset valueForKey:@"news_id"];
    self.title = [self.resultset valueForKey:@"title"];
    self.text =[self valueForKey:@"text" dec:self.resultset];
    self.image_url = [self.resultset valueForKey:@"img_url"];
    self.link_title = [self.resultset valueForKey:@"link_title"];
    self.link_url = [self.resultset valueForKey:@"link_url"];
    self.link_list = [self.resultset valueForKey:@"link_list"];
}
@end
