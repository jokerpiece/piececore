//
//  ProfileNameTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileNameTableViewCell.h"

@implementation ProfileNameTableViewCell


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInputList {
    [self initInputList];
    [self.tfList addObject:self.seiTf];
    [self.tfList addObject:self.meiTf];
}
-(void)setDataWithProfileConnector:(ProfileConnector *)connector{
    if([Common isNotEmptyString:connector.sei]){
        self.seiTf.text = connector.sei;
    }
    if([Common isNotEmptyString:connector.mei]){
        self.meiTf.text = connector.mei;
    }
}
-(void)saveDataWithProfileConnector:(ProfileConnector *)connector{
    connector.sei = self.seiTf.text;
    connector.mei = self.meiTf.text;
}
@end
