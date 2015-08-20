//
//  ProfileNameTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

@interface ProfileNameTableViewCell : BaseInputCell
@property (weak, nonatomic) IBOutlet UITextField *seiTf;
@property (weak, nonatomic) IBOutlet UITextField *meiTf;

@end
