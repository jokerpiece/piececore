//
//  DeliverConnector.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "DeliverRecipient.h"

@implementation DeliverRecipient
-(void)setData{
    //リスト
    self.historyOrderlist = [[NSMutableArray alloc]init];
    NSMutableArray *orderList = [self.resultset objectForKey:@"order_list"];
    if ([orderList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in orderList) {
            [self.historyOrderlist addObject:[self setChildData:dec]];
        }
    } else if (orderList != nil) {
        [self.historyOrderlist addObject:[self setChildData:(NSDictionary *)orderList]];
    }
}

-(HistoryOrderData *)setChildData:(NSDictionary *)dec{
    HistoryOrderData *data = [HistoryOrderData alloc];
    data.historyItemList = [NSMutableArray array];
    
    data.orderNum = [dec valueForKey:@"order_num"];
    data.orderDate = [dec valueForKey:@"order_date"];
    data.totalPrice = [dec valueForKey:@"total_price"];
    
    NSMutableArray *itemList = [dec objectForKey:@"item_list"];
    if ([itemList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in itemList) {
            [data.historyItemList addObject:[self setGrandsonData:dec]];
        }
    } else if (itemList != nil) {
        [self.historyOrderlist addObject:[self setGrandsonData:(NSDictionary *)itemList]];
    }
    return data;
}

-(HistoryItemData *)setGrandsonData:(NSDictionary *)dec{
    HistoryItemData *data = [HistoryItemData alloc];
    
    data.deliverNum = [dec valueForKey:@"deliver_num"];
    NSString *deliverCampany = [dec valueForKey:@"deliver_campany"];
    data.deliverCampany = deliverCampany.intValue;
    data.item_name = [dec valueForKey:@"item_name"];
    data.img_url = [dec valueForKey:@"img_url"];
    return data;
}
@end
