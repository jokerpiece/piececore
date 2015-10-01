//
//  TwitterTableViewCell.h
//  pieceSample
//
//  Created by ohnuma on 2015/09/24.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitterTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *twitterUserImg;
@property (weak, nonatomic) IBOutlet UILabel *twitterTextLbl;
@property (weak, nonatomic) IBOutlet UILabel *twitterIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *twitterTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *twitterUserNameLbl;

@end
