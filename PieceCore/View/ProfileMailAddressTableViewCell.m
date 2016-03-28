//
//  ProfileMailAddressTableViewCell.m
//  pieceSample
//
//  Created by shinden nobuyuki on 2016/03/22.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import "ProfileMailAddressTableViewCell.h"

@implementation ProfileMailAddressTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //キーボード以外のところをタップするとキーボードが自動的に隠れる。
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self action:@selector(closeKeyboard)];
    [self.viewForBaselineLayout addGestureRecognizer:gestureRecognizer];
    // Configure the view for the selected state
}

-(void)closeKeyboard{
    //キーボード以外を押された時の処理
    [self.superview.superview.superview endEditing:YES];
}

-(void)setInputList {
    [self initInputList];
    [self.tfList addObject:self.mailTf];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if([Common isNotEmptyString:recipient.mail_address]){
        self.mailTf.text = recipient.mail_address;
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.mail_address = self.mailTf.text;
}

@end
