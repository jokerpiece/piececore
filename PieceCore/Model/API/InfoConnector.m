//
//  NewsListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/22.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "InfoConnector.h"

@implementation InfoConnector
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"list"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
//            [self.list addObject:[self setChildData:dec]];
            [self.list insertObject:[self setChildData:dec] atIndex:0];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
}

-(InfoListData *)setChildData:(NSDictionary *)dec{
    InfoListData *model = [[InfoListData alloc]init];
    model.info_id = [dec valueForKey:@"news_id"];
    model.title = [dec valueForKey:@"title"];
    model.type = [dec valueForKey:@"type"];
    model.typeId = [dec valueForKey:@"id"];
    return model;
}
@end
