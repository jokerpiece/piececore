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

    // Configure the view for the selected state
}
-(void)setInputList {
    [self initInputList];
    [self.tfList addObject:self.postTf];
    [self.tvList addObject:self.adressTv];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if([Common isNotEmptyString:recipient.address]){
        self.adressTv.text = recipient.address;
    }
    if([Common isNotEmptyString:recipient.post]){
        self.postTf.text = recipient.post;
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.post = self.postTf.text;
    recipient.address = self.adressTv.text;
}
@end
