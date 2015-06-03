//
//  MonthAndDatePickerViewController.h
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "Common.h"

@interface MonthAndDatePickerViewController : UIViewController<UIPickerViewDelegate,UIGestureRecognizerDelegate>
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (copy, nonatomic) NSString *strDate;
@property (nonatomic,weak) id delegate;
@property (strong, nonatomic) NSMutableArray *monthList;
@property (strong, nonatomic) NSMutableArray *dayList;
@property (nonatomic) int initMonth;
@property (nonatomic) int initDay;
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;
@end

@protocol MonthAndDatePickerViewControllerDelegate
- (void)didCommitButtonClicked:(MonthAndDatePickerViewController *)controller selectDate:(NSString *)selectDate;
- (void)didCancelButtonClicked:(MonthAndDatePickerViewController *)controller;
@end