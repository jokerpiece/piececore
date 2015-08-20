//
//  HistoryTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/16.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderNumLbl;
@property (weak, nonatomic) IBOutlet UILabel *orderDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *itemNamelbl;
@property (weak, nonatomic) IBOutlet UIImageView *itemIv;

@end
