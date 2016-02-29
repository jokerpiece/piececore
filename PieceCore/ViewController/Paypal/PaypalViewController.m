//
//  PaypalViewController.m
//  pieceSample
//
//  Created by uwatoko on 2016/01/06.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "PaypalViewController.h"
#import "PieceCoreConfig.h"
#import "PayPalConfiguration.h"
// Set the environment: 環境設定
// - For live charges, use PayPalEnvironmentProduction (default).　本番
// - To use the PayPal sandbox, use PayPalEnvironmentSandbox.　サンドボックス
// - For testing, use PayPalEnvironmentNoNetwork.　モック

//AppDelegate.m の記述を優先

@interface PaypalViewController ()

@property(nonatomic, strong, readwrite) PayPalConfiguration *payPalConfig;

@end

@implementation PaypalViewController

- (void)viewDidLoad {
    self.title = [PieceCoreConfig titleNameData].webViewTitle;
    [super viewDidLoad];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [self item_View];
    [self paypalSetting];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.sv.frame = self.view.bounds;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)item_View{
    
    UIView *lblBg = [[UIView alloc]initWithFrame:CGRectMake(0,NavigationHight,self.viewSize.width,80)];
    lblBg.backgroundColor = [UIColor blackColor];
    //商品の名前
    UILabel *item_Name = [[UILabel alloc]
                          initWithFrame:CGRectMake(10,0,self.viewSize.width - 20,80)];
    item_Name.text = self.item_name;
    item_Name.numberOfLines = 2;
    item_Name.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Name.textColor = [UIColor whiteColor];
    
    [lblBg addSubview:item_Name];
    
    
    NSURL *imageURL = [NSURL URLWithString:[self.img_url stringByAddingPercentEscapesUsingEncoding:
                                            NSUTF8StringEncoding]];
    
    //商品画像
    UIImageView *itemIv = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewSize.width * 0.5 - 100,NavigationHight + lblBg.frame.size.height + 30,200,200)];
    [itemIv setImageWithURL:imageURL
           placeholderImage:nil
                    options:SDWebImageCacheMemoryOnly
usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //商品説明
    UILabel *item_Text = [[UILabel alloc] init];
    item_Text.text = self.item_text;
    
    CGFloat custamLetterSpacing = 2.0f;
    UIFont *font = [UIFont fontWithName:@"GeezaPro" size:18];
    
    NSDictionary *attributes =@{NSFontAttributeName:font,
                                [NSNumber numberWithFloat:custamLetterSpacing]:NSKernAttributeName};
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:item_Text.text attributes:attributes];
    item_Text.attributedText = attributedText;
    
    CGSize textSize = [item_Text.text
                       boundingRectWithSize:CGSizeMake(self.viewSize.width * 0.8, CGFLOAT_MAX)
                       options:(NSStringDrawingUsesLineFragmentOrigin)
                       attributes:attributes
                       context:nil].size;
    
    item_Text.frame = CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemIv margin:30], self.viewSize.width*0.8, textSize.height);
    item_Text.numberOfLines = 0;
    item_Text.font = [UIFont fontWithName:@"AppleGothic" size:18];
    item_Text.textColor = [UIColor blackColor];
    
    //商品価格
    UILabel *item_Price_1 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:item_Text margin:30], self.viewSize.width*0.8, 30)];
    item_Price_1.text = @"販売価格";
    item_Price_1.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Price_1.textColor = [UIColor blackColor];
    
    UILabel *item_Price_2 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.6, [Common getOrignYWidhUiView:item_Text margin:30], self.viewSize.width*0.8, 30)];
    item_Price_2.text = [Common formatOfCurrencyWithString:self.item_price];
    item_Price_2.font = [UIFont fontWithName:@"Arial-BoldMT" size:28];
    item_Price_2.textColor = [UIColor blackColor];
    
    
    UILabel *item_Price_3 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.85, [Common getOrignYWidhUiView:item_Text margin:30], self.viewSize.width*0.82, 30)];
    item_Price_3.text = @"円";
    item_Price_3.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Price_3.textColor = [UIColor blackColor];
    
    //PayPalで購入ボタン生成
    self.paypal_button = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width / 2 - 75,[Common getOrignYWidhUiView:item_Price_3 margin:30] , 150, 60)];
    [self.paypal_button setImage:[UIImage imageNamed:@"bnr_shop_now_using_150x60"] forState:UIControlStateNormal];
    self.paypal_button.contentMode = UIViewContentModeScaleAspectFit;
    [self.paypal_button addTarget:self
                           action:@selector(line_button_Tapeped:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:self.paypal_button margin:100])];
    
    [self.uv addSubview:lblBg];
    [self.uv addSubview:itemIv];
    [self.uv addSubview:item_Text];
    [self.uv addSubview:item_Price_1];
    [self.uv addSubview:item_Price_2];
    [self.uv addSubview:item_Price_3];
    [self.uv addSubview:self.paypal_button];
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.frame.size;
    [self.view addSubview:self.sv];
}

// ここからpaypal

/**
 * 購入ボタン押された時
 * 支払い情報の設定、paypal画面へ遷移
 */
-(void)line_button_Tapeped:(id)sender{
    if (![AFNetworkReachabilityManager sharedManager].reachable) {
        // 通信不可
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"お知らせ"
                                                        message:@"通信できませんでした。\n電波状態をお確かめ下さい。"
                                                       delegate:nil
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
        
        return;
    }
    /*
     // Remove our last completed payment, just for demo purposes.
     self.resultText = nil;
     
     
     
     // Note: For purposes of illustration, this example shows a payment that includes
     //       both payment details (subtotal, shipping, tax) and multiple items.
     //       You would only specify these if appropriate to your situation.
     //       Otherwise, you can leave payment.items and/or payment.paymentDetails nil,
     //       and simply set payment.amount to your total charge.
     
     // Optional: include multiple items
     PayPalItem *item1 = [PayPalItem itemWithName:@"Old jeans with holes"
     withQuantity:2
     withPrice:[NSDecimalNumber decimalNumberWithString:@"8400"]
     withCurrency:@"JPY"
     withSku:@"Hip-00037"];
     PayPalItem *item2 = [PayPalItem itemWithName:@"Free rainbow patch"
     withQuantity:1
     withPrice:[NSDecimalNumber decimalNumberWithString:@"0"]
     withCurrency:@"JPY"
     withSku:@"Hip-00066"];
     PayPalItem *item3 = [PayPalItem itemWithName:@"Long-sleeve plaid shirt (mustache not included)"
     withQuantity:1
     withPrice:[NSDecimalNumber decimalNumberWithString:@"3700"]
     withCurrency:@"JPY"
     withSku:@"Hip-00291"];
     NSArray *items = @[item1, item2, item3];
     NSDecimalNumber *subtotal = [PayPalItem totalPriceForItems:items];
     
     // Optional: include payment details
     NSDecimalNumber *shipping = [[NSDecimalNumber alloc] initWithString:@"0"];
     NSDecimalNumber *tax = [[NSDecimalNumber alloc] initWithString:@"200"];
     PayPalPaymentDetails *paymentDetails = [PayPalPaymentDetails paymentDetailsWithSubtotal:subtotal
     withShipping:shipping
     withTax:tax];
     
     NSDecimalNumber *total = [[subtotal decimalNumberByAdding:shipping] decimalNumberByAdding:tax];
     
     PayPalPayment *payment = [[PayPalPayment alloc] init];
     payment.amount = total;
     payment.currencyCode = @"JPY";
     payment.shortDescription = @"買う？";
     payment.items = items;  // if not including multiple items, then leave payment.items as nil
     payment.paymentDetails = paymentDetails; // if not including payment details, then leave payment.paymentDetails as nil
     payment.bnCode = @"tetetet";
     
     */
    
    self.payPalConfig.acceptCreditCards = self.acceptCreditCards;
    
    // PayPal支払いの作成
    PayPalPayment *payment = [[PayPalPayment alloc] init];
    
    // 金額、通貨、および説明
    payment.amount = [[NSDecimalNumber alloc] initWithString:self.item_price];
    payment.currencyCode = @"JPY";
    payment.shortDescription = [NSString stringWithFormat:@"%@:%@",self.item_id,self.item_name];
    
    payment.bnCode = [PieceCoreConfig payPalBnCode];
    
    if (!payment.processable) {
        // This particular payment will always be processable. If, for
        // example, the amount was negative or the shortDescription was
        // empty, this payment wouldn't be processable, and you'd want
        // to handle that here.
    }
    
    // Update payPalConfig re accepting credit cards.
    
    
    PayPalPaymentViewController *paymentViewController = [[PayPalPaymentViewController alloc] initWithPayment:payment
                                                                                                configuration:self.payPalConfig
                                                                                                     delegate:self];
    [self presentViewController:paymentViewController animated:YES completion:nil];
}

/**
 * 初期設定
 */
-(void)paypalSetting{
    [PayPalMobile preconnectWithEnvironment:[PieceCoreConfig payPalEnvironment]];
    
    // Set up payPalConfig
    _payPalConfig = [[PayPalConfiguration alloc] init];
    
    _payPalConfig.acceptCreditCards = NO;
    // ユーザーのPayPalアカウントに登録されている配送先住所から選択
    _payPalConfig.payPalShippingAddressOption = PayPalShippingAddressOptionPayPal;
    
    // use default environment, should be Production in real life
    self.environment = [PieceCoreConfig payPalEnvironment];
    
    DLog(@"PayPal iOS SDK version: %@", [PayPalMobile libraryVersion]);
    DLog(@"%@",_payPalConfig);
}

/**
 * 支払いキャンセル時
 */
- (void)payPalPaymentDidCancel:(PayPalPaymentViewController *)paymentViewController {
    DLog(@"PayPal Payment Canceled");
    self.resultText = nil;
    //self.successView.hidden = YES;
    [self closeViewController:NO];
}

/**
 * 支払い完了後
 */
- (void)payPalPaymentViewController:(PayPalPaymentViewController *)paymentViewController didCompletePayment:(PayPalPayment *)completedPayment {
    DLog(@"PayPal Payment Success!");
    self.resultText = [completedPayment description];
    //[self showSuccess];
    
    //    [self sendCompletedPaymentToServer:completedPayment]; // Payment was processed successfully; send to server for verification and fulfillment
    [self closeViewController:YES];
}


/**
 * サーバーに情報を送信
 */
//- (void)sendCompletedPaymentToServer:(PayPalPayment *)completedPayment {
//    // TODO: Send completedPayment.confirmation to server
//    DLog(@"Here is your proof of payment:\n\n%@\n\nSend this to your server for confirmation and fulfillment.", completedPayment);
//    // 確認ディレクトリ全体を送信します
//    NSData *confirmation = [NSJSONSerialization dataWithJSONObject:completedPayment.confirmation
//                                                           options:0
//                                                             error:nil];
//}


-(void)closeViewController:(BOOL)showCompleteDialog{
    [self dismissViewControllerAnimated:YES completion:nil];
    if(showCompleteDialog){
        UIAlertController *alertControler = [UIAlertController alertControllerWithTitle:nil message:@"ご購入ありがとうございます" preferredStyle:UIAlertControllerStyleAlert];
        [alertControler addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if(self.navigationController){
                [self.navigationController popViewControllerAnimated:YES];
            }
        }]];
        
        [self presentViewController:alertControler animated:YES completion:nil];
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
