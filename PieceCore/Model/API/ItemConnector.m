//
//  ItemListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/12.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "ItemConnector.h"

@implementation ItemConnector
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
    DLog(@"%@",[self.resultset valueForKey:@"more_flg"]);
    
    self.more_flg = CFBooleanGetValue((CFBooleanRef)[self.resultset valueForKey:@"more_flg"]);
//    if ([(NSNumber *)[self.resultset valueForKey:@"more_flg"] boolValue]) {
//        self.more_flg = NO;
//    } else {
//        self.more_flg = YES;
//    }
}

-(ItemData *)setChildData:(NSDictionary *)dec{
    ItemData *model = [ItemData alloc];
    model.img_url = [dec valueForKey:@"img_url"];
    model.item_name = [dec valueForKey:@"item_name"];
    model.category_id = [dec valueForKey:@"ite_id"];
    model.item_url = [dec valueForKey:@"item_url"];
    model.item_text = [dec valueForKey:@"text"];
    model.item_price = [dec valueForKey:@"price"];
    return model;
}
@end
