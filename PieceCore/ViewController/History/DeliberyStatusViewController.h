//
//  DeliberyStatusViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/20.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "HistoryItemData.h"
#import "DeliveryInfoData.h"
#import "BaseViewController.h"


@interface DeliberyStatusViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *statusLbl;
@property (weak, nonatomic) IBOutlet UILabel *messageLbl;
@property (nonatomic) deliverStatus delicerStatus;
@property (strong, nonatomic) NSMutableArray *deliveryInfoList;

@end
