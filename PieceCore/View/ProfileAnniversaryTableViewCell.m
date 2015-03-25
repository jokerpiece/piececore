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

-(void)setDataWithProfileConnector:(ProfileConnector *)connector{
    if ([Common isNotEmptyString:connector.anniversary]) {
        self.anniversaryDayTf.text = connector.anniversary;
    }
    if([Common isNotEmptyString:connector.anniversary_name]){
        self.anniversaryNameTf.text = connector.anniversary_name;
    }
}
-(void)saveDataWithProfileConnector:(ProfileConnector *)connector{
    connector.anniversary = self.anniversaryDayTf.text;
    connector.anniversary_name = self.anniversaryNameTf.text;
}
@end
