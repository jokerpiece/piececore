//
//  VoteViewCellTableViewCell.h
//  pieceSample
//
//  Created by ohnuma on 2015/09/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TwitterViewController.h"

@interface VoteViewCellTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *selectedNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *selectedUserImg;
@property (weak, nonatomic) IBOutlet UILabel *selectedUserPointLbl;
@property (weak, nonatomic) IBOutlet UILabel *selectedUserTextLbl;
@property (weak, nonatomic) IBOutlet UILabel *keepPointLbl;
@property (weak, nonatomic) IBOutlet UITextField *inputPointTf;
@property (weak, nonatomic) IBOutlet UIButton *voteBtn;

@end
