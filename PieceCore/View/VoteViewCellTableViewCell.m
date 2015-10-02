//
//  VoteViewCellTableViewCell.m
//  pieceSample
//
//  Created by ohnuma on 2015/09/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import "VoteViewCellTableViewCell.h"

@implementation VoteViewCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    //キーボード以外のところをタップするとキーボードが自動的に隠れる。
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc]
                                                 initWithTarget:self
                                                 action:@selector(closeKeyboard)];
    [self.viewForBaselineLayout addGestureRecognizer:gestureRecognizer];
    
    [self.voteBtn addTarget:self
                     action:@selector(voteBtnTapped)
           forControlEvents:UIControlEventAllTouchEvents];
    

    // Configure the view for the selected state
}

-(void)closeKeyboard{
    //キーボード以外を押された時の処理
    [self.viewForBaselineLayout endEditing:YES];
}

-(void)voteBtnTapped{
    //入力されたpointを保持
    NSUserDefaults *inputPointData = [NSUserDefaults standardUserDefaults];
    [inputPointData setObject:self.inputPointTf.text forKey:@"INPUT_POINT"];
    [inputPointData synchronize];
}

@end
