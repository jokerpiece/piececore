//
//  BirthdayDetailViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "DatePickerViewController.h"
#import "CoreDelegate.h"
#import "SinglePickerViewController.h"
#import "SettingData.h"
#import "KinenbiData.h"

@interface BirthdayDetailViewController : BaseViewController<UITextFieldDelegate>

@property (nonatomic,strong) SettingData * setting;
@property (weak, nonatomic) IBOutlet UITextField *barthdaySyuruiTf;
@property (weak, nonatomic) IBOutlet UITextField *barthdayTf;
@property (nonatomic, retain) DatePickerViewController *datePickerViewController;
@property (nonatomic) bool isDispDatePicker;
@property (nonatomic, retain) SinglePickerViewController *singlePickerViewController;
@property (nonatomic,strong) NSMutableArray * dataList;
- (IBAction)saveAction:(id)sender;

@end
