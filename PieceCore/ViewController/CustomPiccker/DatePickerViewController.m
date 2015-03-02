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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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
