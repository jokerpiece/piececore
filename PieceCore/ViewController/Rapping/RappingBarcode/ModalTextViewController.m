//
//  ModalTextViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/12/25.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "ModalTextViewController.h"

@interface ModalTextViewController ()

@end

@implementation ModalTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.lbl.text = self.text;
    [self.lbl sizeToFit];
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
