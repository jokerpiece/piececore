//
//  ProfileSexTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileSexTableViewCell.h"

@implementation ProfileSexTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)setManAction:(id)sender {
    self.manFrame.backgroundColor = [UIColor blueColor];
    self.womenFrame.backgroundColor = [UIColor clearColor];
}
- (IBAction)setWomanAction:(id)sender {
    self.manFrame.backgroundColor = [UIColor clearColor];
    self.womenFrame.backgroundColor = [UIColor redColor];
}
@end
