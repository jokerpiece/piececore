//
//  DeterminedLinePayRecipient.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/31.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "DeterminedLinePayRecipient.h"

@implementation DeterminedLinePayRecipient

-(void)setData{
    self.transaction = [self.transaction valueForKey:@"transaction"];
    self.amount = [self.transaction valueForKey:@"amount"];
}

@end
