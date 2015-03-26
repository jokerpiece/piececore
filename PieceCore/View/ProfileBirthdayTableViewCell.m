//
//  ProfileBirthdayTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileBirthdayTableViewCell.h"

@implementation ProfileBirthdayTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInputList {
    [self initInputList];
    [self.datePickerList addObject:self.birthdayTf];
}
-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if ([Common isNotEmptyString:recipient.berth_day]) {
        self.birthdayTf.text = recipient.berth_day;
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.berth_day = self.birthdayTf.text;
}
@end
