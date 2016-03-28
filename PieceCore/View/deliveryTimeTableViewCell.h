//
//  deliveryTimeTableViewCell.h
//  pieceSample
//
//  Created by shinden nobuyuki on 2016/03/25.
//  Copyright © 2016年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

@interface deliveryTimeTableViewCell : BaseInputCell


@property (weak, nonatomic) IBOutlet UIButton *noTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton *amBtn;
@property (weak, nonatomic) IBOutlet UIButton *twelveBtn;
@property (weak, nonatomic) IBOutlet UIButton *fourteenBtn;
@property (weak, nonatomic) IBOutlet UIButton *sixteenBtn;
@property (weak, nonatomic) IBOutlet UIButton *eighteenBtn;
@property (weak, nonatomic) IBOutlet UIButton *twentyBtn;


@end
