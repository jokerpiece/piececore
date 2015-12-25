//
//  ModalWebViewViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/12/25.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "ModalWebViewViewController.h"

@interface ModalWebViewViewController ()

@end

@implementation ModalWebViewViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"ModalWebViewViewController" owner:self options:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
