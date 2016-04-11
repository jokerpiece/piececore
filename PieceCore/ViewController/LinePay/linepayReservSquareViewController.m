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
    
    //setdataの値を取得(商品名、商品単価の価格、送料、合計金額、注文個数)
    NSString *get_item_name = [LinePayData getItemName];
    self.item_name.text = get_item_name;
    
    NSString *get_postage = [LinePayData getPostage];
    self.postage.text = get_postage;

    //合計金額 + 手数料
    int fee = [[LinePayData getFee] intValue];
    int SettlementAmount = [LinePayData getTootalPrice].intValue + fee;
    
    // Formatterの設定
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    // Formatterの変換
    
    self.item_price.text = [NSString stringWithFormat:@"%@ 円 * %@ 個 = %d",
                            [LinePayData getItemPrice],[LinePayData getItemNumber],
                            ([LinePayData getItemPrice].intValue*[LinePayData getItemNumber].intValue)];
    
    self.amount.text = [NSString stringWithFormat:@"%d", SettlementAmount];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *profileDec = [ud dictionaryForKey:@"PROFILE"];
    self.address.text = [NSString stringWithFormat:@"%@%@%@",[profileDec objectForKey:@"ADDRESS1"],[profileDec objectForKey:@"ADDRESS2"],[profileDec objectForKey:@"ADDRESS3"]];
    self.user_name.text = [NSString stringWithFormat:@"%@ %@",[profileDec objectForKey:@"SEI"],[profileDec objectForKey:@"MEI"]];
    self.mail_address.text = [profileDec objectForKey:@"MAILADDRESS"];
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
//        UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注文確定"
//                                                        message:@"購入ありがとうございます"
//                                                        delegate:self
//                                                cancelButtonTitle:nil
//                                                otherButtonTitles:@"OK", nil];
//        [alert show];
//        [self close];
        [self payedView];
    }
}

- (IBAction)reserv:(id)sender {
//    テスト
//    [self payedView];return;
    
     //LINEPay決済送信、アプリ内決済登録
    NSString *str = [LinePayData getItemNumber];
    DLog(@"%@",str);
    
    NSString *get_transaction = [LinePayData getTransaction];
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:get_transaction forKey:@"transaction"];
    [param setValue:[LinePayData getTootalPrice] forKey:@"amount"];
    [param setValue:@"JPY" forKey:@"currency"];
    [param setValue:[LinePayData getOrderId] forKey:@"orderId"];
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
    [param setValue:[LinePayData getItemNumber] forKey:@"amount"];
    
    //手数料チェック
    if([Common isNotEmptyString:[LinePayData getFee]]){
        [LinePayData setFee:@"0"];
    }
    [param setValue:@"0"forKey:@"fee"];
    
    [param setValue:@"1" forKey:@"payment_kbn"];
//    [param setValue:[profileDec objectForKey:@"USER_ID"] forKey:@"user_id"];
    //デバッグ用user_id
    [param setValue:@"sample" forKey:@"user_id"];
    [param setValue:[profileDec objectForKey:@"MAILADDRESS"] forKey:@"mail_address"];
    [param setValue:[profileDec objectForKey:@"SEI"] forKey:@"sei"];
    [param setValue:[profileDec objectForKey:@"MEI"] forKey:@"mei"];
    [param setValue:[profileDec objectForKey:@"POST"] forKey:@"post"];
    [param setValue:[profileDec objectForKey:@"ADDRESS1"] forKey:@"address_tdfk"];
    [param setValue:[profileDec objectForKey:@"ADDRESS2"] forKey:@"address_city"];
    [param setValue:[profileDec objectForKey:@"ADDRESS3"] forKey:@"address_street"];
    [param setValue:[profileDec objectForKey:@"TEL"] forKey:@"tel"];
    [param setValue:[profileDec objectForKey:@"delivery_time"] forKey:@"delivery_time"];
    [param setValue:[LinePayData getPostage] forKey:@"delivery_price"];
    
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

-(void)payedView{
    CGRect rect = [UIScreen mainScreen].bounds;
    rect.origin.x = rect.size.width;
    UIView *view = [[UIView alloc]initWithFrame:rect];
    view.backgroundColor = [UIColor whiteColor];
    rect.origin.x = 0;
    
    UIImageView *IV = [[UIImageView alloc]initWithFrame:rect];
    IV.image  = [UIImage imageNamed:@"illust1344"];
    IV.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:IV];
    
    UILabel *lbl = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 260, 200)];
    lbl.center = self.view.center;
    [lbl setText:@"ご購入ありがとうございました。\nタップで画面を閉じます。\n引き続きお買い物をお楽しみください。"];
    lbl.numberOfLines = 0;
    [view addSubview:lbl];
    
    [self.view addSubview:view];
    [UIView animateWithDuration:0.3f animations:^{
        view.frame = rect;
    } completion:nil];
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)];
    [view addGestureRecognizer:ges];
}
@end
