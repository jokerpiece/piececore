//
//  SettingViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/09.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "Common.h"
#import "SexViewController.h"
#import "BirthDayViewController.h"
#import "KinenbiViewController.h"
#import "JobViewController.h"
#import "BaseViewController.h"

@interface SettingViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (nonatomic,strong) NSArray * menuList;
@property (nonatomic,strong) SettingData * setting;
@property (weak, nonatomic) IBOutlet UILabel *pointLbl;
@end
