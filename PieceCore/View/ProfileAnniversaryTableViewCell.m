//
//  ProfileAnniversaryTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileAnniversaryTableViewCell.h"

@implementation ProfileAnniversaryTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInputList {
    [self initInputList];
    [self.monthDayPickerList addObject:self.anniversaryDayTf];
    [self.tfList addObject:self.anniversaryNameTf];
}

-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if ([Common isNotEmptyString:recipient.anniversary]) {
        self.anniversaryDayTf.text = recipient.anniversary;
    }
    if([Common isNotEmptyString:recipient.anniversary_name]){
        self.anniversaryNameTf.text = recipient.anniversary_name;
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.anniversary = self.anniversaryDayTf.text;
    recipient.anniversary_name = self.anniversaryNameTf.text;
}
@end
