//
//  SpotListData.m
//  piece
//
//  Created by ハマモト  on 2014/10/07.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SpotRecipient.h"

@implementation SpotRecipient
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"shopLists"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
}

-(SpotData *)setChildData:(NSDictionary *)dec{
    SpotData *data = [[SpotData alloc]init];
    data.shopId = [dec valueForKey:@"shop_id"];
    data.shopName = [dec valueForKey:@"shop_name"];
    data.lat = [dec valueForKey:@"latitude"];
    data.lon = [dec valueForKey:@"longitude"];
    data.address = [dec valueForKey:@"address"];
    data.distance = [dec valueForKey:@"distance"];
    return data;
}
@end
