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
    [LinePayData setKikakuName:self.detailKikakuName];
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
    UIImageView *itemIv = [[UIImageView alloc]
                           initWithFrame:CGRectMake(self.viewSize.width * 0.05,
                                                    NavigationHight + lblBg.frame.size.height + 30,
                                                    self.viewSize.width * 0.9,
                                                    self.viewSize.height * 0.45)];
    [itemIv setImageWithURL:imageURL
           placeholderImage:nil
                    options:SDWebImageCacheMemoryOnly
usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    itemIv.contentMode = UIViewContentModeScaleAspectFit;
    
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
    
    itemTextLbl.frame = CGRectMake(self.viewSize.width*0.05, [Common getOrignYWidhUiView:itemIv margin:20], self.viewSize.width*0.93, textSize.height);
    itemTextLbl.numberOfLines = 0;
    itemTextLbl.font = [UIFont fontWithName:@"AppleGothic" size:18];
    itemTextLbl.textColor = [UIColor blackColor];
    
    //商品様式
    self.dropDown = [DropDownField new];
    self.dropDown.adjustsFontSizeToFitWidth = YES;
    self.dropDown.delegate = self;
    
    self.dropDown.frame = CGRectMake(self.viewSize.width*0.05 ,[Common getOrignYWidhUiView:itemTextLbl margin:30], self.viewSize.width*0.9, 30);
    self.dropDown.text = [(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:0];
    self.detailKikakuName = [(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:0];
    self.dropDown.dropList = (NSArray*)[self.detailData valueForKey:@"kikaku_name"];
    self.dropDown.textAlignment = NSTextAlignmentLeft;
    self.dropDown.borderStyle = UITextBorderStyleRoundedRect;

    self.dropDown.font = [UIFont fontWithName:@"Arial-BoldMT" size:13];

    
    //商品価格
    UILabel *itemPrice1 = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:self.dropDown margin:30], self.viewSize.width*0.4, 30)];
    itemPrice1.text = @"販売価格";
    itemPrice1.font = [UIFont fontWithName:@"AppleGothic" size:20];
    itemPrice1.textColor = [UIColor blackColor];
    
    //商品価格表示
    self.itemPriceLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.6, [Common getOrignYWidhUiView:self.dropDown margin:30], self.viewSize.width*0.6, 30)];
    
    //商品規格に一つでも規格名があるか
    if([Common isNotEmptyString:[(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:0]]){
        self.itemPrice = [(NSArray*)[self.detailData valueForKey:@"price"] objectAtIndex:0];
        self.itemPriceLbl.text = [Common formatOfCurrencyWithString:self.itemPrice];
    }else{
        self.itemPriceLbl.text = [Common formatOfCurrencyWithString:self.itemPrice];
    }
    
    self.itemPriceLbl.text = [Common formatOfCurrencyWithString:self.itemPrice];
    self.itemPriceLbl.textAlignment = UITextLayoutDirectionRight;
    self.itemPriceLbl.font = [UIFont fontWithName:@"Arial-BoldMT" size:28];
    self.itemPriceLbl.textColor = [UIColor blackColor];
    [self.itemPriceLbl sizeToFit];
    
    UILabel *itemPrice3 = [[UILabel alloc] initWithFrame:CGRectMake(self.itemPriceLbl.frame.origin.x + self.itemPriceLbl.frame.size.width + 5, [Common getOrignYWidhUiView:self.dropDown margin:30], self.viewSize.width*0.82, 30)];
    itemPrice3.text = @"円";
    itemPrice3.font = [UIFont fontWithName:@"AppleGothic" size:20];
    itemPrice3.textColor = [UIColor blackColor];

    //在庫数判定

//    self.itemNumber = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
//    self.itemNumber.text = @"注文個数";
//    self.itemNumber.font = [UIFont fontWithName:@"AppleGothic" size:20];
    
    self.nullItemStock = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.69, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
    self.nullItemStock.text = @"在庫なし";
    self.itemNumber.font = [UIFont fontWithName:@"AppleGothic" size:20];
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:self.nullItemStock margin:100])];
    
    //商品個数選択
    self.orderQtyLbl = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.1, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.8, 30)];
    self.orderQtyLbl.text = @"注文個数";
    self.orderQtyLbl.font = [UIFont fontWithName:@"AppleGothic" size:25];
    
    self.itemDown = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.itemDown.frame = CGRectMake(self.viewSize.width*0.52, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.08, 30);
    [self.itemDown setTitle:@"−" forState:UIControlStateNormal];
    self.itemDown.tintColor = [UIColor colorWithRed:0.110 green:0.553 blue:0.098 alpha:1.0];
    
    [self.itemDown addTarget:self action:@selector(tapItemDown:) forControlEvents:UIControlEventTouchDown];
    self.itemDown.font = [UIFont fontWithName:@"AppleGothic" size:30];
    
    self.inputItemNumber = [[UITextField alloc]initWithFrame:CGRectMake(self.viewSize.width*0.63,[Common getOrignYWidhUiView:itemPrice3 margin:30] , self.viewSize.width*0.12, 30)];
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
    
    
    self.itemNumberTxt = [[UILabel alloc] initWithFrame:CGRectMake(self.viewSize.width*0.85, [Common getOrignYWidhUiView:itemPrice3 margin:30], self.viewSize.width*0.82, 30)];
    self.itemNumberTxt.text = @"個";
    self.itemNumberTxt.font = [UIFont fontWithName:@"AppleGothic" size:20];
    self.itemNumberTxt.textColor = [UIColor blackColor];
    
    //Lineで購入ボタン生成
    self.line_button = [[UIButton alloc] initWithFrame:CGRectMake(self.viewSize.width*0.25,[Common getOrignYWidhUiView:self.orderQtyLbl margin:30] , self.viewSize.width*0.5, self.viewSize.height*0.1)];
    [self.line_button setTitle:@"LINEで購入" forState:UIControlStateNormal];
    [self.line_button addTarget:self
                         action:@selector(line_button_Tapeped:)
               forControlEvents:UIControlEventTouchUpInside];
    self.line_button.backgroundColor = [UIColor colorWithRed:0.110 green:0.553 blue:0.098 alpha:1.0];
    
    self.uv = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.viewSize.width, [Common getOrignYWidhUiView:self.line_button margin:100])];
    
    
    if([Common isNotEmptyString:self.itemStock]){
        
        if([self.itemStock isEqualToString:@"売り切れ"]){
            [self.uv addSubview:self.orderQtyLbl];
            [self.uv addSubview:self.nullItemStock];
        }else{
            [self.uv addSubview:self.orderQtyLbl];
            [self.uv addSubview:self.itemNumberTxt];
            [self.uv addSubview:self.itemDown];
            [self.uv addSubview:self.inputItemNumber];
            [self.uv addSubview:self.itemUp];
            [self.uv addSubview:self.line_button];
        }
    }else if(![Common isNotEmptyString:self.itemStock] ){
        if ([Common isNotEmptyString:[(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:0]]) {
            self.itemStock = [(NSArray*)[self.detailData valueForKey:@"amount"] objectAtIndex:0];
            if(![Common isNotEmptyString:self.itemStock]){
                self.itemStock = @"10";
                [self.uv addSubview:self.orderQtyLbl];
                [self.uv addSubview:self.itemNumberTxt];
                [self.uv addSubview:self.itemDown];
                [self.uv addSubview:self.inputItemNumber];
                [self.uv addSubview:self.itemUp];
                [self.uv addSubview:self.line_button];
            }else if ([self.itemStock isEqualToString:@"0"]){
                [self.uv addSubview:self.orderQtyLbl];
                [self.uv addSubview:self.nullItemStock];
            }else{
                [self.uv addSubview:self.orderQtyLbl];
                [self.uv addSubview:self.itemNumberTxt];
                [self.uv addSubview:self.itemDown];
                [self.uv addSubview:self.inputItemNumber];
                [self.uv addSubview:self.itemUp];
                [self.uv addSubview:self.line_button];
            }
        }else{
            self.itemStock = @"10";
            [self.uv addSubview:self.orderQtyLbl];
            [self.uv addSubview:self.itemNumberTxt];
            [self.uv addSubview:self.itemDown];
            [self.uv addSubview:self.inputItemNumber];
            [self.uv addSubview:self.itemUp];
            [self.uv addSubview:self.line_button];
        }
    }else{
        [self.uv addSubview:self.orderQtyLbl];
        [self.uv addSubview:self.itemNumberTxt];
        [self.uv addSubview:self.itemDown];
        [self.uv addSubview:self.inputItemNumber];
        [self.uv addSubview:self.itemUp];
        [self.uv addSubview:self.line_button];

    }

    if([Common isNotEmptyString:[(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:0]]){
        [self.uv addSubview:lblBg];
        [self.uv addSubview:itemIv];
        //[self.uv addSubview:itemDetail];
        [self.uv addSubview:self.dropDown];
        [self.uv addSubview:itemTextLbl];
        [self.uv addSubview:itemPrice1];
        [self.uv addSubview:self.itemPriceLbl];
        [self.uv addSubview:itemPrice3];
    }else{
        [self.uv addSubview:lblBg];
        [self.uv addSubview:itemIv];
        [self.uv addSubview:itemTextLbl];
        [self.uv addSubview:itemPrice1];
        [self.uv addSubview:self.itemPriceLbl];
        [self.uv addSubview:itemPrice3];
    }
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
            [LinePayData setItemNumber:self.inputItemNumber.text];
            
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
}

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
    if(itemNumber != 1){
        itemNumber--;
        self.inputItemNumber.text = [NSString stringWithFormat:@"%ld",(long)itemNumber];
        [self.uv addSubview:self.inputItemNumber];
    }
}

-(void)tapItemUp:(UIButton*)button{
    NSInteger itemNumber = [self.inputItemNumber.text intValue];
    NSInteger itemStockInt = [self.itemStock intValue];
    
    if(itemNumber  < itemStockInt){
        itemNumber++;
        self.inputItemNumber.text = [NSString stringWithFormat:@"%ld",(long)itemNumber];
        [self.uv addSubview:self.inputItemNumber];
    }else if(itemNumber == itemStockInt){
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


- (void)selectKikakuName:(NSString *)kikakuName{
    
    NSInteger objectIndex = [(NSArray*)[self.detailData valueForKey:@"kikaku_name"] indexOfObject:kikakuName];
    
    self.kikakuNames = [(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:objectIndex];
    self.detailKikakuName = [(NSArray*)[self.detailData valueForKey:@"kikaku_name"] objectAtIndex:objectIndex];
    self.itemStock = [(NSArray*)[self.detailData valueForKey:@"amount"] objectAtIndex:objectIndex];
    self.itemPrice = [(NSArray*)[self.detailData valueForKey:@"price"] objectAtIndex:objectIndex];
    self.itemPriceLbl.text = [Common formatOfCurrencyWithString:self.itemPrice];
    
    if([self.itemStock isEqual:[NSNull null]]){
        self.itemStock = @"10";
        self.inputItemNumber.text = @"1";
        [self.nullItemStock removeFromSuperview];
        [self.uv addSubview:self.itemNumberTxt];
        [self.uv addSubview:self.line_button];
        [self.uv addSubview:self.itemUp];
        [self.uv addSubview:self.itemDown];
        [self.uv addSubview:self.inputItemNumber];
        [self.uv addSubview:self.itemPriceLbl];
        [self.uv addSubview:self.orderQtyLbl];
    }else if([self.itemStock isEqualToString:@"0"]){
        [self.line_button removeFromSuperview];
        [self.itemUp removeFromSuperview];
        [self.itemDown removeFromSuperview];
        [self.orderQtyLbl removeFromSuperview];
        [self.inputItemNumber removeFromSuperview];
        [self.itemNumberTxt removeFromSuperview];
        [self.uv addSubview:self.orderQtyLbl];
        [self.uv addSubview:self.nullItemStock];
    }else{
        self.inputItemNumber.text = @"1";
        [self.nullItemStock removeFromSuperview];
        [self.uv addSubview:self.itemNumberTxt];
        [self.uv addSubview:self.line_button];
        [self.uv addSubview:self.itemUp];
        [self.uv addSubview:self.itemDown];
        [self.uv addSubview:self.inputItemNumber];
        [self.uv addSubview:self.itemPriceLbl];
        [self.uv addSubview:self.orderQtyLbl];
    }
    [self.view setNeedsDisplay];
}

@end

