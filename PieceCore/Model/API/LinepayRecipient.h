//
//  LinepayRecipient.h
//  pieceSample
//
//  Created by ohnuma on 2015/07/17.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface LinepayRecipient : BaseRecipient

@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *productImageUrl;
@property (nonatomic, strong) NSString *amount;
@property (nonatomic, strong) NSURL *confirmUrl;
@property (nonatomic, strong) NSString *paymentUrl;
@property (nonatomic, strong) NSString *paymentUrlWeb;
@property (nonatomic, strong) NSString *postage;
@property (nonatomic, strong) NSString *transaction;

@end
