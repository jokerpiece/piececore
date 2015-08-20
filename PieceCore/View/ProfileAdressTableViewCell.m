//
//  ProfileAdressTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileAdressTableViewCell.h"

@implementation ProfileAdressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.adressTv.layer.borderWidth = 0.3;
    self.adressTv.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    self.adressTv.layer.cornerRadius = 8;
    
    //キーボード以外のところをタップするとキーボードが自動的に隠れる。
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(closeKeyboard)];
    [self.viewForBaselineLayout addGestureRecognizer:gestureRecognizer];

    // Configure the view for the selected state
}

-(void)closeKeyboard{
    //キーボード以外を押された時の処理
    [self.viewForBaselineLayout endEditing:YES];
}

-(void)setInputList {
    [self initInputList];
    [self.tfList addObject:self.postTf];
    [self.tvList addObject:self.adressTv];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
//    if([Common isNotEmptyString:recipient.address]){
//        self.adressTv.text = recipient.address;
//    }
//    if([Common isNotEmptyString:recipient.post]){
//        self.postTf.text = recipient.post;
//    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.post = self.postTf.text;
    recipient.address = self.adressTv.text;
}

- (IBAction)get_post:(id)sender {
    int max_post_Length = 7;
    NSMutableString *str = [self.postTf.text mutableCopy];
    //住所検索ボタンを押した時の処理
    self.adressTv.text = nil;
    
    //郵便番号未入力かどうかの判別
    if([str length] == 0)
    {
        //未入力の場合
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                        message:@"郵便番号を入力してください。"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"OK", nil];
        [alert show];
    }else if([str length] == max_post_Length){
        NSString *origin = @"http://zipcloud.ibsnet.co.jp/api/search?zipcode=";
        NSString *url = [NSString stringWithFormat:@"%@%@",origin,self.postTf.text];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",[array valueForKeyPath:@"results"]);
        NSString *json_str = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        NSLog(@"%@",json_str);
        
        for(NSDictionary *cor2 in array[@"results"])
        {
            NSLog(@"%@,%@,%@",cor2[@"address1"],cor2[@"address2"],cor2[@"address3"]);
            NSString *address_1 = cor2[@"address1"];
            NSString *address_2 = cor2[@"address2"];
            NSString *address_3 = cor2[@"address3"];
            self.adressTv.text = [NSString stringWithFormat:@"%@%@%@",address_1,address_2,address_3];
        }
    }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"入力エラー"
                                                            message:@"7桁の数字を入力してください"
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
            [alert show];
            
    }
}

- (void)didProfileSendButton{
    NSUserDefaults *profile_data = [NSUserDefaults standardUserDefaults];
    [profile_data setObject:self.postTf.text forKey:@"POST"];
    [profile_data synchronize];
    
    NSString *post = [profile_data stringForKey:@"POST"];
    NSLog(@"%@",post);
}

@end
