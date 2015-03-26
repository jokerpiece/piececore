//
//  DeliverConnector.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"
#import "HistoryOrderData.h"

@interface DeliverRecipient : BaseRecipient
@property (nonatomic,strong) NSMutableArray *historyOrderlist;
@end
