//
//  KinenbiDetailViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "MonthAndDatePickerViewController.h"
#import "SettingData.h"
#import "BaseViewController.h"

@interface KinenbiDetailViewController : BaseViewController<UITextFieldDelegate>
@property (nonatomic,strong) SettingData * setting;
@property (copy, nonatomic) NSString *strDate;
@property (nonatomic,weak) id delegate;
@property (nonatomic) bool isDispDatePicker;
@property (nonatomic, retain) MonthAndDatePickerViewController *datePickerViewController;
@property (weak, nonatomic) IBOutlet UITextField *kinenbiNameTf;
@property (weak, nonatomic) IBOutlet UITextField *kinenbiMonthDayTf;
@property (nonatomic,strong) NSMutableArray * dataList;
- (IBAction)saveAction:(id)sender;
@end
