//
//  FittingViewController.m
//  piece
//
//  Created by ハマモト  on 2014/09/30.
//  Copyright (c) 2014年 ハマモト . All rights reserved.
//

#import "FittingViewController.h"

@interface FittingViewController ()

@end

@implementation FittingViewController

- (void)loadView {
    [[NSBundle mainBundle] loadNibNamed:@"FittingViewController" owner:self options:nil];
}
- (void)viewDidLoadLogic
{
    if (self.title.length < 1) {
        self.title = [PieceCoreConfig titleNameData].fittingTitle;
    }
    self.questionVew.backgroundColor = [UIColor whiteColor];
    self.questionVew.layer.cornerRadius = 20;
    self.questionVew.layer.borderColor = [UIColor blackColor].CGColor;
    self.questionVew.layer.borderWidth = 1;
    
    self.shadowView.backgroundColor = [UIColor clearColor];
    self.shadowView.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.shadowView.layer.shadowOffset = CGSizeMake(1, 1);
    self.shadowView.layer.shadowOpacity = 5.7f;
    self.shadowView.layer.shadowPath = [UIBezierPath bezierPathWithRect:self.shadowView.bounds].CGPath;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppearLogic
{
    self.question_id = @"";
    self.isResponse = NO;
    [self syncAction];
}

- (IBAction)awnser1Action:(id)sender {
    self.answer_num = @"1";
    [self syncAction];
}

- (IBAction)awnser2Action:(id)sender {
    self.answer_num = @"2";
    [self syncAction];
}

-(void)syncAction{
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.question_id forKey:@"question_id"];
    [param setValue:self.answer_num forKey:@"answer_num"];
    [conecter sendActionSendId:SendIdFitting param:param];
    
    
}

-(void)setDataWithRecipient:(FittingRecipient *)recipient sendId:(NSString *)sendId{
    self.fittingRecipient = recipient;
    if (self.fittingRecipient.data.item_url.length > 0) {
        
        WebViewController *vc = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil url:self.fittingRecipient.data.item_url];
        [self presentViewController:vc animated:YES completion:nil];
        
        UIAlertView *alertView = [[UIAlertView alloc] init];
        [alertView setTitle:@"検索結果"];
        [alertView setMessage:@"あなたにオススメの商品はこちらです！"];
        [alertView addButtonWithTitle:@"OK"];
        [alertView show];
    } else {
        self.question_id = self.fittingRecipient.data.question_id;
        self.questionLbl.text = self.fittingRecipient.data.text;
        [self.awnser1Btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.fittingRecipient.data.img_url1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"wait.jpg"]];
        [self.awnser2Btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.fittingRecipient.data.img_url2] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"wait.jpg"]];
        
    }
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [FittingRecipient alloc];
}

@end
