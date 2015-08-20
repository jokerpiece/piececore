//
//  HistoryViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/20.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "BaseViewController.h"
#import "UIImageView+WebCache.h"
#import "HistoryOrderData.h"
#import "UIColor+MLPFlatColors.h"

@interface HistoryViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic)NSMutableArray *historyOrderDataList;
@property (nonatomic)int selectRow;
- (IBAction)toDeliveryAction:(id)sender;

@end
