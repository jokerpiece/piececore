//
//  LinepaySelectAddressViewController.m
//  pieceSample
//
//  Created by ハマモト  on 2015/10/01.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import "LinepaySelectAddressViewController.h"
#import "linepayReservSquareViewController.h"
#import "LinepayProfileViewController.h"

@interface LinepaySelectAddressViewController ()

@end

@implementation LinepaySelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    NSDictionary* profileDec = [ud dictionaryForKey:@"PROFILE"];
    self.addressLbl.text = [NSString stringWithFormat:@"%@%@%@",[profileDec objectForKey:@"ADDRESS1"],[profileDec objectForKey:@"ADDRESS2"],[profileDec objectForKey:@"ADDRESS3"]];
    self.lastNameLbl.text = [profileDec objectForKey:@"SEI"];
    self.firstNameLbl.text = [profileDec objectForKey:@"MEI"];
    self.mailLbl.text = [profileDec objectForKey:@"MAILADDRESS"];
    self.telLbl.text = [profileDec objectForKey:@"TEL"];
    
}

- (IBAction)sameAddressBtn:(id)sender {
    [self move_profileView:YES];
}

- (IBAction)otherAddressBtn:(id)sender {
    [self move_profileView:NO];
}

-(void)move_profileView:(BOOL)setCellFlg{
    //PROFILE画面に移動
    LinepayProfileViewController *vc = [[LinepayProfileViewController alloc] initWithNibName:@"LinepayProfileViewController" bundle:nil];
    vc.item_name = self.item_name;
    vc.item_price = self.item_price;
    vc.img_url = self.img_url;
//    [LinePayData setProductId:self.productId];
    
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
    vc.isSameProfileFlg = setCellFlg;
    [self.navigationController pushViewController:vc animated:YES];
    
}


//-(void)callLinePayVC{
//
//    linepay_ViewController *vc = [[linepay_ViewController alloc] initWithNibName:@"linepay_ViewController" bundle:nil];
//    
//    //商品の名前を格納
//    vc.item_name = self.item_name;
//    vc.productId = self.productId;
//    //商品画像格納
//    vc.img_url = self.img_url;
//    UIImageView *item_Image = [[UIImageView alloc] init];
//    NSURL *imageURL = [NSURL URLWithString:[self.img_url stringByAddingPercentEscapesUsingEncoding:
//                                            NSUTF8StringEncoding]];
//    item_Image.frame = CGRectMake(60, 150, 200, 200);
//    [item_Image setImageWithURL:imageURL
//               placeholderImage:nil
//                        options:SDWebImageCacheMemoryOnly
//    usingActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    vc.itemImgUrl = self.img_url;
//    
//    //商品説明格納
//    vc.item_text = self.item_text;
//    
//    //商品価格格納
//    vc.item_price = self.item_price;
//    
//    //画面遷移格納
//    [self.navigationController pushViewController:vc  animated:YES];
//}


@end
