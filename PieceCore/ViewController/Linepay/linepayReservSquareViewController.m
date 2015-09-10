//
//  linepayReservSquareViewController.m
//  pieceSample
//
//  Created by ohnuma on 2015/07/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "linepayReservSquareViewController.h"

@interface linepayReservSquareViewController ()

@end

@implementation linepayReservSquareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect screen = [[UIScreen mainScreen] bounds];
    NSLog(@"%f,%f", screen.size.width, screen.size.height);
    
    
    
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
    NSString *str = NULL;
    NSString *get_item_name = [Setdata getname:str];
    self.item_name.text = get_item_name;
    
    NSString *str1 = NULL;
    NSString *get_item_price = [Setdata getprice:str1];
    self.item_price.text = get_item_price;
    
    NSString *str2 = NULL;
    NSString *get_postage = [Setdata getpostage:str2];
    self.postage.text = get_postage;
    
    //送料計算
    NSInteger item_price = get_item_price.intValue;
    NSInteger postage = get_postage.intValue;
    int amount_sum = item_price + postage;
    NSString *amount_sum_2 = [NSString stringWithFormat:@"%d",amount_sum];
    self.amount.text = amount_sum_2;
    
    NSLog(@"%@",get_item_name);
    NSLog(@"%@",get_item_price);
    NSLog(@"%@",get_postage);
    NSLog(@"%@",amount_sum_2);
    
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

- (IBAction)reserv:(id)sender {
     //LINEPay決済送信、アプリ内決済登録
    NSString *str = NULL;
    NSString *get_transaction = [Setdata gettransaction:str];
    
    NetworkConecter *conecter = [NetworkConecter alloc];
    conecter.delegate = self;
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setValue:get_transaction forKey:@"transaction"];
    [param setValue:self.amount.text forKey:@"amount"];
    [conecter sendActionSendId:SendIdDeterminedLinePay param:param];
    
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"注文確定"
                                                   message:@"購入ありがとうございます"
                                                  delegate:self
                                         cancelButtonTitle:nil
                                         otherButtonTitles:@"OK", nil];
    [alert show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSInteger count = self.navigationController.viewControllers.count - 3;
    ItemListViewController *vc = [self.navigationController.viewControllers objectAtIndex:count];
    [self.navigationController popToViewController:vc animated:YES];

}

    
- (IBAction)cancel:(id)sender {
    NSInteger count = self.navigationController.viewControllers.count - 3;
    ItemListViewController *vc = [self.navigationController.viewControllers objectAtIndex:count];
    [self.navigationController popToViewController:vc animated:YES];
}
@end
