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
    [self setBorderTv:self.address1Tv];
    [self setBorderTv:self.address2Tv];
    [self setBorderTv:self.address3Tv];
    
    //キーボード以外のところをタップするとキーボードが自動的に隠れる。
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(closeKeyboard)];
    [self.viewForBaselineLayout addGestureRecognizer:gestureRecognizer];

    // Configure the view for the selected state
}
-(void)setBorderTv:(UITextView *)tv{
    tv.layer.borderWidth = 0.3;
    tv.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    tv.layer.cornerRadius = 8;
}
-(void)closeKeyboard{
    //キーボード以外を押された時の処理
    [self.viewForBaselineLayout endEditing:YES];
}

-(void)setInputList {
    [self initInputList];
    [self.tfList addObject:self.postTf];
    [self.tvList addObject:self.address1Tv];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if ([Common isNotEmptyString:recipient.address1]){
        self.address1Tv.text = recipient.address1;
    }
    if ([Common isNotEmptyString:recipient.address2]){
        self.address2Tv.text = recipient.address2;
    }
    if ([Common isNotEmptyString:recipient.address3]){
        self.address3Tv.text = recipient.address3;
    }
    if([Common isNotEmptyString:recipient.post]){
        self.postTf.text = recipient.post;
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.post = self.postTf.text;
    recipient.address1 = self.address1Tv.text;
    recipient.address2 = self.address2Tv.text;
    recipient.address3 = self.address3Tv.text;
}

- (IBAction)get_post:(id)sender {
    int max_post_Length = 7;
    NSMutableString *str = [self.postTf.text mutableCopy];
    //住所検索ボタンを押した時の処理
    self.address1Tv.text = nil;
    self.address2Tv.text = nil;
    self.address3Tv.text = nil;
    
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
    } else if([str length] == max_post_Length){
        NSString *origin = @"http://zipcloud.ibsnet.co.jp/api/search?zipcode=";
        NSString *url = [NSString stringWithFormat:@"%@%@",origin,self.postTf.text];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        NSData *json = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        NSDictionary *array = [NSJSONSerialization JSONObjectWithData:json options:NSJSONReadingAllowFragments error:nil];
        DLog(@"%@",[array valueForKeyPath:@"results"]);
        NSString *json_str = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
        DLog(@"%@",json_str);
        
        for(NSDictionary *cor2 in array[@"results"])
        {
            DLog(@"%@,%@,%@",cor2[@"address1"],cor2[@"address2"],cor2[@"address3"]);
            self.address1Tv.text = cor2[@"address1"];
            self.address2Tv.text = cor2[@"address2"];
            self.address3Tv.text = cor2[@"address3"];
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
    DLog(@"%@",post);
}

@end
