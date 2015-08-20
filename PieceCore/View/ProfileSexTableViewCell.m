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
    self.selectedBtn = SexBtnManSelect;
    self.manFrame.backgroundColor = [UIColor blueColor];
    self.womenFrame.backgroundColor = [UIColor clearColor];
}
- (IBAction)setWomanAction:(id)sender {
    self.selectedBtn = SexBtnWomanSelect;
    self.manFrame.backgroundColor = [UIColor clearColor];
    self.womenFrame.backgroundColor = [UIColor redColor];
}

-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
    if ([Common isNotEmptyString:recipient.sex]) {
        if (recipient.sex.intValue == 0) {
            self.selectedBtn = SexBtnManSelect;
            self.manFrame.backgroundColor = [UIColor blueColor];
            self.womenFrame.backgroundColor = [UIColor clearColor];
        } else if(recipient.sex.intValue == 1){
            self.selectedBtn = SexBtnWomanSelect;
            self.manFrame.backgroundColor = [UIColor clearColor];
            self.womenFrame.backgroundColor = [UIColor redColor];
        }
    }
}
-(void)saveDataWithProfileRecipient:(ProfileRecipient *)recipient{
    recipient.sex = [NSString stringWithFormat:@"%d",self.selectedBtn];
}
@end
