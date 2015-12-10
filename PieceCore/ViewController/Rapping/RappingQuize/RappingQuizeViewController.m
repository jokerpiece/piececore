//
//  RappingQuizeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingQuizeViewController.h"
#import "RappingQuizeRecipient.h"
#import "RappingQuizeFinishViewController.h"

@interface RappingQuizeViewController ()
@property (nonatomic) RappingQuizeRecipient *rappingRecipient;

@property (nonatomic) NSString *selectAnswerId;


@end

@implementation RappingQuizeViewController
-(void)viewDidAppearLogic{
    self.table.allowsMultipleSelection = NO;
    self.questionId = @"0";
    [self sendGetQuizeData];
}

-(void)sendGetQuizeData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.orderId forKey:@"order_id"];
    if ([Common isNotEmptyString:self.questionId]) {
        [param setValue:self.questionId forKey:@"question_id"];
    }
    [conecter sendActionSendId:SendIdGetQuizedata param:param];
}

-(RappingQuizeRecipient *)getDataWithSendId:(NSString *)sendId{
    return [RappingQuizeRecipient alloc];
}


-(void)setDataWithRecipient:(RappingQuizeRecipient *)recipient sendId:(NSString *)sendId{
    self.rappingRecipient = recipient;
    
    if ([Common isNotEmptyString:self.rappingRecipient.pinCode]) {
        RappingQuizeFinishViewController * vc = [[RappingQuizeFinishViewController alloc] initWithNibName:@"RappingQuizeFinishViewController" bundle:nil ];
        vc.pinCd = self.rappingRecipient.pinCode;
        [self presentViewController:vc animated:YES completion:nil];
        return;
    }
    
    self.questionNoLbl.text = recipient.questionNum;
    self.questionLbl.text = recipient.questionText;
    
    [self.table reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    
    NSString *answer;
    
    if (indexPath.row == 0) {
        answer = self.rappingRecipient.answer1[@"text"];
    } else if (indexPath.row == 1) {
        answer = self.rappingRecipient.answer2[@"text"];
    } else if (indexPath.row == 2) {
        answer = self.rappingRecipient.answer3[@"text"];
    } else if (indexPath.row == 3) {
        answer = self.rappingRecipient.answer4[@"text"];
    }
    
    
    
    UILabel *textLbl = [[UILabel alloc] initWithFrame:CGRectMake(30,15,self.viewSize.width - 80,40)];
    textLbl.text = answer;
    textLbl.font = [UIFont fontWithName:@"AppleGothic" size:15];
    textLbl.alpha = 1.0f;
    textLbl.backgroundColor = [UIColor clearColor];
    textLbl.numberOfLines = 4;
    [cell.contentView addSubview:textLbl];
    
    //}
    return cell;
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 60.0f;
    } else {
        return 60.0f;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    } else {
        return 0;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    if (indexPath.row == 0) {
        self.selectAnswerId = self.rappingRecipient.answer1[@"id"];
    } else if (indexPath.row == 1) {
        self.selectAnswerId = self.rappingRecipient.answer2[@"id"];
    } else if (indexPath.row == 2) {
        self.selectAnswerId = self.rappingRecipient.answer3[@"id"];
    } else if (indexPath.row == 3) {
        self.selectAnswerId = self.rappingRecipient.answer4[@"id"];
    }

}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 選択がはずれたセルを取得
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // セルのアクセサリを解除する（チェックマークを外す）
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)nextAction:(id)sender {
    if (![self.rappingRecipient.correct isEqualToString:self.selectAnswerId]) {
        [self showAlert:@"間違いです！" message:@"ハズレ"];
    } else {
        
        
        
        
        [self.table deselectRowAtIndexPath:[self.table indexPathForSelectedRow] animated:YES];
        UITableViewCell *cell = [self.table cellForRowAtIndexPath:[self.table indexPathForSelectedRow]];
        // セルのアクセサリを解除する（チェックマークを外す）
        cell.accessoryType = UITableViewCellAccessoryNone;
        self.questionId = self.rappingRecipient.questionId;
        [self sendGetQuizeData];
    }
}
@end
