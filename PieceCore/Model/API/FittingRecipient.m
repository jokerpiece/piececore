//
//  FittingData.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "FittingRecipient.h"

@implementation FittingRecipient
-(void)setData{
    self.data = [self setChildData:self.resultset];
}

-(FittingData *)setChildData:(NSDictionary *)dec{
    FittingData *data = [[FittingData alloc]init];
    data.question_id = [dec valueForKey:@"question_id"];
    data.img_url1 = [dec valueForKey:@"img_url1"];
    data.img_url2 = [dec valueForKey:@"img_url2"];
    data.text = [dec valueForKey:@"text"];
    data.item_url = [dec valueForKey:@"item_url"];
    return data;
}
@end
