//
//  SpotListData.m
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SpotConnector.h"

@implementation SpotConnector
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"list"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
}

-(SpotData *)setChildData:(NSDictionary *)dec{
    SpotData *model = [[SpotData alloc]init];
    model.shopId = [dec valueForKey:@"shop_id"];
    model.shopName = [dec valueForKey:@"shop_name"];
    model.lat = [dec valueForKey:@"latitude"];
    model.lon = [dec valueForKey:@"longitude"];
    model.address = [dec valueForKey:@"address"];
    model.distance = [dec valueForKey:@"distance"];
    return model;
}
@end
