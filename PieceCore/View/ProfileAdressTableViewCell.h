//
//  ProfileAdressTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"
#import "ProfileSendBtnTableViewCell.h"

@interface ProfileAdressTableViewCell : BaseInputCell
@property (weak, nonatomic) IBOutlet UITextField *postTf;
@property (weak, nonatomic) IBOutlet UITextView *adressTv;
- (IBAction)get_post:(id)sender;

@end
