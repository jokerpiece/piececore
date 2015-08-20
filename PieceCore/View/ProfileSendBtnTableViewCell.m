//
//  ProfileSendBtnTableViewCell.m
//  pieceSample
//
//  Created by ハマモト  on 2015/03/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "ProfileSendBtnTableViewCell.h"

@implementation ProfileSendBtnTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setInputList {
    [self initInputList];
}

- (void)didProfileSendButton
{
    
}

-(void)setDataWithProfileRecipient:(ProfileRecipient *)recipient{
}

- (IBAction)sendBtn:(id)sender {
    [self.delegate didProfileSendButton];
}

@end
