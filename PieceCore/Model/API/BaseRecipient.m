//
//  BaseData.m
//  piece
//
//  Created by ハマモト  on 2014/09/11.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseRecipient.h"

@implementation BaseRecipient
-(id)initWithResponseData:(NSDictionary *)resData {
    if (self = [super init]) {
        //self.resultset = [resData valueForKey:@"resultset"];
        self.resultset = resData;
        self.error_code = [self.resultset valueForKey:@"error_code"];
        self.error_message =[self.resultset valueForKey:@"error_message"];
        [self setData];
    }
    
    return self;
}

-(void)setData{
    //オーバーライドして使う
}

-(NSString *)valueForKey:(NSString *)key dec:(NSDictionary *)dec{
    id value = [dec valueForKey:@"text"];
    if ([value isKindOfClass:[NSDictionary class]]) {
        value = @"";
    }
    return value;
}
@end
