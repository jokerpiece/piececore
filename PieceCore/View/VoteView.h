//
//  VoteView.h
//  pieceSample
//
//  Created by ハマモト  on 2015/10/15.
//  Copyright © 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface VoteView : UIView
@property (weak, nonatomic) IBOutlet UITextField *inputPointTf;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *Idoliv;
@property (weak, nonatomic) IBOutlet UILabel *rankLbl;
@property (weak, nonatomic) IBOutlet UILabel *pointLbl;
@property (weak, nonatomic) IBOutlet UITextView *messageTv;
@property (weak, nonatomic) IBOutlet UILabel *userPointLbl;
@property (nonatomic) NSString *userPoint;
@property (nonatomic) BaseViewController *parnentVc;
@property (nonatomic) NSString *twitterScrennId;
- (IBAction)voteAction:(id)sender;

@end
