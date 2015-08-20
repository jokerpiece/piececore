//
//  DatePickerViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface DatePickerViewController : UIViewController<UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBtn;
@property (copy, nonatomic) NSString *columnId;
@property (copy, nonatomic) NSString *strDate;
@property (nonatomic,weak) id delegate;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
- (IBAction)doneAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

@end

@protocol DatePickerViewControllerDelegate
- (void)didCommitButtonClicked:(DatePickerViewController *)controller selectDate:(NSString *)selectDate;
- (void)didCancelButtonClicked:(DatePickerViewController *)controller;
@end