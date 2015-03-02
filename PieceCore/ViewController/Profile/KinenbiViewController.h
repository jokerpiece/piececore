//
//  KinenbiViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/10.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SettingData.h"
#import "KinenbiData.h"
#import "BaseViewController.h"

@interface KinenbiViewController : BaseViewController
@property (nonatomic,strong) NSMutableArray * dataList;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) SettingData * setting;
- (IBAction)addAction:(id)sender;
@end
