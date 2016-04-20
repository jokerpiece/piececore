//
//  HomeListData.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "FlyerRecipient.h"

@implementation FlyerRecipient
-(void)setData{
    //リスト
    self.headerList = [[NSMutableArray alloc]init];
    self.bodyList = [[NSMutableArray alloc]init];
    NSDictionary *headerDataList = [self.resultset objectForKey:@"headFlyer"];

    if ([headerDataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in headerDataList) {
            [self.headerList addObject:[self setChildDataHeader:dec]];
        }
    } else if (headerDataList != nil) {
        [self.headerList addObject:[self setChildDataHeader:(NSDictionary *)headerDataList]];
    }
    
    NSDictionary *bodyDataList = [self.resultset objectForKey:@"bodyFlyer"];

    if ([bodyDataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in bodyDataList) {
            [self.bodyList addObject:[self setChildDataBody:dec]];
        }
    } else if (bodyDataList != nil) {
        [self.bodyList addObject:[self setChildDataBody:(NSDictionary *)bodyDataList]];
    }
}

-(FlyerHeaderData *)setChildDataHeader:(NSDictionary *)dec{
    FlyerHeaderData *data = [FlyerHeaderData alloc];
    data.img_url = [dec valueForKey:@"img_url"];
    data.category_id = [dec valueForKey:@"category_id"];
    data.item_url = [dec valueForKey:@"item_url"];
    data.item_id = [dec valueForKey:@"item_id"];
    return data;
}

-(FlyerBodyData *)setChildDataBody:(NSDictionary *)dec{
    FlyerBodyData *data = [FlyerBodyData alloc];
    data.img_url = [dec valueForKey:@"img_url"];
    data.category_id = [dec valueForKey:@"category_id"];
    data.item_url = [dec valueForKey:@"item_url"];
    data.item_id = [dec valueForKey:@"item_id"];
    return data;
}

@end
