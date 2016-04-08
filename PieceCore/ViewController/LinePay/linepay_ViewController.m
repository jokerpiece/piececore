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
    [LinePayData setItemName:self.itemName];
    [LinePayData setItemPrice:self.itemPrice];
    [LinePayData setProductId:self.productId];
}
-(void)item_View{

    UIView *lblBg = [[UIView alloc]initWithFrame:CGRectMake(0,NavigationHight,self.viewSize.width,80)];
    lblBg.backgroundColor = [UIColor blackColor];
    //商品の名前
    UILabel *item_Name = [[UILabel alloc]
                          initWithFrame:CGRectMake(10,0,self.viewSize.width - 20,80)];
    item_Name.text = self.itemName;
    item_Name.numberOfLines = 2;
    item_Name.font = [UIFont fontWithName:@"AppleGothic" size:20];
    item_Name.textColor = [UIColor whiteColor];
    
    [lblBg addSubview:item_Name];
    

    NSURL *imageURL = [NSURL URLWithString:[self.imgUrl stringByAddingPercentEscapesUsingEncoding:
                                            NSUTF8StringEncoding]];
    
    //商品画像
    UIImageView *itemIv = [[UIImageView alloc] initWithFrame:CGRectMake(self.viewSize.width * 0.5 - 100,NavigationHight + lblBg.frame.size.height + 30,200,200)];
    [itemIv setImageWithURL:imageURL
           placeholderImage:nil
                    options:SDWebImageCacheMemoryOnly
usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    
    //商品説明
    UILabel *itemTextLbl = [[UILabel alloc] init];
    itemTextLbl.text = self.itemText;
    
    CGFloat custamLetterSpacing = 2.0f;
    UIFont *font = [UIFont fontWithName:@"GeezaPro" size:18];
    
    NSDictionary *attributes =@{NSFontAttributeName:font,
                                [NSNumber numberWithFloat:custamLetterSpacing]:NSKernAttributeName};
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:itemTextLbl.text attributes:attributes];
    itemTextLbl.attributedText = attributedText;
    
    CGSize textSize = [itemTextLbl.text
                       boundingRectWithSize:CGSizeMake(self.viewSize.width * 0.8, CGFLOAT_MAX)
                       options:(NSStringDrawingUsesLineFragmentOrigin)
                       attributes:attributes
                       context:nil].size;
    
    itemTextLbl.frame = CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemIv margin:30], self.viewSize.width*0.8, textSize.height);
    itemTextLbl.numberOfLines = 0;
    itemTextLbl.font = [UIFont fontWithName:@"AppleGothic" size:18];
    itemTextLbl.textColor = [UIColor blackColor];
    
    //商品価格
    UILabel *itemPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemTextLbl margin:30], self.viewSize.width*0.4, 30)];
    itemPrice1.text = @"販売価格";
    itemPrice1.font = [UIFont fontWithName:@"AppleGothic" size:20];
    itemPrice1.textColor = [UIColor blackColor];
    
    UILabel *itemPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.6, [Common getOrignYWidhUiView:itemTextLbl margin:30], self.viewSize.width*0.8, 30)];
    itemPrice2.text = [Common formatOfCurrencyWithString:self.itemPrice];
    itemPrice2.textAlignment = UITextLayoutDirectionRight;
    itemPrice2.font = [UIFont fontWithName:@"Arial-BoldMT" size:28];
    itemPrice2.textColor = [UIColor blackColor];
    [itemPrice2 sizeToFit];
    
    UILabel *itemPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(itemPrice2.frame.origin.x + itemPrice2.frame.size.width + 5, [Common getOrignYWidhUiView:itemTextLbl margin:30], self.viewSize.width*0.82, 30)];
    itemPrice3.text = @"円";
    itemPrice3.font = [UIFont fontWithName:@"AppleGothic" size:20];
    itemPrice3.textColor = [UIColor blackColor];

    //在庫数判定

    UILabel *itemNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
    itemNumber.text = @"注文個数";
    itemNumber.font = [UIFont fontWithName:@"AppleGothic" size:20];
    
    UILabel *nullItemStock = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.69, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
    nullItemStock.text = @"在庫なし";
    itemNumber.font = [UIFont fontWithName:@"AppleGothic" size:20];
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:nullItemStock margin:100])];
    
    //商品個数選択
    UILabel *itemnumber1 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
    itemnumber1.text = @"注文個数";
    itemnumber1.font = [UIFont fontWithName:@"AppleGothic" size:25];
    
    self.itemDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.itemDown.frame = CGRectMake(self.viewSize.width*0.52, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.08, 30);
    [self.itemDown setTitle:@"−" forState:UIControlStateNormal];
    self.itemDown.tintColor = [UIColor colorWithRed:0.110 green:0.553 blue:0.098 alpha:1.0];
    
    [self.itemDown addTarget:self action:@selector(tapItemDown:) forControlEvents:UIControlEventTouchDown];
    self.itemDown.font = [UIFont fontWithName:@"AppleGothic" size:30];
    
    self.inputItemNumber = [[UITextField alloc]initWithFrame:CGRectMake(self.viewSize.width*0.63,[Common getOrignYWidhUiView:itemPrice3 margin:30] , self.viewSize.width*0.1, 30)];
    self.inputItemNumber.borderStyle = UITextBorderStyleRoundedRect;
    self.inputItemNumber.textAlignment = UITextAlignmentCenter;
    self.inputItemNumber.delegate = self;
    self.inputItemNumber.enabled = NO;
    self.inputItemNumber.text = @"1";
    
    self.itemUp = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.itemUp.frame = CGRectMake(self.viewSize.width*0.75, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.08, 30);
    [self.itemUp setTitle:@"＋" forState:UIControlStateNormal];
    self.itemUp.tintColor = [UIColor colorWithRed:0.110 green:0.553 blue:0.098 alpha:1.0];
    
    [self.itemUp addTarget:self action:@selector(tapItemUp:) forControlEvents:UIControlEventTouchDown];
    self.itemUp.font = [UIFont fontWithName:@"AppleGothic" size:25];
    
    
    UILabel *itemnumber2 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.85, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.82, 30)];
    itemnumber2.text = @"個";
    itemnumber2.font = [UIFont fontWithName:@"AppleGothic" size:20];
    itemnumber2.textColor = [UIColor blackColor];
    
    //Lineで購入ボタン生成
    self.line_button = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width*0.25,[Common getOrignYWidhUiView:itemnumber1 margin:30] , self.viewSize.width*0.5, self.viewSize.height*0.1)];
    [self.line_button setTitle:@"LINEで購入" forState:UIControlStateNormal];
    [self.line_button addTarget:self
                         action:@selector(line_button_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.line_button.backgroundColor = [UIColor colorWithRed:0.110 green:0.553 blue:0.098 alpha:1.0];
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:self.line_button margin:100])];
    
    
    if([Common isNotEmptyString:self.itemStock]){
        
        if([self.itemStock isEqualToString:@"売り切れ"]){
            [self.uv addSubview:itemNumber];
            [self.uv addSubview:nullItemStock];
        }else{
            [self.uv addSubview:itemnumber1];
            [self.uv addSubview:itemnumber2];
            [self.uv addSubview:self.itemDown];
            [self.uv addSubview:self.inputItemNumber];
            [self.uv addSubview:self.itemUp];
            [self.uv addSubview:self.line_button];
        }
    }else if([self.itemStock isEqual:[NSNull null]]){
        self.itemStock = @"100";
        [self.uv addSubview:itemnumber1];
        [self.uv addSubview:itemnumber2];
        [self.uv addSubview:self.itemDown];
        [self.uv addSubview:self.inputItemNumber];
        [self.uv addSubview:self.itemUp];
        [self.uv addSubview:self.line_button];
    }

    [self.uv addSubview:lblBg];
    [self.uv addSubview:itemIv];
    [self.uv addSubview:itemTextLbl];
    [self.uv addSubview:itemPrice1];
    [self.uv addSubview:itemPrice2];
    [self.uv addSubview:itemPrice3];

    self.sv = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    self.sv.indicatorStyle = UIScrollViewIndicatorStyleDefault;
    [self.sv addSubview:self.uv];
    self.sv.contentSize = self.uv.bounds.size;
    [self.view addSubview:self.sv];
}

-(void)line_button_Tapeped:(id)sender
{
        //個数入力の判定（入力なし、０)
        NSString *str = self.inputItemNumber.text;
        DLog(@"%@",str);
        if([str isEqualToString:@"0"] || [str isEqualToString:@""])
        {
        
            UIAlertView *alertView =
            [[UIAlertView alloc] initWithTitle:@"商品個数"
                                       message:@"商品の注文数を入力してください"
                                  delegate:self
                             cancelButtonTitle:@"確認"
                             otherButtonTitles:nil
             ];
            [alertView show];
        }else{
            //注文個数をlinePayData.mに保持
            NSString *setItemNuber = [LinePayData getItemName];
            setItemNuber = str;
            DLog(@"%@",str);

            [self setLinePayData];
            // NSDictionaryの読み込み試験
            NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];

            NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    
            if ([Common isNotEmptyString:[profileDec objectForKey:@"SEI"]]
                &&[Common isNotEmptyString:[profileDec objectForKey:@"MEI"]]
                    &&[Common isNotEmptyString:[profileDec objectForKey:@"POST"]]
                       &&[Common isNotEmptyString:[profileDec objectForKey:@"ADDRESS1"]]
                        &&[Common isNotEmptyString:[profileDec objectForKey:@"TEL"]]
                            &&[Common isNotEmptyString:[profileDec objectForKey:@"MAILADDESSCHECK"]]) {
        
            LinepaySelectAddressViewController *vc = [[LinepaySelectAddressViewController alloc] initWithNibName:@"LinepaySelectAddressViewController" bundle:nil];
            vc.item_name = self.itemName;
            vc.item_price = self.itemPrice;
            vc.img_url = self.imgUrl;
            [self.navigationController pushViewController:vc animated:YES];
            } else {
                [self move_profileView];
            }
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

-(void)tapItemDown:(UIButton*)button{
    NSInteger itemNumber = [self.inputItemNumber.text intValue];
    if(itemNumber != 0){
        itemNumber--;
        self.inputItemNumber.text = [NSString stringWithFormat:@"%ld",(long)itemNumber];
        [self.uv addSubview:self.inputItemNumber];
    }
}

-(void)tapItemUp:(UIButton*)button{
    NSInteger itemNumber = [self.inputItemNumber.text intValue];
    NSInteger itemStock = [self.itemStock intValue];
    if(itemNumber  < itemStock){
        itemNumber++;
        self.inputItemNumber.text = [NSString stringWithFormat:@"%ld",(long)itemNumber];
        [self.uv addSubview:self.inputItemNumber];
    }else if(itemNumber == itemStock){
        [self overItemNum];
    }

}

-(void)overItemNum{
    UIAlertController *ac =
    [UIAlertController alertControllerWithTitle:@"注文数が上限です"
                                        message:@"これ以上注文できません"
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    // Cancel用のアクションを生成
    UIAlertAction *okAction =
    [UIAlertAction actionWithTitle:@"OK"
                             style:UIAlertActionStyleCancel
                           handler:^(UIAlertAction * action) {
                           }];
    
    [ac addAction:okAction];
    
    // アラート表示処理
    [self presentViewController:ac animated:YES completion:nil];
}


-(void)move_profileView{
    //PROFILE画面に移動
    LinepayProfileViewController *vc = [[LinepayProfileViewController alloc] initWithNibName:@"LinepayProfileViewController" bundle:nil];
    vc.item_name = self.itemName;
    vc.item_price = self.itemPrice;
    vc.img_url = self.imgUrl;
    [LinePayData setProductId:self.productId];
    
    vc.message = @"配送先を入力して下さい。";
//    ProfileViewController *vc = [[ProfileViewController alloc]initWithNibName:@"ProfileViewController" bundle:nil];
    NSMutableArray *cell_st = [NSMutableArray array];
    [cell_st addObject:[ProfileNameTableViewCell alloc]];
    [cell_st addObject:[ProfileAdressTableViewCell alloc]];
//    [cell_st addObject:[ProfileBirthdayTableViewCell alloc]];
//    [cell_st addObject:[ProfileAnniversaryTableViewCell alloc]];
    [cell_st addObject:[ProfileMailAddressTableViewCell alloc]];
    [cell_st addObject:[deliveryTimeTableViewCell alloc]];
    [cell_st addObject:[ProfileSendBtnTableViewCell alloc]];
    vc.cellList = cell_st;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end

