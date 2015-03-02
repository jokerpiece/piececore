//
//  SexViewController.m
//  piece
//
//  Created by ハマモト  on 2014/10/15.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "SexViewController.h"

@interface SexViewController ()

@end

@implementation SexViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"SexViewController" owner:self options:nil];
}

- (IBAction)selectManAction:(id)sender {
    self.setting.sex = @"男性";
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)selectWomanAction:(id)sender {
    self.setting.sex = @"女性";
    [self.navigationController popViewControllerAnimated:YES];
}
@end
