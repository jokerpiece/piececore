//
//  linepay_ViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/10.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "linepay_ViewController.h"

@interface linepay_ViewController ()

@end

@implementation linepay_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self item_View];
    // Do any additional setup after loading the view from its nib.
}

-(void)item_View{
    
    //screenサイズの取得
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, 800)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
    [self.view addSubview:self.sv];
    
    
     //商品の名前
    UILabel *item_Name = [[UILabel alloc]
                          initWithFrame:CGRectMake(0,screen.size.height*0.12,screen.size.width,screen.size.height*0.15)];
    item_Name.text = self.item_name;
    item_Name.numberOfLines = 2;
    item_Name.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Name.textColor = [UIColor whiteColor];
    item_Name.backgroundColor = [UIColor blackColor];
    [self.uv addSubview:item_Name];
    
    //SetDataに商品名を渡す
    NSString *str_item_name = item_Name.text;
    NSString *get_item_name = [LinePayData getname:str_item_name];
    NSLog(@"%@",get_item_name);
    
    //商品画像
    UIImageView *item_Image = [[UIImageView alloc] init];
    item_Image = self.item_image;
    [self.uv addSubview:item_Image];
    
    //商品説明
    UILabel *item_Text = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width*0.1, screen.size.height*0.25, screen.size.width*0.8, screen.size.height*1.2)];
    item_Text.text = self.item_text;
    item_Text.numberOfLines = 10;
    item_Text.font = [UIFont fontWithName:@"AppleGothic" size:18];
    item_Text.textColor = [UIColor blackColor];
    [self.uv addSubview:item_Text];
    
    //商品価格
    UILabel *item_Price_1 = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width*0.1, screen.size.height*0.65, screen.size.width*0.8, screen.size.height*0.74)];
    item_Price_1.text = @"販売価格(税込)";
    item_Price_1.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Price_1.textColor = [UIColor blackColor];
    [self.uv addSubview:item_Price_1];
    
    UILabel *item_Price_2 = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width*0.6, screen.size.height*0.64, screen.size.width*0.8, screen.size.height*0.74)];
    item_Price_2.text = self.item_price;
    item_Price_2.font = [UIFont fontWithName:@"Arial-BoldMT" size:28];
    item_Price_2.textColor = [UIColor blackColor];
    [self.uv addSubview:item_Price_2];
    
    //Setdataクラスに商品価格を渡す
    NSString *str_item_price = item_Price_2.text;
    NSString *get_item_price = [LinePayData getprice:str_item_price];
    NSLog(@"%@",get_item_price);
    
    UILabel *item_Price_3 = [[UILabel alloc] initWithFrame:CGRectMake(screen.size.width*0.85, screen.size.height*0.65, screen.size.width*0.82, screen.size.height*0.74)];
    item_Price_3.text = @"円";
    item_Price_3.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Price_3.textColor = [UIColor blackColor];
    [self.uv addSubview:item_Price_3];
    
    //Lineで購入ボタン生成
    self.line_button = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width*0.25, screen.size.height*1.1, screen.size.width*0.5, screen.size.height*0.1)];
    [self.line_button setTitle:@"LINEで購入" forState:UIControlStateNormal];
    [self.line_button addTarget:self
                         action:@selector(line_button_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.line_button.backgroundColor = [UIColor greenColor];
    [self.uv addSubview:self.line_button];
}

-(void)line_button_Tapeped:(id)sender
{
    self.app_url = @"piece:";
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
    [param setValue:self.item_name forKeyPath:@"productName"];
    [param setValue:self.img_url forKeyPath:@"productImageUrl"];
    [param setValue:self.item_price forKeyPath:@"amount"];
    [param setValue:self.app_url forKeyPath:@"confirmUrl"];
    [conecter sendActionSendId:SendIdLinePay param:param];
    
    [self addrell_select];
    
    //    linepayReservSquareViewController *line = [[linepayReservSquareViewController alloc]init];
    //    [self.navigationController pushViewController:line animated:YES];
    //PROFILEに移動
    // [self move_profileView];
}

-(void)addrell_select{
    
    //screenサイズの取得
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen.size.width, screen.size.height*1.0)];
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
    [self.view addSubview:self.sv];
    self.uv.backgroundColor = [UIColor whiteColor];
    
    UILabel *text = [[UILabel alloc]
                          initWithFrame:CGRectMake(0,screen.size.height*0.134,screen.size.width,screen.size.height*0.15)];
    text.text = @" お届け先情報を選択してください";
    text.font = [UIFont fontWithName:@"AppleGothic" size:20];
    text.textColor = [UIColor blackColor];
    text.backgroundColor = [UIColor grayColor];
    [self.uv addSubview:text];
    
    self.button_1 = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width*0.1, screen.size.height*0.4, screen.size.width*0.8, screen.size.height*0.1)];
    [self.button_1 setTitle:@"以前と同じ配送先に送る" forState:UIControlStateNormal];
    [self.button_1 addTarget:self
                         action:@selector(button_1_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.button_1.backgroundColor = [UIColor colorWithRed:0.098f green:0.666f blue:0.352f alpha:1.000f];
    [self.uv addSubview:self.button_1];
    
    self.button_2 = [[UIButton alloc] initWithFrame:CGRectMake(screen.size.width*0.1, screen.size.height*0.65, screen.size.width*0.8, screen.size.height*0.1)];
    [self.button_2 setTitle:@"配送先を変更する" forState:UIControlStateNormal];
    [self.button_2 addTarget:self
                         action:@selector(button_2_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.button_2.backgroundColor = [UIColor colorWithRed:0.098f green:0.666f blue:0.352f alpha:1.000f];
    [self.uv addSubview:self.button_2];
    
}

-(void)button_1_Tapeped:(id)sender
{
 
    //送料取得
    self.postage = self.linepeyrecipent.postage;
    NSString *str_postage = self.postage;
    NSString *get_postage= [LinePayData getpostage:str_postage];
    NSLog(@"%@", get_postage);
    
    //LinePay取引番号取得
    self.transaction = self.linepeyrecipent.transaction;
    NSString *str_transaction = self.transaction;
    NSString *get_transaction = [LinePayData gettransaction:str_transaction];
    NSLog(@"%@", get_transaction);
    
    
    //Lineに移動
    self.string = self.linepeyrecipent.paymentUrl;
    NSURL *url = [NSURL URLWithString:self.string];
//    [[UIApplication sharedApplication] openURL:url];

    linepayReservSquareViewController *line = [[linepayReservSquareViewController alloc] initWithNibName:@"linepayReservSquareViewController" bundle:nil];
    
    [self.navigationController pushViewController:line animated:YES];

    
    BOOL installed = [[UIApplication sharedApplication] canOpenURL:url];
    
    if(installed) {
        [[UIApplication sharedApplication] canOpenURL:url];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"エラー"
                                                        message:@"iPhone上にLINEがありません。　　　インストールしますか？"
                                                       delegate:self
                                              cancelButtonTitle:@"キャンセル"
                                              otherButtonTitles:@"インストール", nil];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *line_Url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443904275&mt=8";
        NSURL *url = [NSURL URLWithString:line_Url];
        [[UIApplication sharedApplication] openURL:url];
    }
}




-(void)button_2_Tapeped:(id)sender
{
    [self move_profileView];
}

-(void)move_profileView{
    //PROFILE画面に移動
    ProfileViewController *vc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:nil];
    NSMutableArray *cell_st = [NSMutableArray array];
    [cell_st addObject:[ProfileNameTableViewCell alloc]];
    [cell_st addObject:[ProfileAdressTableViewCell alloc]];
    [cell_st addObject:[ProfileBirthdayTableViewCell alloc]];
    [cell_st addObject:[ProfileAnniversaryTableViewCell alloc]];
    [cell_st addObject:[ProfileSendBtnTableViewCell alloc]];
    vc.cellList = cell_st;
    [self.navigationController pushViewController:vc animated:YES];

}

-(void)move_linepayView{
    
}

-(void)setDataWithRecipient:(LinepayRecipient *)recipient sendId:(NSString *)sendId
{
    self.linepeyrecipent = recipient;
    
    NSLog(@"%@", self.linepeyrecipent.paymentUrl);
//    [[UIApplication sharedApplication] openURL:self.linepeyrecipent.paymentUrl];
}

-(BaseRecipient *)getDataWithSendId:(NSString *)sentId{
    return [LinepayRecipient alloc];
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

