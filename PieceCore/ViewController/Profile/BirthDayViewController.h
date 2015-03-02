//
//  BirthDayViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SettingData.h"
#import "KinenbiData.h"
#import "BaseViewController.h"

@interface BirthDayViewController : BaseViewController
@property (nonatomic,strong) SettingData * setting;
@property (nonatomic,strong) NSMutableArray * dataList;
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)addAction:(id)sender;

@end
