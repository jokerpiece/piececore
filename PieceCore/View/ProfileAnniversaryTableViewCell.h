//
//  ProfileAnniversaryTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

@interface ProfileAnniversaryTableViewCell : BaseInputCell
@property (weak, nonatomic) IBOutlet UITextField *anniversaryNameTf;
@property (weak, nonatomic) IBOutlet UITextField *anniversaryDayTf;

@end
