//
//  OrderDataCheckViewController.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2015/11/11.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "OrderDataCheckViewController.h"
#import "OrderDataFailedViewController.h"
#import "UploadYoutubeViewController.h"



@interface OrderDataCheckViewController ()

@end

@implementation OrderDataCheckViewController

-(void)viewDidLoadLogic{
    [super viewDidLoadLogic];
    [self firstCheckOrder];
}
- (void)viewDidAppearLogic {
    [super viewDidAppearLogic];
    // Do any additional setup after loading the view from its nib.
    [self schemePresentViewController];
}

- (IBAction)sendOrderNumAction:(id)sender {
    if(![Common isNotEmptyString:self.mailAddressTxt.text]){
        [self showAlert:@"エラー" message:@"メールアドレスを入力して下さい"];
    }else if(![Common isNotEmptyString:self.orderNumTxt.text]){
        [self showAlert:@"エラー" message:@"注文番号を入力して下さい"];
    }else{
        [self checkOrder];
        [self schemePresentViewController];
    }
}

-(void)checkOrder{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];

    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param setValue:self.orderNumTxt.text forKey:@"order_num"];
    [param setValue:self.mailAddressTxt.text forKey:@"mail_address"];
    [conecter sendActionSendId:SendIdGetYoutubeToken param:param];
}

-(void)firstCheckOrder{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:@"6AA5E044-E002-4193-A4DB-BE583C501CC4" forKeyPath:@"uuid"];
    [param setValue:@"2321" forKeyPath:@"uuid"];
    [param setValue:@"4" forKey:@"order_num"];
//    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
//    [param setValue:self.order_num forKey:@"order_num"];
    [param setValue:self.mailAddressTxt.text forKey:@"mail_address"];
    [conecter sendActionSendId:SendIdGetYoutubeToken param:param];
}

-(void)receiveSucceed:(NSDictionary *)receivedData sendId:(NSString *)sendId{
    self.isResponse = YES;
    BaseRecipient *recipient = [[self getDataWithSendId:sendId] initWithResponseData:receivedData];
    if([sendId isEqualToString:SendIdGetYoutubeToken]){
        [YoutubeData setToken:[receivedData objectForKey:@"token"]];
        [YoutubeData setOrderNum:[receivedData objectForKey:@"order_num"]];
//        [YoutubeData setOrderId:@"20"];
        self.type = [receivedData objectForKey:@"type_code"];
        if([[receivedData objectForKey:@"status_code"] isEqualToString:@"00"]){
            [YoutubeData setSchemeStrFlg:UrlSchemeHostUploadYoutube];
        }else{
            [YoutubeData setSchemeStrFlg:@"error"];
        }
    }
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return nil;
}


-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{

}

-(void)schemePresentViewController{
    if([[YoutubeData getSchemeStrFlg] isEqualToString:@"error"]){
        OrderDataFailedViewController *odf = [[OrderDataFailedViewController alloc]init];
        [YoutubeData setSchemeStrFlg:@""];
        [self presentViewController:odf animated:YES completion:nil];
        return;
    }
    if([[YoutubeData getSchemeStrFlg] isEqualToString:UrlSchemeHostUploadYoutube]){
        [YoutubeData setSchemeStrFlg:@""];
        UploadYoutubeViewController *uy = [[UploadYoutubeViewController alloc]init];
        if([self.type isEqualToString:@"3"]){
            uy.title = @"message";
        }else{
            uy.title = @"youtube";
        }
        uy.token = [YoutubeData getToken];
        uy.type = self.type;
        [self.navigationController pushViewController:uy animated:YES];
    }
}

@end
