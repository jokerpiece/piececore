//
//  CouponData.m
//  piece
//
//  Created by ハマモト  on 2014/09/26.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CouponConnector.h"

@implementation CouponConnector
-(void)setData{
    //リスト
    self.list = [[NSMutableArray alloc]init];
    NSMutableArray *dataList = [self.resultset objectForKey:@"couponLists"];
    if ([dataList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dec in dataList) {
            [self.list addObject:[self setChildData:dec]];
        }
    } else if (dataList != nil) {
        [self.list addObject:[self setChildData:(NSDictionary *)dataList]];
    }
}

-(CouponData *)setChildData:(NSDictionary *)dec{
    CouponData *model = [[CouponData alloc]init];
    model.coupon_id = [dec valueForKey:@"coupon_id"];
    model.title = [dec valueForKey:@"title"];
    model.text = [dec valueForKey:@"text"];
    model.img_url = [dec valueForKey:@"img_url"];
    model.coupon_code = [[dec valueForKey:@"coupon_cd"] stringValue];
    return model;
}
@end
