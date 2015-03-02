//
//  CategoryListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/12.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CategoryConnector.h"

@implementation CategoryConnector
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
    CategoryData *model = [CategoryData alloc];
    
    model.img_url = [dec valueForKey:@"img_url"];
    if (model.img_url.length == 0) {
        model.img_url = @"";
    }
    model.category_id = [dec valueForKey:@"category_id"];
    model.shop_category_url = [dec valueForKey:@"shop_url"];
    model.category_name = [dec valueForKey:@"category_name"];
    model.category_text = [dec valueForKey:@"category_text"];
    return model;
}
@end
