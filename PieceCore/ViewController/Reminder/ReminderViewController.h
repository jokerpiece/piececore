//
//  ReminderViewController.h
//  pieceSample
//
//  Created by ハマモト  on 2016/01/18.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//
#import "BaseViewController.h"
#import "MonthAndDatePickerViewController.h"
#import "ReminderData.h"

@interface ReminderViewController : BaseViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *dateNameTf;
@property (weak, nonatomic) IBOutlet UITextField *dateTf;

@property (weak, nonatomic) IBOutlet UIButton *fatherBtn;
@property (weak, nonatomic) IBOutlet UIButton *motherBtn;
@property (weak, nonatomic) IBOutlet UIButton *silverBtn;
@property (weak, nonatomic) IBOutlet UIButton *childBtn;
@property (weak, nonatomic) IBOutlet UIButton *valentineBtn;
@property (strong, nonatomic) UITextField *activeTf;
@property (nonatomic) ReminderData *reminderData;
@property (nonatomic) bool isDispDatePicker;

@property (nonatomic, retain) MonthAndDatePickerViewController *monthDateViewController;

- (IBAction)onFatherBtn:(id)sender;
- (IBAction)onMotherBtn:(id)sender;
- (IBAction)onSilverBtn:(id)sender;
- (IBAction)onChildBtn:(id)sender;
- (IBAction)onValentineBtn:(id)sender;
- (IBAction)onSaveBtn:(id)sender;
-(void)setReminderNotificate;

@end
