//
//  ItemDetailRecipient.m
//  pieceSample
//
//  Created by OhnumaRina on 2016/05/17.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ItemDetailRecipient.h"

@implementation ItemDetailRecipient

-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"detail"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
    
    ItemDetailData *data = [ItemDetailData alloc];
    data.quantity = [self.resultset valueForKey:@"quantity"];
    data.list = [self.resultset valueForKey:@"detail"];
}

-(ItemDetailData *)setChildData:(NSDictionary *)dec{
    ItemDetailData *data = [ItemDetailData alloc];
    data.amount = [dec valueForKey:@"amount"];
    data.item_code = [dec valueForKey:@"item_code"];
    data.kikaku_name = [dec valueForKey:@"kikaku_name"];
    data.price = [dec valueForKey:@"price"];
    
    return data;
}

@end
