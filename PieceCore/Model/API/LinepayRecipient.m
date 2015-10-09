//
//  LinepayRecipient.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "LinepayRecipient.h"

//@interface LinepayRecipient ()
//
//@end

@implementation LinepayRecipient
-(void)setData{
    self.productName = [self.resultset valueForKey:@"productName"];
    self.productImageUrl = [self.resultset valueForKey:@"productImageUrl"];
    self.amount = [self.resultset valueForKey:@"amount"];
    self.confirmUrl = [self.resultset valueForKey:@"confirmUrl"];
    self.paymentUrl = [self.resultset valueForKey:@"paymentUrl.app"];
    self.paymentUrlWeb = [self.resultset valueForKey:@"paymentUrl.web"];
    self.postage = [self.resultset valueForKey:@"postage"];
    self.transaction = [self.resultset valueForKey:@"transaction"];
}
@end
