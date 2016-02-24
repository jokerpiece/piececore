//
//  linepayReservSquareViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "linepayReservSquareViewController.h"

@interface linepayReservSquareViewController ()
@property (nonatomic) int payment_price;
@end

@implementation linepayReservSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    DLog(@"%f,%f", screen.size.width, screen.size.height);
    
    
    
    [self setDateValew];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setDateValew {
    //[Setdata setitem];
    self.item_name.numberOfLines = 2;
    self.address.numberOfLines = 3;
    
    //setdataの値を取得(商品名、価格、送料)
    NSString *get_item_name = [LinePayData getItemName];
    self.item_name.text = get_item_name;
    
    NSString *get_item_price = [LinePayData getItemPrice];
    self.item_price.text = get_item_price;
    
    NSString *get_postage = [LinePayData getPostage];
    self.postage.text = get_postage;
    
    //送料計算
    int item_price = [get_item_price stringByReplacingOccurrencesOfString:@"," withString:@""].intValue;
    int postage = get_postage.intValue;
    self.payment_price = item_price + postage;
    NSString *amount_sum_2 = [NSString stringWithFormat:@"%d",self.payment_price];
    self.amount.text = amount_sum_2;
    
    DLog(@"%@",get_item_name);
    DLog(@"%@",get_item_price);
    DLog(@"%@",get_postage);
    DLog(@"%@",amount_sum_2);
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    
    self.address.text = [NSString stringWithFormat:@"%@%@%@",[profileDec objectForKey:@"ADRESS1"],[profileDec objectForKey:@"ADRESS2"],[profileDec objectForKey:@"ADRESS3"]];
    self.user_name.text = [NSString stringWithFormat:@"%@%@",[profileDec objectForKey:@"SEI"],[profileDec objectForKey:@"MEI"]];
    self.mail_address.text = [profileDec objectForKey:@"MAIL_ADDRESS"];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [DeterminedLinePayRecipient alloc];
}

-(void)setDataWithRecipient:(DeterminedLinePayRecipient *)recipient sendId:(NSString *)sendId
{
    if([sendId isEqualToString:SendIdDeterminedLinePay])
    {
        [self sendRegistPayment];
        
//        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注文確定"
//                                                       message:@"購入ありがとうございます"
//                                                      delegate:self
//                                             cancelButtonTitle:nil
//                                             otherButtonTitles:@"OK", nil];
//        [alert show];
        
        
    } else if ([sendId isEqualToString:SendIdRegistPay]){
        [self close];
    }
}

- (IBAction)reserv:(id)sender {
     //LINEPay決済送信、アプリ内決済登録
    NSString *str = nil;
    NSString *get_transaction = [LinePayData getTransaction];
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:get_transaction forKey:@"transaction"];
    [param setValue:self.amount.text forKey:@"amount"];
    [param setValue:@"JPY" forKey:@"currency"];
    [conecter sendActionSendId:SendIdDeterminedLinePay param:param];
}

-(void)sendRegistPayment{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    
    
    [param setValue:[LinePayData getOrderId] forKey:@"order_no"];
    [param setValue:[LinePayData getProductId] forKey:@"product_id"];
    [param setValue:[NSString stringWithFormat:@"%d",self.payment_price] forKey:@"payment_price"];
    [param setValue:[LinePayData getTransaction] forKey:@"trans_no"];
    [param setValue:[LinePayData getItemPrice] forKey:@"item_price"];
    [param setValue:@"1" forKey:@"amount"];
    [param setValue:[LinePayData getPostage] forKey:@"fee"];
    [param setValue:@"1" forKey:@"payment_kbn"];
    [param setValue:[profileDec objectForKey:@"USER_ID"] forKey:@"user_id"];
    [param setValue:[profileDec objectForKey:@"MAIL_ADDRESS"] forKey:@"mail_address"];
    [param setValue:[profileDec objectForKey:@"SEI"] forKey:@"sei"];
    [param setValue:[profileDec objectForKey:@"MEI"] forKey:@"mei"];
    [param setValue:[profileDec objectForKey:@"POST"] forKey:@"post"];
    [param setValue:[profileDec objectForKey:@"ADRESS1"] forKey:@"address_tdfk"];
    [param setValue:[profileDec objectForKey:@"ADRESS2"] forKey:@"address_city"];
    [param setValue:[profileDec objectForKey:@"ADRESS3"] forKey:@"address_street"];
    [param setValue:[profileDec objectForKey:@"TEL"] forKey:@"tel"];
    [conecter sendActionSendId:SendIdRegistPay param:param];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self close];
}

    
- (IBAction)cancel:(id)sender {
    [self close];
    
}
-(void)close{
    [[UIApplication sharedApplication].keyWindow.rootViewController
     dismissViewControllerAnimated:YES completion:nil];
}
@end
