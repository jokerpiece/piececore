//
//  LinepayProfileViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/10/02.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "LinepayProfileViewController.h"
#import "LinepayRecipient.h"

@interface LinepayProfileViewController ()
@property (nonatomic) LinepayRecipient *linepayRecipient;
@property (nonatomic) NSString *orderId;
@end

@implementation LinepayProfileViewController

-(void)nextView{
    [self saveProfileDec];
    

}
-(void)checkLineInstall{

    NSURL *url = [NSURL URLWithString:@"line://"];
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:url];

    if(installed) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.linepayRecipient.paymentUrlWeb]];
        //テスト用
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:[PieceCoreConfig linePayConfirmUrl]]];
        
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"iPhone上にLINEがありません。\nインストールしますか？"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"インストール", nil];
        alert.tag = 1;
        [alert show];
    }
}
-(void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 1 && buttonIndex == 1) {
        [self launchUrl:@"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443904275&mt=8"];
    } else {
        [self nextView];
    }
    
}
-(void)sendLinpeyConfirm{
    //linepay_ViewController *vc = [[linepay_ViewController alloc]init];
    NetworkConecter *conecter_2 = [NetworkConecter alloc];
    conecter_2.delegate = self;
    NSMutableDictionary *param_2 = [NSMutableDictionary dictionary];
    [param_2 setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param_2 setValue:self.orderId forKeyPath:@"orderId"];
    [param_2 setValue:self.item_name forKeyPath:@"productName"];
    [param_2 setValue:self.img_url forKeyPath:@"productImageUrl"];
    [param_2 setValue:self.item_price forKeyPath:@"amount"];
    [param_2 setValue:@"JPY" forKeyPath:@"currency"];
    [param_2 setValue:[PieceCoreConfig linePayConfirmUrl] forKeyPath:@"confirmUrl"];
    [conecter_2 sendActionSendId:SendIdLinePay param:param_2];
    
    
}
-(void)sendGetOrderId{
    //linepay_ViewController *vc = [[linepay_ViewController alloc]init];
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [conecter sendActionSendId:SendIdGetOrderId param:param];
    
    
}

-(void)setDataWithRecipient:(BaseRecipient *)recipient sendId:(NSString *)sendId{
    if ([sendId isEqualToString:SendIdGetProfile]) {
        self.profileRecipient = (ProfileRecipient *)recipient;
        [self.table reloadData];
        [self loadProfileDec];
    } else if ([sendId isEqualToString:SendIdSendProfile]){
        [self sendGetOrderId];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:@"プロフィール情報を更新しました。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        alert.tag = 0;
        [alert show];
        
        
    } else if ([sendId isEqualToString:SendIdGetOrderId]){
        self.orderId = recipient.resultset[@"order_no"];
        [self sendLinpeyConfirm];
        
    } else if ([sendId isEqualToString:SendIdLinePay]){
        self.linepayRecipient = (LinepayRecipient *)recipient;
        [LinePayData setOrderId:self.orderId];
        [LinePayData setTransaction:self.linepayRecipient.transaction];
        [LinePayData setPostage:self.linepayRecipient.postage];
        [self checkLineInstall];

    }
    
}
-(BaseRecipient *)getDataWithSendId:(NSString *)sentId{
    if ([sentId isEqualToString:SendIdSendProfile]) {
        return [ProfileRecipient alloc];
    } else if ([sentId isEqualToString:SendIdGetProfile]) {
        return [ProfileRecipient alloc];
    } else {
        return [LinepayRecipient alloc];
    }
}

-(void)saveProfileDec
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSMutableDictionary* profileData = [NSMutableDictionary dictionary];
    [profileData setObject:self.profileRecipient.user_id forKey:@"USER_ID"];
    [profileData setValue:self.profileRecipient.password forKey:@"PASSWORD"];
    [profileData setValue:self.profileRecipient.sei forKey:@"SEI"];
    [profileData setValue:self.profileRecipient.mei forKey:@"MEI"];
    [profileData setValue:self.profileRecipient.berth_day forKey:@"BERTH_DAY"];
    [profileData setValue:self.profileRecipient.post forKey:@"POST"];
    [profileData setValue:self.profileRecipient.address1 forKey:@"ADRESS1"];
    [profileData setValue:self.profileRecipient.address2 forKey:@"ADRESS2"];
    [profileData setValue:self.profileRecipient.address3 forKey:@"ADRESS3"];
    [profileData setValue:self.profileRecipient.sex forKey:@"SEX"];
    [profileData setValue:@"" forKey:@"TEL"];
    [profileData setValue:self.profileRecipient.mail_address forKey:@"MAIL_ADDRESS"];
    [profileData setValue:self.profileRecipient.anniversary_name forKey:@"ANNIVERSARY_NAME"];
    [profileData setValue:self.profileRecipient.anniversary forKey:@"ANNIVERSARY"];
    
    [ud setObject:profileData forKey:@"PROFILE"];
    [ud synchronize];
    
}
-(void)loadProfileDec
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    ProfileRecipient *profileRecipient = [[ProfileRecipient alloc]init];
    profileRecipient.sei =[profileDec objectForKey:@"SEI"];
    profileRecipient.mei =[profileDec objectForKey:@"MEI"];
    profileRecipient.post =[profileDec objectForKey:@"POST"];
    profileRecipient.address1 =[profileDec objectForKey:@"ADRESS1"];
    profileRecipient.address2 =[profileDec objectForKey:@"ADRESS2"];
    profileRecipient.address3 =[profileDec objectForKey:@"ADRESS3"];
    profileRecipient.mail_address =[profileDec objectForKey:@"MAIL_ADDRESS"];
    profileRecipient.sex =[profileDec objectForKey:@"SEX"];
    profileRecipient.tel =@"";
    profileRecipient.berth_day =[profileDec objectForKey:@"BERTH_DAY"];
    
    for (BaseInputCell *cell in self.instanceCellList) {
        [cell setDataWithProfileRecipient:profileRecipient];
    }
    
}

-(void)launchUrl:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    [[UIApplication sharedApplication] openURL:url];
}


@end
