//
//  ProfileSendBtnTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/25.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

@interface ProfileSendBtnTableViewCell : BaseInputCell
- (IBAction)sendBtn:(id)sender;
@property (nonatomic,weak) id delegate;
@end

@protocol ProfileSendBtnDelegate
- (void)didProfileSendButton;
@end