//
//  ExcengeCouponViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/11.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "CouponViewController.h"

@interface ExcengeCouponViewController : CouponViewController
typedef enum {
    nomal = 0,
    point,
    stamp
} exchangeType;

@property (nonatomic) NSString *stampId;
@property (nonatomic) exchangeType exType;

@end
