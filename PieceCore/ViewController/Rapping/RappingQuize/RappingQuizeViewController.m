//
//  RappingQuizeViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/16.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingQuizeViewController.h"
#import "RappingQuizeRecipient.h"

@interface RappingQuizeViewController ()
@property (nonatomic) RappingQuizeRecipient *rappingRecipient;
@end

@implementation RappingQuizeViewController

-(void)sendGetQuizeData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.orderId forKey:@"order_id"];
    [conecter sendActionSendId:SendIdGetQuizedata param:param];
}

-(RappingQuizeRecipient *)getDataWithSendId:(NSString *)sendId{
    return [RappingQuizeRecipient alloc];
}

-(void)setTestData{
    BaseRecipient *recipient = [BaseRecipient alloc];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"00" forKey:@"status_code"];
    [dic setObject:@"" forKey:@"error_msg"];
    [dic setObject:@"3" forKey:@"type_code"];
    [dic setObject:@"3" forKey:@"type_code"];
    [dic setObject:@"3" forKey:@"type_code"];
    [dic setObject:@"3" forKey:@"type_code"];
    [dic setObject:@"お誕生日おめでとう！" forKey:@"file_data"];
    recipient.resultset = dic;
    [self setDataWithRecipient:recipient sendId:SendIdGetPlaydata];
}

-(void)setDataWithRecipient:(RappingQuizeRecipient *)recipient sendId:(NSString *)sendId{
    self.rappingRecipient = recipient;
    [self.table reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"CreateCell%ld",(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    //if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    NSString *answer = [self.rappingRecipient.answerList objectAtIndex:indexPath.row];
    
    
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
        return self.rappingRecipient.answerList.count;
    } else {
        return 0;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
