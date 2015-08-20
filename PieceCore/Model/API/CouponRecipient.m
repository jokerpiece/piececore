//
//  CouponData.m
//  piece
//
//  Created by ハマモト  on 2014/09/26.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CouponRecipient.h"

@implementation CouponRecipient
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
    CouponData *data = [[CouponData alloc]init];
    data.coupon_id = [dec valueForKey:@"coupon_id"];
    data.title = [dec valueForKey:@"title"];
    data.text = [dec valueForKey:@"text"];
    data.img_url = [dec valueForKey:@"img_url"];
    data.coupon_code = [dec valueForKey:@"coupon_code"];
    data.coupon_url = [dec valueForKey:@"coupon_url"];
    return data;
}
@end
