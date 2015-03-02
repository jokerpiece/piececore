//
//  NewsData.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "NewsConnector.h"

@implementation NewsConnector
-(void)setData{
    self.news_id = [self.resultset valueForKey:@"news_id"];
    self.title = [self.resultset valueForKey:@"title"];
    self.text =[self valueForKey:@"text" dec:self.resultset];
}
@end
