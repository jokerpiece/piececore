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
-(void)setDataWithProfileConnector:(ProfileConnector *)connector{
    if([Common isNotEmptyString:connector.address]){
        self.adressTv.text = connector.address;
    }
    if([Common isNotEmptyString:connector.post]){
        self.postTf.text = connector.post;
    }
}
-(void)saveDataWithProfileConnector:(ProfileConnector *)connector{
    connector.post = self.postTf.text;
    connector.address = self.adressTv.text;
}
@end
