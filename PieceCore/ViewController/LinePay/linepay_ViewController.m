//
//  linepay_ViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/10.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "linepay_ViewController.h"
#import "LinepaySelectAddressViewController.h"
#import "LinepayProfileViewController.h"

@interface linepay_ViewController ()

@end

@implementation linepay_ViewController

- (void)viewDidLoad {
    self.title = [PieceCoreConfig titleNameData].webViewTitle;
    [super viewDidLoad];
    [self item_View];
    // Do any additional setup after loading the view from its nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.sv.frame = self.view.bounds;
}

-(void)setLinePayData{
    [LinePayData setItemName:self.item_name];
    [LinePayData setItemPrice:self.item_price];
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

    //Lineで購入ボタン生成
    self.line_button = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width*0.25,[Common getOrignYWidhUiView:item_Price_3 margin:30] , self.viewSize.width*0.5, self.viewSize.height*0.1)];
    [self.line_button setTitle:@"LINEで購入" forState:UIControlStateNormal];
    [self.line_button addTarget:self
                         action:@selector(line_button_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.line_button.backgroundColor = [UIColor colorWithRed:0.35 green:0.90 blue:0.16 alpha:1.0];
    
    
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:self.line_button margin:100])];
    
    [self.uv addSubview:lblBg];
    [self.uv addSubview:itemIv];
    [self.uv addSubview:item_Text];
    [self.uv addSubview:item_Price_1];
    [self.uv addSubview:item_Price_2];
    [self.uv addSubview:item_Price_3];
    [self.uv addSubview:self.line_button];
    
    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
    [self.view addSubview:self.sv];
}

-(void)line_button_Tapeped:(id)sender
{
    [self setLinePayData];
    // NSDictionaryの読み込み試験
    NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];

    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    
    if ([Common isNotEmptyString:[profileDec objectForKey:@"SEI"]]
        &&[Common isNotEmptyString:[profileDec objectForKey:@"MEI"]]
           &&[Common isNotEmptyString:[profileDec objectForKey:@"POST"]]
              &&[Common isNotEmptyString:[profileDec objectForKey:@"ADDRESS"]]) {
        
        LinepaySelectAddressViewController *vc = [[LinepaySelectAddressViewController alloc] initWithNibName:@"LinepaySelectAddressViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [self move_profileView];
    }
//    
//    
//    
//    self.app_url = @"piece:";
//    
//    NetworkConecter *conecter = [NetworkConecter alloc];
//    conecter.delegate = self;
//    NSMutableDictionary *param = [NSMutableDictionary dictionary];
//    [param setValue:[Common getUuid] forKeyPath:@"uuid"];
//    [param setValue:self.item_name forKeyPath:@"productName"];
//    [param setValue:self.img_url forKeyPath:@"productImageUrl"];
//    [param setValue:self.item_price forKeyPath:@"amount"];
//    [param setValue:self.app_url forKeyPath:@"confirmUrl"];
//    [conecter sendActionSendId:SendIdLinePay param:param];
//    
//    [self addrell_select];
}

//-(void)addrell_select{
//    
//    
//    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, self.viewSize.height*1.0)];
//    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
//    [self.sv addSubview:self.uv];
//    self.sv.contentSize = self.uv.bounds.size;
//    [self.view addSubview:self.sv];
//    self.uv.backgroundColor = [UIColor whiteColor];
//    
//    UILabel *text = [[UILabel alloc]
//                     initWithFrame:CGRectMake(0,self.viewSize.height*0.134,self.viewSize.width,self.viewSize.height*0.15)];
//    text.text = @" お届け先情報を選択してください";
//    text.font = [UIFont fontWithName:@"AppleGothic" size:20];
//    text.textColor = [UIColor blackColor];
//    text.backgroundColor = [UIColor grayColor];
//    [self.uv addSubview:text];
//    
//    self.button_1 = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, self.viewSize.height*0.4, self.viewSize.width*0.8, self.viewSize.height*0.1)];
//    [self.button_1 setTitle:@"以前と同じ配送先に送る" forState:UIControlStateNormal];
//    [self.button_1 addTarget:self
//                      action:@selector(button_1_Tapeped:)
//            forControlEvents:UIControlEventTouchUpInside];
//    self.button_1.backgroundColor = [UIColor colorWithRed:0.098f green:0.666f blue:0.352f alpha:1.000f];
//    [self.uv addSubview:self.button_1];
//    
//    self.button_2 = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, self.viewSize.height*0.65, self.viewSize.width*0.8, self.viewSize.height*0.1)];
//    [self.button_2 setTitle:@"配送先を変更する" forState:UIControlStateNormal];
//    [self.button_2 addTarget:self
//                      action:@selector(button_2_Tapeped:)
//            forControlEvents:UIControlEventTouchUpInside];
//    self.button_2.backgroundColor = [UIColor colorWithRed:0.098f green:0.666f blue:0.352f alpha:1.000f];
//    [self.uv addSubview:self.button_2];
//    
//}
//
//-(void)button_1_Tapeped:(id)sender
//{
//    
//    //LinePay取引番号取得
////    self.transaction = self.linepeyrecipent.transaction;
//    NSString *str_transaction = self.transaction;
//    
//    
//}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1){
        NSString *line_Url = @"itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=443904275&mt=8";
        NSURL *url = [NSURL URLWithString:line_Url];
        [[UIApplication sharedApplication] openURL:url];
    }
}




//-(void)button_2_Tapeped:(id)sender
//{
//    [self move_profileView];
//}

-(void)move_profileView{
    //PROFILE画面に移動
    LinepayProfileViewController *vc = [[LinepayProfileViewController alloc] initWithNibName:@"LinepayProfileViewController" bundle:nil];
    vc.item_name = self.item_name;
    vc.item_price = self.item_price;
    [LinePayData setProductId:self.productId];
    
    vc.message = @"配送先を入力して下さい。";
//    ProfileViewController *vc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    NSMutableArray *cell_st = [NSMutableArray array];
    [cell_st addObject:[ProfileNameTableViewCell alloc]];
    [cell_st addObject:[ProfileAdressTableViewCell alloc]];
    [cell_st addObject:[ProfileBirthdayTableViewCell alloc]];
    [cell_st addObject:[ProfileAnniversaryTableViewCell alloc]];
    [cell_st addObject:[ProfileSendBtnTableViewCell alloc]];
    vc.cellList = cell_st;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//-(void)move_linepayView{
//    
//}

//-(void)setDataWithRecipient:(LinepayRecipient *)recipient sendId:(NSString *)sendId
//{
////    self.linepeyrecipent = recipient;
////    
////    NSLog(@"%@", self.linepeyrecipent.paymentUrl);
////    //    [[UIApplication sharedApplication] openURL:self.linepeyrecipent.paymentUrl];
//}

//-(BaseRecipient *)getDataWithSendId:(NSString *)sentId{
//    return [LinepayRecipient alloc];
//}



@end

