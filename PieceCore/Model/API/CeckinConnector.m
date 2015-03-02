//
//  CeckinData.m
//  piece
//
//  Created by ハマモト  on 2014/11/18.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "CeckinConnector.h"

@implementation CeckinConnector
-(void)setData{
    self.get_point = [[self.resultset valueForKey:@"get_point"] stringValue];
}
@end
