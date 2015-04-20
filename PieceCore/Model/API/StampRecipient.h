//
//  StampConnector.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/11.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "BaseRecipient.h"

@interface StampRecipient : BaseRecipient
@property (nonatomic,strong) NSString *start_date;
@property (nonatomic,strong) NSString *end_date;
@property (nonatomic,strong) NSString *stamp_id;
@property (nonatomic,strong) NSString *get_point;
@property (nonatomic,strong) NSString *total_point;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *message;
@property (nonatomic,strong) NSArray *regist_date_list;
@end
