//
//  CategoryListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/12.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryRecipient.h"

@implementation CategoryRecipient
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"categoryLists"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
}

-(CategoryData *)setChildData:(NSDictionary *)dec{
    CategoryData *data = [CategoryData alloc];
    
    data.img_url = [dec valueForKey:@"img_url"];
    if (data.img_url.length == 0) {
        data.img_url = @"";
    }
    data.category_id = [dec valueForKey:@"category_id"];
    data.shop_category_url = [dec valueForKey:@"shop_url"];
    data.category_name = [dec valueForKey:@"title"];
    data.category_text = [dec valueForKey:@"category_text"];
    return data;
}
@end
