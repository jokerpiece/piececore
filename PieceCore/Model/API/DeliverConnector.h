//
//  DeliverConnector.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseConnector.h"
#import "HistoryOrderData.h"

@interface DeliverConnector : BaseConnector
@property (nonatomic,strong) NSMutableArray *historyOrderlist;
@end
