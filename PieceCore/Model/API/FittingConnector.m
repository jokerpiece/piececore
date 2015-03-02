//
//  FittingData.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "FittingConnector.h"

@implementation FittingConnector
-(void)setData{
    self.model = [self setChildData:self.resultset];
}

-(FittingData *)setChildData:(NSDictionary *)dec{
    FittingData *model = [[FittingData alloc]init];
    model.question_id = [dec valueForKey:@"question_id"];
    model.img_url1 = [dec valueForKey:@"img_url1"];
    model.img_url2 = [dec valueForKey:@"img_url2"];
    model.text = [dec valueForKey:@"text"];
    model.item_url = [dec valueForKey:@"item_url"];
    return model;
}
@end
