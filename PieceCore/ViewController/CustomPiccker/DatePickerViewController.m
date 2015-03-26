//
//  DatePickerViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/14.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "DatePickerViewController.h"
#import "CoreDelegate.h"

@interface DatePickerViewController ()

@end

@implementation DatePickerViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"DatePickerViewController" owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.strDate.length != 0) {
        self.datePicker.date = [Common stringToDate: self.strDate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)doneAction:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    NSString *dateString = [dateFormatter stringFromDate:self.datePicker.date];
    [self.delegate didCommitButtonClicked:self selectDate:dateString];
}

- (IBAction)cancelAction:(id)sender {
    [self.delegate didCancelButtonClicked:self];
}
@end
