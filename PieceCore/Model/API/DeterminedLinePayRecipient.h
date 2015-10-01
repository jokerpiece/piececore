//
//  DeterminedLinePayRecipient.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/31.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface DeterminedLinePayRecipient : BaseRecipient

@property (nonatomic, strong) NSString *transaction;
@property (nonatomic, strong) NSString *amount;

@end
