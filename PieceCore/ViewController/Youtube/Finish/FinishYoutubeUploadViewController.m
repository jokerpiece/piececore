//
//  FinishYoutubeUploadViewController.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "FinishYoutubeUploadViewController.h"

@interface FinishYoutubeUploadViewController ()

@end

@implementation FinishYoutubeUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UITapGestureRecognizer *get = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    [self.view addGestureRecognizer:get];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];

    self.navigationItem.leftBarButtonItem = barButton;
//    self.navigationController.navigationBar.topItem.backBarButtonItem = nil;
//    self.navigationItem.backBarButtonItem = nil;
}

-(void)backAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
