//
//  JobViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "JobViewController.h"

@interface JobViewController ()

@end

@implementation JobViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"JobViewController" owner:self options:nil];
}

- (IBAction)submit1Action:(id)sender {
    self.setting.job = @"フリーター";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit2Action:(id)sender {
    self.setting.job = @"学生";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit3Action:(id)sender {
    self.setting.job = @"主婦";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit4Action:(id)sender {
    self.setting.job = @"サラリーマン";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit5Action:(id)sender {
    self.setting.job = @"自営業";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)submit6Action:(id)sender {
    self.setting.job = @"その他";
    [self.navigationController popViewControllerAnimated:YES];
}
@end
