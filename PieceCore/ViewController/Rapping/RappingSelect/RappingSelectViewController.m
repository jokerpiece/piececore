//
//  RappingSelectViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingSelectViewController.h"
#import "PlayYoutubeViewController.h"
#import "PlayHologramYoutubeViewController.h"
#import "RappingMessageViewController.h"

@interface RappingSelectViewController ()

@end

@implementation RappingSelectViewController

- (void)viewDidAppearLogic {
    [self setTestMessageDAta];
    
}
-(void)setTestDAta{
    BaseRecipient *recipient = [BaseRecipient alloc];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"00" forKey:@"status_code"];
    [dic setObject:@"" forKey:@"error_msg"];
    [dic setObject:@"1" forKey:@"type_code"];
    [dic setObject:@"8Ro5G0ZXpcA" forKey:@"file_data"];
    recipient.resultset = dic;
    [self setDataWithRecipient:recipient sendId:SendIdGetPlaydata];
}
-(void)setTestMessageDAta{
    BaseRecipient *recipient = [BaseRecipient alloc];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"00" forKey:@"status_code"];
    [dic setObject:@"" forKey:@"error_msg"];
    [dic setObject:@"3" forKey:@"type_code"];
    [dic setObject:@"お誕生日おめでとう！" forKey:@"file_data"];
    recipient.resultset = dic;
    [self setDataWithRecipient:recipient sendId:SendIdGetPlaydata];
}
-(void)sendGetPlayData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.order_id forKey:@"order_id"];
    [conecter sendActionSendId:SendIdGetPlaydata param:param];
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if ([recipient.resultset[@"status_code"] isEqualToString:@"00"]) {
        
        
        
        if ([recipient.resultset[@"type_code"] isEqualToString:@"1"]) {
            //動画
            PlayYoutubeViewController *vc = [[PlayYoutubeViewController alloc]initWithNibName:@"PlayYoutubeViewController" bundle:nil
                                             ];
            vc.youtubeId = recipient.resultset[@"file_data"];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        } else if ([recipient.resultset[@"type_code"] isEqualToString:@"2"]) {
            //ホログラム
            PlayHologramYoutubeViewController *vc = [[PlayHologramYoutubeViewController alloc]initWithNibName:@"PlayHologramYoutubeViewController" bundle:nil];
            vc.youtubeId = recipient.resultset[@"file_data"];
            [self presentViewController:vc animated:YES completion:nil];
            
            
        } else if ([recipient.resultset[@"type_code"] isEqualToString:@"3"]) {
            //メッセージ
            RappingMessageViewController *vc = [[RappingMessageViewController alloc]initWithNibName:@"RappingMessageViewController" bundle:nil];
            vc.message = recipient.resultset[@"file_data"];
            [self presentViewController:vc animated:YES completion:nil];
        }
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
        
        
    }
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [BaseRecipient alloc];
}

@end
