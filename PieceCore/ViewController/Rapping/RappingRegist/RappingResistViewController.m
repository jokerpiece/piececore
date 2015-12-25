//
//  RappingResistViewController.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/18.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingResistViewController.h"
#import "FinishYoutubeUploadViewController.h"


@interface RappingResistViewController ()
@property (nonatomic)NSInteger questionNum;
@end

@implementation RappingResistViewController

- (void)viewDidLoadLogic {
    [super viewDidLoadLogic];
    self.questionNum = 1;
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.view addGestureRecognizer:ges];
    [self.scrView setContentSize:CGSizeMake(self.viewSize.width, 568)];
}

-(void)tapAction{
    [self.view endEditing:YES];
    [self.scrView setContentSize:self.scrView.frame.size];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(self.scrView.frame.size.height == self.scrView.contentSize.height){
        CGRect rect = self.scrView.frame;
        rect.size.height += 220;
        [self.scrView setContentSize:rect.size];
        //    rect.origin.y += 100;
        [self.scrView setContentOffset:rect.origin animated:YES];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.questionTxt){
        [self.firstAnswerTxt becomeFirstResponder];
    }
    if(textField == self.firstAnswerTxt){
        [self.secondAnswerTxt becomeFirstResponder];
    }
    if(textField == self.secondAnswerTxt){
        [self.thirdAnswerTxt becomeFirstResponder];
    }
    if(textField == self.thirdAnswerTxt){
        [self.forthAnswerTxt becomeFirstResponder];
    }
    if(textField == self.forthAnswerTxt){
        [self.view endEditing:YES];
    }
    return NO;
}

- (IBAction)selectAction:(UIButton*)btn {
    self.firstAnswerBtn.selected = NO;
    self.secondAnswerBtn.selected = NO;
    self.thirdAnswerBtn.selected = NO;
    self.forthAnswerBtn.selected = NO;
    btn.selected = YES;

}
- (IBAction)registQuestion:(id)sender {
    if(self.questionNum > 4){
        [self showAlert:@"お知らせ" message:@"４問登録されています。"];
        return;
    }
    if(![self textParameterCheck]){
        [self showAlert:@"お知らせ" message:@"全ての欄に入力して下さい。"];
        return;
    }
    NSInteger correct = [self selectBtnCheck];
    if(correct == 0){
        [self showAlert:@"お知らせ" message:@"問題の正解を入力して下さい。"];
        return;
    }
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.orderId forKey:@"order_id"];
    [param setValue:self.questionTxt.text forKey:@"question_text"];
    [param setValue:[NSString stringWithFormat:@"%d",self.questionNum] forKey:@"question_num"];
    [param setValue:self.firstAnswerTxt.text forKey:@"answer_1"];
    [param setValue:self.secondAnswerTxt.text forKey:@"answer_2"];
    [param setValue:self.thirdAnswerTxt.text forKey:@"answer_3"];
    [param setValue:self.forthAnswerTxt.text forKey:@"answer_4"];
    [param setValue:[NSString stringWithFormat:@"%ld",(long)correct] forKey:@"correct"];
    
    
    [conecter sendActionSendId:SendIdRegistQuestion param:param];
    
}

-(BOOL)textParameterCheck{
    BOOL check = YES;
    if(![Common isNotEmptyString:self.questionTxt.text]){
        check = NO;
    }
    if(![Common isNotEmptyString:self.firstAnswerTxt.text]){
        check = NO;
    }
    if(![Common isNotEmptyString:self.secondAnswerTxt.text]){
        check = NO;
    }
    if(![Common isNotEmptyString:self.thirdAnswerTxt.text]){
        check = NO;
    }
    if(![Common isNotEmptyString:self.forthAnswerTxt.text]){
        check = NO;
    }
    return check;
}

-(NSInteger)selectBtnCheck{
    NSInteger check = 0;
    
    if(self.firstAnswerBtn.selected){
        check = 1;
    }
    if(self.secondAnswerBtn.selected){
        check = 2;
    }
    if(self.thirdAnswerBtn.selected){
        check = 3;
    }
    if(self.forthAnswerBtn.selected){
        check = 4;
    }

    return check;
}

- (IBAction)finishRegist:(id)sender {
    if(self.questionNum < 5){
        [self showAlert:@"お知らせ" message:@"４問まで登録してください。"];
        return;
    }
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    [param setValue:self.orderId forKey:@"order_id"];

    [conecter sendActionSendId:SendIdPostMovieOrMessage param:param];
    
}

-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    
    BaseRecipient *recipient = [[BaseRecipient alloc] initWithResponseData:receivedData];
    if (recipient.error_code.intValue != 0) {
        
        return;
    }
    if (recipient.error_message.length > 0) {
        DLog(@"%@",recipient.error_message);
    }
    [self setDataWithRecipient:recipient sendId:sendId];
    
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if([sendId isEqualToString:SendIdRegistQuestion]){
        if([recipient.resultset[@"status_code"] isEqualToString:@"00"]){
            self.questionNum += 1;
            self.questionTxt.text = @"";
            self.firstAnswerTxt.text = @"";
            self.secondAnswerTxt.text = @"";
            self.thirdAnswerTxt.text = @"";
            self.forthAnswerTxt.text = @"";
            if(self.questionNum <= 4){
                [self showAlert:@"お知らせ" message:@"登録しました。４問まで登録してください。"];
            }else{
                [self showAlert:@"お知らせ" message:@"登録しました。終了ボタンを押してください。"];
            }
        }else{
             [self showAlert:@"エラー" message:recipient.resultset[@"error_message"]];
        }
    }else{
        FinishYoutubeUploadViewController *fyu = [[FinishYoutubeUploadViewController alloc]init];
        fyu.whereFrom = @"RappingRegist";
        [self.navigationController pushViewController:fyu animated:YES];
    }
    
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [BaseRecipient alloc];
}

@end
