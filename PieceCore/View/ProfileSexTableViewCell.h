//
//  ProfileSexTableViewCell.h
//  pieceSample
//
//  Created by ハマモト  on 2015/03/20.
//  Copyright (c) 2015年 jokerpiece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseInputCell.h"

typedef enum {
    SexBtnNonSelect = -1,
    SexBtnManSelect,
    SexBtnWomanSelect
} SexBtnSelect;

@interface ProfileSexTableViewCell : BaseInputCell
@property (weak, nonatomic) IBOutlet UIButton *manBtn;
- (IBAction)setManAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *womanBtn;
- (IBAction)setWomanAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *manFrame;
@property (weak, nonatomic) IBOutlet UIView *womenFrame;
@property (nonatomic) SexBtnSelect selectedBtn;

@end
