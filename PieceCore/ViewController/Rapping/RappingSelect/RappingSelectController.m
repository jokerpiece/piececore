//
//  RappingSelectViewModel.m
//  pieceSample
//
//  Created by ハマモト  on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "RappingSelectController.h"
#import "PieceCoreConfig.h"
#import "NetworkConecter.h"
#import "BaseRecipient.h"
#import "CoreDelegate.h"
#import "PlayYoutubeViewController.h"
#import "PlayHologramYoutubeViewController.h"
#import "RappingMessageViewController.h"

@implementation RappingSelectController

-(void)presentViewWithOrderId:(NSString *)orderId parnentVc:(UIViewController *)parnentVc{
    self.parnentVc = parnentVc;
    self.orderId = orderId;
    [self sendGetPlayData];
}

-(void)sendGetPlayData{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:self.orderId forKey:@"order_id"];
    [conecter sendActionSendId:SendIdGetPlaydata param:param];
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

-(void)receiveError:(NSError *)error sendId:(NSString *)sendId{
    CoreDelegate *delegate = (CoreDelegate *)[[UIApplication sharedApplication] delegate];
    if (!delegate.isUpdate) {
        NSString *errMsg;
        switch (error.code) {
            case NSURLErrorBadServerResponse:
                errMsg = @"現在メンテナンス中です。\n大変申し訳ありませんがしばらくお待ち下さい。";
                break;
            case NSURLErrorTimedOut:
                errMsg = @"通信が混み合っています。\nしばらくしてからアクセスして下さい。";
                break;
                
            case kCFURLErrorNotConnectedToInternet:
                errMsg = @"通信できませんでした。\n電波状態をお確かめ下さい。";
                break;
            default:
                errMsg = [NSString stringWithFormat:@"エラーコード：%ld",(long)error.code];
                break;
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:errMsg
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if ([recipient.resultset[@"status_code"] isEqualToString:@"00"]) {
        
        
        
        if ([recipient.resultset[@"type_code"] isEqualToString:@"1"]) {
            //動画
            PlayYoutubeViewController *vc = [[PlayYoutubeViewController alloc]initWithNibName:@"PlayYoutubeViewController" bundle:nil
                                             ];
            vc.youtubeId = recipient.resultset[@"file_data"];
            [self.parnentVc presentViewController:vc animated:YES completion:nil];
            
            
        } else if ([recipient.resultset[@"type_code"] isEqualToString:@"2"]) {
            //ホログラム
            PlayHologramYoutubeViewController *vc = [[PlayHologramYoutubeViewController alloc]initWithNibName:@"PlayHologramYoutubeViewController" bundle:nil];
            vc.youtubeId = recipient.resultset[@"file_data"];
            [self.parnentVc presentViewController:vc animated:YES completion:nil];
            
            
        } else if ([recipient.resultset[@"type_code"] isEqualToString:@"3"]) {
            //メッセージ
            RappingMessageViewController *vc = [[RappingMessageViewController alloc]initWithNibName:@"RappingMessageViewController" bundle:nil];
            vc.message = recipient.resultset[@"file_data"];
            [self.parnentVc presentViewController:vc animated:YES completion:nil];
        }
        
        
        
    } else {
        [self setTestDAta];
    }
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
-(void)setTestDAta{
    BaseRecipient *recipient = [BaseRecipient alloc];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@"00" forKey:@"status_code"];
    [dic setObject:@"" forKey:@"error_msg"];
    [dic setObject:@"2" forKey:@"type_code"];
    [dic setObject:@"8Ro5G0ZXpcA" forKey:@"file_data"];
    recipient.resultset = dic;
    [self setDataWithRecipient:recipient sendId:SendIdGetPlaydata];
}
@end
