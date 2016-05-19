//
//  linepayReservSquareViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//
#import "ProfileViewController.h"
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
    self.item_name.adjustsFontSizeToFitWidth = YES;
    
    //NSString *get_postage = [LinePayData getPostage];
    //self.postage.text = get_postage;

    //合計金額 + 手数料
    int fee = [[LinePayData getFee] intValue];
    int SettlementAmount = [LinePayData getTootalPrice].intValue + fee;
    
    
    int itemOnlyTootalPrice = [LinePayData getTootalPrice].intValue - [LinePayData getPostage].intValue;
    
 
    // Formatterの設定
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [formatter setGroupingSeparator:@","];
    [formatter setGroupingSize:3];
    
    // Formatterの変換
    NSNumber *punctuationItemPrice = [[NSNumber alloc] initWithInteger:[LinePayData getItemPrice].integerValue];
    NSNumber *punctuationPostage = [[NSNumber alloc] initWithInteger:[LinePayData getPostage].integerValue];
    NSNumber *punctuationTotalPrice = [[NSNumber alloc] initWithInteger:SettlementAmount];
    NSNumber *punctuationItemOnlyPrice = [[NSNumber alloc] initWithInteger:itemOnlyTootalPrice];
    
    
    self.postage.text = [formatter stringFromNumber:punctuationPostage];
    self.postage.adjustsFontSizeToFitWidth = YES;

    
    
    self.item_price.text = [NSString stringWithFormat:@"%@ 円 * %@ 個 = %@",
                            [formatter stringFromNumber:punctuationItemPrice],
                            [LinePayData getItemNumber],
                            [formatter stringFromNumber:punctuationItemOnlyPrice]
                            ];
    self.item_price.adjustsFontSizeToFitWidth = YES;
    
    self.amount.text = [NSString stringWithFormat:@"%@", [formatter stringFromNumber:punctuationTotalPrice]];
    self.amount.adjustsFontSizeToFitWidth = YES;
    
    [LinePayData setTootalPrice:[NSString stringWithFormat:@"%d", SettlementAmount]];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary *profileDec = [ud dictionaryForKey:@"PROFILE"];
    self.address.text = [NSString stringWithFormat:@"%@%@%@",[profileDec objectForKey:@"ADDRESS1"],[profileDec objectForKey:@"ADDRESS2"],[profileDec objectForKey:@"ADDRESS3"]];
    self.address.adjustsFontSizeToFitWidth = YES;
    self.user_name.text = [NSString stringWithFormat:@"%@ %@ 様",[profileDec objectForKey:@"SEI"],[profileDec objectForKey:@"MEI"]];
    self.user_name.adjustsFontSizeToFitWidth = YES;
    self.mail_address.text = [profileDec objectForKey:@"MAILADDRESS"];
    self.mail_address.adjustsFontSizeToFitWidth = YES;
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sendId{
    return [DeterminedLinePayRecipient alloc];
}

-(void)setDataWithRecipient:(DeterminedLinePayRecipient *)recipient sendId:(NSString *)sendId
{
    if([sendId isEqualToString:SendIdDeterminedLinePay])
    {
        [self sendRegistPayment];
    } else if ([sendId isEqualToString:SendIdRegistPay]){
        [self payedView];
    }
}

- (IBAction)reserv:(id)sender {
//    テスト
//    [self payedView];return;
    
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@"決済確認"
                                        message:@"この注文内容で商品を購入します"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               
                               DLog(@"%@",[LinePayData getTootalPrice]);
                               [self loadingView];
                               
                               if([[LinePayData getItemPrice] isEqualToString:@"0"] && [[LinePayData getPostage] isEqualToString:@"0"]){
                                   [self sendRegistPayment];
                               }else{
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
                               
                                                         }];
    
    UIAlertAction * cancelAction =
    [UIAlertAction actionWithTitle:@"キャンセル"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               
                           }];
    
    [ac addAction:okAction];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
}

-(void)sendRegistPayment{
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    
    if([[LinePayData getItemPrice] isEqualToString:@"0"] && [[LinePayData getPostage] isEqualToString:@"0"]){
        [param setValue:@"dummy" forKey:@"trans_no"];
    }else{
        [param setValue:[LinePayData getTransaction] forKey:@"trans_no"];
    }
    
    [param setValue:[LinePayData getOrderId] forKey:@"order_no"];
    [param setValue:[LinePayData getProductId] forKey:@"product_id"];
    [param setValue:[LinePayData getTootalPrice] forKey:@"payment_price"];
    [param setValue:[LinePayData getItemPrice] forKey:@"item_price"];
    [param setValue:[LinePayData getItemNumber] forKey:@"amount"];
    [param setValue:[LinePayData getKikakuName] forKey:@"kikaku_name"];
    
    //手数料チェック
    if([Common isNotEmptyString:[LinePayData getFee]]){
        [LinePayData setFee:@"0"];
    }
    [param setValue:@"0"forKey:@"fee"];
    
    [param setValue:@"1" forKey:@"payment_kbn"];
//    [param setValue:[profileDec objectForKey:@"USER_ID"] forKey:@"user_id"];
    //デバッグ用user_id
    [param setValue:@"sample" forKey:@"user_id"];
    [param setValue:[Common getUuid] forKey:@"uuid"];
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
    UIAlertController * ac =
    [UIAlertController alertControllerWithTitle:@"キャンセル確認"
                                        message:@"注文をキャンセルして商品一覧に戻ります"
                                 preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                               [self close];
                           }];
    
    UIAlertAction * cancelAction =
    [UIAlertAction actionWithTitle:@"キャンセル"
                             style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {
                               
                           }];

    
    [ac addAction:okAction];
    [ac addAction:cancelAction];
    [self presentViewController:ac animated:YES completion:nil];
    
}
-(void)close{
    [[UIApplication sharedApplication].keyWindow.rootViewController
     dismissViewControllerAnimated:YES completion:nil];

    if([self.delegate respondsToSelector:@selector(moveView)]){
        //処理をデリゲートインスタンスに委譲します。
        [self.delegate moveView];
    }
}

-(void)loadingView{
    
    //ローディング画面表示
    UIView *loadingView;
    UIActivityIndicatorView *indicator;
    
    loadingView = [[UIView alloc] initWithFrame:self.view.bounds];
    // 雰囲気出すために背景を黒く半透明する
    loadingView.backgroundColor = [UIColor blackColor];
    loadingView.alpha = 0.5f;
    indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    //グルグル
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    //画面の中心に配置
    [indicator setCenter:CGPointMake(loadingView.bounds.size.width / 2, loadingView.bounds.size.height / 2)];
    //画面に追加
    [loadingView addSubview:indicator];
    [self.view addSubview:loadingView];
    //ぐるぐる開始
    [indicator startAnimating];
    
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
    
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                         action:@selector(close)];
    [view addGestureRecognizer:ges];
}
@end






