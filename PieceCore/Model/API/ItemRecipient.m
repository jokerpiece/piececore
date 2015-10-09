//
//  ItemListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/12.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "ItemRecipient.h"

@implementation ItemRecipient
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"itemLists"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
    self.quantity = [self.resultset valueForKey:@"quantity"];
    self.more_flg = CFBooleanGetValue((CFBooleanRef)[self.resultset valueForKey:@"more_flg"]);
}

-(ItemData *)setChildData:(NSDictionary *)dec{
    ItemData *data = [ItemData alloc];
    data.img_url = [dec valueForKey:@"img_url"];
    data.item_name = [dec valueForKey:@"item_name"];
    data.category_id = [dec valueForKey:@"ite_id"];
    data.item_url = [dec valueForKey:@"item_url"];
    data.item_text = [dec valueForKey:@"text"];
    data.item_price = [dec valueForKey:@"price"];
    data.stock = [dec valueForKey:@"stocks"];
    data.item_id = [dec valueForKey:@"item_id"];
    return data;
}
@end
