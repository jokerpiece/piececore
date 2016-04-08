//
//  ProfileMailAddressTableViewCell.h
//  pieceSample
//
//  Created by shinden nobuyuki on 2016/03/22.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

@interface ProfileMailAddressTableViewCell : BaseInputCell
@property (weak, nonatomic) IBOutlet UITextField *mailTf;
@property (weak, nonatomic) IBOutlet UITextField *mailCheckTf;
@property (weak, nonatomic) IBOutlet UITextField *phoneTf;

@end
